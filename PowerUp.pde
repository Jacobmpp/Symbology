class PowerUp{
    String name;
    int count;
    int resize;
    char stat;
    int magnitude;
    PImage favicon;
    BattleScreen screen;

    public PowerUp(String name_, int count_, String favicon_){
      name = name_;
      count = count_;
      favicon = loadImage("assets/powerUps/" + favicon_ + ".powerUp.png");
    }
    public PowerUp(String name_, int count_, String favicon_, int resize_){
        this(name_, count_, favicon_);
        resize = resize_;
    }
    public PowerUp(String name_, int count_, String favicon_, char stat_){
        this(name_, count_, favicon_);
        stat = stat_;
    }

    public void resize(int x, int y){
        favicon.resize(x, y);
    }

    public void loadScreen(BattleScreen screen_){
        screen = screen_;
    }

    public void show(float x, float y, int w, int h) {
        image(favicon, x, y);
        fill(255);
        ellipse(x+w*.8, y+h*.85, w/3, h/3);
        textAlign(CENTER, CENTER);
        String tempCount = "" + count;
        textSize(w/3/tempCount.length());
        fill(0);
        text(tempCount, x+w*.8, y+h*.83);
    }

    public boolean use(GameBoard gb){
        if(count > 0){
            if(resize!=0){
                if(!gb.resize(gb.getSize()+resize))return false;
                gb.scramble();
            }
            if(screen != null){
                screen.player.effect(stat);
                if(stat == 'l')
                    screen.enemy = new Enemy(screen.player.getLevel());
            }
            count--;
            return true;
        }
        return false;
    }
}
