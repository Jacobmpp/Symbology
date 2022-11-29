import java.util.concurrent.*;
class BattleScreen extends Screen{
    Player player; // Stores player stats and Spell book
    Enemy enemy;
    GameBoard gameBoard; // Wraps a State with rendering data and methods
    PowerUp powerUps[];
    int lastX, lastY; // The x, y position of the mouse when the mouse was last clicked
    ArrayList<Particle> particles = new ArrayList<Particle>(100);

    public BattleScreen(int width_, int height_, Player player_, PowerUp powerUps_[]){
        super(width_, height_);
        player = player_;
        enemy = new Enemy(player.getLevel());
        gameBoard = new GameBoard((int)gameWidth);
        powerUps = powerUps_;
    }

    public void mousePressed(int mx, int my){
        // store the position of the mouse / finger when the mouse was pressed down
        lastX = mx;
        lastY = my;
        // allow spellbook to move
        player.spellbook.toggleable = true;
    }

    public void mouseReleased(int mx, int my){
        player.spellbook.toggleable = false;
        float displacement = map(lastX-mouseX, 0, 2*margin, 0, 1); // check how much the user has swiped
        if(displacement > 0.5)player.spellbook.visible = true; // lock the spellbook in place if it is sufficiently on screen
        if(displacement <-0.5)player.spellbook.visible = false; // stow the spellbook if it is swiped off sufficiently

        // if you click the gameBoard while the spellbook is not open:
        if(!player.spellbook.visible && pow(lastX-mx, 2)+pow(lastY-my, 2)<pow(margin/2, 2)){
            gameBoard.click(mx, my); // tell the board
            Spell currentBoardSpell = player.spellbook.getSpell(gameBoard.getEncoded()); // get the spell from spellbook if there is one
            if(currentBoardSpell!=null && currentBoardSpell.available){ // if there is a spell
                int damageTaken = enemy.takeDamage(currentBoardSpell.damage, currentBoardSpell.type);
                gameBoard.scramble();
                for(int i = currentBoardSpell.damage; i > 0; i >>= 1){
                    println(gameBoard.center.x + ", " + gameBoard.center.y + "->" + (log(currentBoardSpell.damage*5)*width/90));
                    addParticle(new Particle(gameBoard.center.x, gameBoard.center.y, random(-width/40, width/40), random(-width/40, width/40), 20, log(currentBoardSpell.damage*5)*width/90, typeToTint(currentBoardSpell.type)));
                }
                for(int i = damageTaken; i > 0; i >>= 1){
                    addParticle(new Particle(enemy.center.x, enemy.center.y, random(-width/40, width/40), random(-width/40, width/40), 20, log(damageTaken*5)*width/90, typeToTint(currentBoardSpell.type)));
                }
                if(!enemy.alive()){ // if you kill the enemy, make a new one
                    player.level++;
                    int currencyEarned = floor(enemy.maxHp * random(8, 12));
                    for(int i = currencyEarned; i > 0; i >>= 1){
                        addParticle(new Particle(enemy.center.x, enemy.center.y, random(-width/40, width/40), random(-width/40, width/40), 2000000, width/2, height*1.5, log(currencyEarned*5)*width/90, randomGoldColor(), 0, height/2));
                    }
                    player.earnCurrency(currencyEarned);
                    enemy = new Enemy(player.level);
                }
            }
        }
        
        // if you click a powerUp without the spellbook open
        if(!player.spellbook.visible && mx==constrain(mx, wid/10, 9*wid/10) && my==constrain(my, (hei/2+gameWidth/2+hei-margin-wid/5)/2, (hei/2+gameWidth/2+hei-margin+wid/5)/2)){
            int x = floor((mx-wid/10)/(wid/5)); // which one
            if(x == constrain(x, 0, 3)) // anti-nullPointerException measures
                powerUps[x].use(gameBoard);
        }
        else player.spellbook.click(mx, my, this);
    }

    public boolean update(Theme theme){
        theme.update();
        LinkedBlockingQueue<Particle> removalQ = new LinkedBlockingQueue<Particle>();
        for(Particle p : particles){
            p.update();
            if(p.inactive())
                removalQ.offer(p);
        }
        while(!removalQ.isEmpty()){
            particles.remove(removalQ.poll());
        }
        if(!player.spellbook.visible)player.takeDamage(enemy.getDamage());
        return player.alive();
    }

    public void show(Theme theme, boolean debug){
        background(theme.getBackground());
        image(theme.getBackgroundImage(), 0, 0);
        enemy.showHp(0, 0, wid, wid/64*9, theme);
        enemy.show(wid/2-margin, (hei/2-gameWidth/2-margin)/2, margin*2, margin*2);
        gameBoard.show(wid/2-gameWidth/2, hei/2-gameWidth/2, gameWidth, theme.getOn(), theme.getOff(), debug);
        for(int i=0; i<4; i++){
            powerUps[i].show(wid/10 * (1+2*i), (hei/2+gameWidth/2+hei-margin-wid/5)/2, wid/5, wid/5);
        }
        for(Particle p : particles){
            p.show();
        }
        player.showHp(0, hei-width/64*9, wid, wid/64*9, theme);
        player.spellbook.show(map(lastX-mouseX, 0, 2*margin, 0, 1), wid-1.5*margin, hei-3*margin, this, theme);
    }

    public void addParticleP(Particle p){
        particles.add(p);
    }

    private color randomGoldColor(){
        float randomVal = random(0,100);
        int red = floor(map(randomVal, 0, 100, 184, 250));
        int gre = floor(map(randomVal, 0, 100, 132, 243));
        int blu = floor(map(randomVal, 0, 100, 68, 149));
        return color(red, gre, blu);
    }
}
