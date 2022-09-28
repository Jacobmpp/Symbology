class Player{

    private int hp;
    private Spellbook spellbook;

    public void effect(char stat, int mag){
        switch(stat) {
            case 'h':
                hp+=mag;
                break;
        }
    }
}
