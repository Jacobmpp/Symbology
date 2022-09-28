class Enemy{
    private int mhp;
    private int hp;
    private int damage;
    private char resistance;
    private PImage sprite;

    Enemy(int maxhp, int damage_, PImage sprite_){
        mhp=maxhp;
        hp=mhp;
        damage=damage_;
        sprite=sprite_;
    }

    public boolean takeDamage(int amount){
        hp-=amount;
        return hp>0;
    }

    public getHp(){
        return hp;
    }
    public getMaxHp(){
        return mhp;
    }

    public void show(float x, float y, float w, float h, ){

    }
}
