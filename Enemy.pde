class Enemy{
    private String[] fileNames = new String[] {"green"};
    private int maxHp;
    private int hp;
    private int damage;
    private char resistance;
    private color tint;
    private PImage sprite;

    Enemy(int maxHp_, int damage_, char resistance_, color tint_, PImage sprite_){
        maxHp = maxHp_;
        hp = maxHp_;
        damage = damage_;
        resistance = resistance_;
        tint = tint_;
        sprite = sprite_;
    }
    Enemy(int seed){
        //TODO: make "random" and scaling enemy based on seed
        maxHp = 50;
        hp = 50;
        damage = 1;
        sprite = loadImage("assets/monsters/"+seed%1+".monster.png");
    }

    public boolean takeDamage(int amount){
        hp-=amount;
        return hp>0;
    }

    public int getHp(){
        return hp;
    }
    public int getMaxHp(){
        return maxHp;
    }
    public color getTint(){
      return tint;
    }

    public void show(float x, float y, float w, float h){
        if(sprite.width!=w||sprite.height!=h) sprite.resize((int)w,(int)h);
        image(sprite, x, y);
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
