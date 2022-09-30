class Enemy{
    private String[] fileNames = new String[] {"green"};
    private int maxHp;
    private int hp;
    private int damage;
    private char resistance;
    private PImage sprite;

    Enemy(int maxHp_, int damage_, PImage sprite_){
        maxHp = maxHp_;
        hp = maxHp_;
        damage = damage_;
        sprite = sprite_;
    }
    Enemy(int maxHp_, int damage_, String spriteFilename){
        maxHp=maxHp_;
        hp=maxHp_;
        damage=damage_;
        sprite=loadImage(spriteFilename+".monster.png");
    }
    Enemy(int seed){
        //TODO: make "random" enemy based on a seed
        maxHp = 50;
        hp = 50;
        damage = 1;
        sprite = loadImage("assets/monsters/"+seed%1+".monster.png", "png");
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

    public void show(float x, float y, float w, float h){
        if(sprite.width!=w||sprite.height!=h) sprite.resize((int)w,(int)h);
        image(sprite, x, y);
    }
}
