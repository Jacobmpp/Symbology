class PowerUp{
    String name;
    int count;
    int resize;
    char stat;
    int magnatude;
    PImage favicon;

    PowerUp(String name_, )

    public void show(float x, float y, float w, float h) {
        favicon.resize(w, h);
        image(favicon, x, y);
    }

    public boolean use(GameBoard gb){
        if(count > 0){
            if(resize!=0){
                bb.resize(gb.getSize()+resize);
            }
            count--;
            return true;
        }
        return false;
    }

    public boolean use(Player p){
        if(count > 0){
            p.effect(stat, magnatude);
            count--;
            return true;
        }
        return false;
    }
}