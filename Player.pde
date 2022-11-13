class Player{

    private int hp;
    private int maxHp;
    private int level;
    public Spellbook spellbook;
    private int currency;

    public Player(int maxHp_, int level_, int currency_){
        maxHp = maxHp_;
        hp = maxHp_;
        level = level_;
        spellbook = new Spellbook("spells.dat", "0");
        currency = currency_;
    }

    public Player(String encoded){
        this(encoded.split(";"));
    }

    public Player(String[] parts){
        this(parseInt(parts[0]),parseInt(parts[1]),parseInt(parts[2]));
        spellbook.updateAvailableSpells(parts[3]);
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
        float edge = map(hp,0,maxHp,7*w/64,w);
        edge = min(edge - edge%(w/(maxHp/50)) + w/(maxHp/50), w);
        fill(t.getOff());
        rect(x+edge,y+h/20,w-edge,9*h/10);
        fill(t.getOn());
        rect(x, y+h/20, edge, 9*h/10);
        image(t.playerHealthBar, x, y, w, h);
    }

    public String toString(){
        String out = "";
        out += maxHp + ";";
        out += level + ";";
        out += currency + ";";
        out += spellbook.getAvailableSpells();
        return out;
    }
}
