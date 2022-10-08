class Player{

    private int hp;
    private int maxHp;
    private int level;
    public Spellbook spellbook;

    public Player(int maxHp_, int level_){
        maxHp = maxHp_;
        hp = maxHp_;
        level = level_;
        spellbook = new Spellbook("spells.dat", "0");
    }

    public void effect(char stat, int mag){
        switch(stat) {
            case 'h':
                hp+=mag;
                break;
        }
    }
    
    public int getLevel(){
      return level;
    }

    public void showHp(float x, float y, float w, float h, Theme t){
        float edge = map(hp,0,maxHp,0,w);
        edge = min(edge - edge%(w/15) + w/15, w);
        fill(t.getOff());
        rect(x+edge,y,w-edge,h);
        fill(t.getOn());
        rect(x, y, edge, h);
    }
}
