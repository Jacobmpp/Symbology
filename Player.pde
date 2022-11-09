class Player{

    private int hp;
    private int maxHp;
    private int level;
    public Spellbook spellbook;
    private int currency;

    public Player(int maxHp_, int level_){
        maxHp = maxHp_;
        hp = maxHp_;
        level = level_;
        spellbook = new Spellbook("spells.dat", "0");
        currency = 0;
    }

    public void takeDamage(int damage){
        hp-=damage;
    }

    public void effect(char stat){
        switch(stat) {
            case 'h':
                hp = maxHp;
                break;
            case 'l':
                level++;
                break;
        }
    }

    public int getLevel(){
      return level;
    }

    public boolean alive(){
        return hp > 0;
    }

    public void revive(){
        hp = maxHp;
    }

    void setCurrency(int currency_){
        currency = currency_;
    }

    int getCurrency(){
        return currency;
    }

    public void showHp(float x, float y, float w, float h, Theme t){
        float edge = map(hp,0,maxHp,0,w);
        edge = min(edge - edge%(w/(maxHp/50)) + w/(maxHp/50), w);
        fill(t.getOff());
        rect(x+edge,y,w-edge,h);
        fill(t.getOn());
        rect(x, y, edge, h);
    }
}
