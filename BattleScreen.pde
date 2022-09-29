class BattleScreen extends Screen{
    Player player;
    Enemy enemy;
    GameBoard grid;
    PowerUp powerUps[];

    public BattleScreen(float margin_, float gameWidth_, Player player_){
        super(margin_, gameWidth_);
        player = player_;
        enemy = new Enemy(player.getLevel());
        GameBoard grid = new GameBoard((int)gameWidth_);
    }

    public void mousePressed(int mx, int my){
        int size = grid.getState().getSize();
        int x = floor((mx-margin)/(gameWidth/size));
        int y = floor((my-margin)/(gameWidth/size));
        if(!(x>=size||x<0 || y>=size||y<0)){
            grid.getState().click(x,y);
        }
    }

    public void show(boolean debug){
        
    }
}
