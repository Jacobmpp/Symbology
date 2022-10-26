class BattleScreen extends Screen{
    Player player; // Stores player stats and Spell book
    Enemy enemy;
    GameBoard gameBoard; // Wraps a State with rendering data and methods
    PowerUp powerUps[];
    int lastX, lastY; // The x,y position of the mouse when the mouse was last clicked

    public BattleScreen(int width_, int height_, Player player_, PowerUp powerUps_[]){
        super(width_, height_);
        player = player_;
        enemy = new Enemy(player.getLevel());
        gameBoard = new GameBoard((int)gameWidth);
        powerUps = powerUps_;
    }

    public void mousePressed(int mx, int my){
        lastX = mx;
        lastY = my;
        player.spellbook.toggleable = true;
    }

    public void mouseReleased(int mx, int my){
        player.spellbook.toggleable = false;
        float displacement = map(lastX-mouseX, 0, 2*margin, 0, 1);
        if(displacement > 0.5)player.spellbook.visible = true;
        if(displacement <-0.5)player.spellbook.visible = false;
        if(!player.spellbook.visible && pow(lastX-mx,2)+pow(lastY-my, 2)<pow(margin/2,2)){
            gameBoard.click(mx, my);
            Spell temp = player.spellbook.getSpell(gameBoard.getEncoded());
            if(temp!=null){
                enemy.takeDamage(temp.damage, temp.type);
                gameBoard.scramble();
                if(!enemy.alive()){
                    player.level++;
                    enemy = new Enemy(player.level);
                }
            }
        }
        if(mx==constrain(mx, wid/10, 9*wid/10)&&my==constrain(my, hei/3.2 + gameWidth*1.1 + margin/2, hei/3.2 + gameWidth*1.1 + margin/2 + wid/5)){
            int x = floor((mx-wid/10)/(wid/5));
            if(x == constrain(x, 0, 3))
                powerUps[x].use(gameBoard);
        }
        else player.spellbook.click(mx,my, this);
    }

    public boolean update(Theme theme){
        theme.update();
        if(!player.spellbook.visible)player.takeDamage(enemy.getDamage());
        return player.alive();
    }

    public void show(Theme theme, boolean debug){
        background(theme.getBackground());
        image(theme.getBackgroundImage(),0,0,wid,hei);
        enemy.show(wid/2-margin, margin, margin*2, margin*2);
        enemy.showHp(0, 0, wid, margin/2, theme);
        gameBoard.show(wid/2-gameWidth/2, hei/3.2, gameWidth, theme.getOn(), theme.getOff(), debug);
        player.showHp(0,height-margin/2, width, margin/2, theme);
        player.spellbook.show(map(lastX-mouseX, 0, 2*margin, 0, 1), wid-1.5*margin, gameWidth+2*margin, this, theme);
        for(int i=0; i<4; i++){
            powerUps[i].show(wid/10 * (1+2*i), hei/3.2 + gameWidth*1.1 + margin/2, wid/5, wid/5);
        }
    }
}
