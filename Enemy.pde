class Enemy{
    private char[] TYPES = {'n','a','e','f','w'};
    private String[] fileNames = new String[] {"green"};
    private int maxHp;
    private int hp;
    private int damage;
    private char type;
    private PImage sprite;

    Enemy(int maxHp_, int damage_, char type_, PImage sprite_){
        maxHp = maxHp_;
        hp = maxHp_;
        damage = damage_;
        type = type_;
        sprite = sprite_;
    }
    Enemy(int seed){
        randomSeed(seed);
        maxHp = floor(pow(1.01, seed)*random(.8,1.2)*map((1+seed%4), 1, 4, 1, 3));
        hp = maxHp;
        damage = floor(pow(1.01, seed)*random(0.5,2)*map((1+seed%4), 1, 4, 1, 3));
        type = randomResistance(seed);
        sprite = loadImage("assets/monsters/"+floor(random(0,4))+".monster.png");
    }

    public void takeDamage(int amount, char damageType){
        switch(type){
            case 'n':
                hp-=amount;
                break;
            case 'a':
                hp-=(damageType=='a')?amount*2:amount/2;
                break;
            case 'e':
                hp-=(damageType=='f')?amount*2:amount/2;
                break;
            case 'f':
                hp-=(damageType=='w')?amount*2:amount/2;
                break;
            case 'w':
                hp-=(damageType=='e')?amount*2:amount/2;
                break;
        }
    }

    public boolean alive(){
        return hp>0;
    }

    public int getHp(){
        return hp;
    }
    public int getMaxHp(){
        return maxHp;
    }
    public int getDamage(){
        return damage;
    }
    private color typeToTint(){
        switch(type){
            case 'a':
                return color(255,255,150);
            case 'e':
                return color(50,150,50);
            case 'f':
                return color(255,100,100);
            case 'w':
                return color(150,150,255);
        }
        return color(200);
    }

    private char randomResistance(int seed){
        if(seed<=4)return 'n';
        return TYPES[floor(random(0,4))];
    }

    public void show(float x, float y, float w, float h){
        if(sprite.width!=w||sprite.height!=h) sprite.resize((int)w,(int)h);
        tint(typeToTint());
        image(sprite, x, y);
        tint(255);
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
