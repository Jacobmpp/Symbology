class BattleScreen extends Screen{
    Player player;
    Enemy enemy;
    GameBoard grid;
    PowerUp powerUps[];
    int lastX, lastY;

    public BattleScreen(int width_, int height_, Player player_){
        super(width_, height_);
        player = player_;
        enemy = new Enemy(player.getLevel());
        grid = new GameBoard((int)gameWidth);
    }

    public void mousePressed(int mx, int my){
        lastX = mx;
        lastY = my;
        if(player.spellbook.visible || !grid.onBoard(mx, my))player.spellbook.toggleable = true;
        if(!player.spellbook.visible)grid.click(mx, my);
        else player.spellbook.click(mx,my, this);
    }

    public void mouseReleased(int mx, int my){
        player.spellbook.toggleable = false;
    }

    public void show(Theme theme, boolean debug){
        theme.update();
        background(theme.getBackground());
        image(theme.getBackgroundImage(),0,0,width,height);
        enemy.show(wid/2-margin, margin, margin*2, margin*2);
        enemy.showHp(0, 0, width, margin/2, theme);
        grid.show(wid/2-gameWidth/2, hei-margin-gameWidth, gameWidth, theme.getOn(), theme.getOff(), debug);
        player.showHp(0,height-margin/2, width, margin/2, theme);
        player.spellbook.show(map(lastX-mouseX, 0, 2*margin, 0, 1), gameWidth, gameWidth+2*margin, this, theme);
    }
}
