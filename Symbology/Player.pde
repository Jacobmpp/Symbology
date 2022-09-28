class Player{

    private int hp;
    private int level;
    private Spellbook spellbook;

    public Player(int hp_, int level_){
        hp = hp_;
        level = level_;
        spellbook = new Spellbook("spells.dat");
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
}
