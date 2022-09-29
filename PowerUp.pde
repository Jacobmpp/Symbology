class PowerUp{
    String name;
    int count;
    int resize;
    char stat;
    int magnitude;
    PImage favicon;

    public PowerUp(String name_, int count_, int resize_){
      name = name_;
      count = count_;
      resize = resize_;
    }
    public PowerUp(String name_, int count_, char stat_, int magnitude_){
      name = name_;
      count = count_;
      stat = stat_;
      magnitude = magnitude_;
    }

    public void show(float x, float y, int w, int h) {
        favicon.resize(w, h);
        image(favicon, x, y);
    }

    public boolean use(GameBoard gb){
        if(count > 0){
            if(resize!=0){
                gb.resize(gb.getSize()+resize);
            }
            count--;
            return true;
        }
        return false;
    }

    public boolean use(Player p){
        if(count > 0){
            p.effect(stat, magnitude);
            count--;
            return true;
        }
        return false;
    }
}
