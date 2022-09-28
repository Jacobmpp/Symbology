class BattleScreen extends Screen{
    Player player;
    Enemy enemy;
    GameBoard grid;
    PowerUp powerUps[];

    public void mousePressed(int x, int y){
        if(!(x>=size||x<0||y>=size||y<0)){
            subState[x][y] = !subState[x][y];
            update();
        }
    }

}
