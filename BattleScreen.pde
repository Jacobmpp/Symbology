class BattleScreen extends Screen{
    Player player;
    Enemy enemy;
    GameBoard grid;
    PowerUp powerUps[];

    public BattleScreen(int width_, int height_, Player player_){
        super(width_, height_);
        player = player_;
        enemy = new Enemy(player.getLevel());
        grid = new GameBoard((int)gameWidth);
    }

    public void mousePressed(int mx, int my){
        grid.click(mx, my);
    }

    public void show(Theme theme, boolean debug){
        background(theme.getBackground());
        enemy.show(wid/2-margin, margin, margin*2, margin*2);
        //enemy.showHP();
        grid.show(wid/2-gameWidth/2, hei-margin-gameWidth, gameWidth, theme.getOn(), theme.getOff(), debug);
        //player.showHP();
    }
}
