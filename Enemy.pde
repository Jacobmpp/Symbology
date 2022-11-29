class Enemy{
    private char[] TYPES = {'n','a','e','f','w'};
    private int maxHp;
    private int hp;
    private int damage;
    private char type;
    private PImage sprite;
    private boolean boss = false;
    public PVector center = null;

    Enemy(int maxHp_, int damage_, char type_, PImage sprite_){
        maxHp = maxHp_;
        hp = maxHp_;
        damage = damage_;
        type = type_;
        sprite = sprite_;
    }
    Enemy(int seed){
        boss = seed%4==0;
        randomSeed(seed); // set the random seed so each level is always the same, and different levels are different and we don't have to make them
        maxHp = floor(4*pow(1.01, seed)*random(.8,1.2)*map((seed%4), 0, 3, 1, 3)*(boss?2:1));
        hp = maxHp;
        damage = max(floor(pow(1.01, seed)*random(.8,1.2)*(boss?2:1)),1);
        type = randomResistance(seed);
        sprite = loadImage("assets/monsters/"+floor(random(0,4))+".monster.png");
        sprite.resize(width/2, width/2); // small optimization
    }

    public int takeDamage(int amount, char damageType){
        int damage = 0;
        switch(type){
            case 'n': // if the enemy is of type neutral it just takes the damage
                damage=amount;
                break;
            case 'a': // if the enemy is of type air it takes double damage from air spells and half from others
                damage=(damageType=='a')?amount*2:amount/2;
                break;
            case 'e': // if the enemy is of type earth it takes double damage from fire spells and half from others
                damage=(damageType=='f')?amount*2:amount/2;
                break;
            case 'f': // if the enemy is of type fire it takes double damage from water spells and half from others
                damage=(damageType=='w')?amount*2:amount/2;
                break;
            case 'w': // if the enemy is of type water it takes double damage from earth spells and half from others
                damage=(damageType=='e')?amount*2:amount/2;
                break;
        }
        hp-=damage;
        return damage;
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

    private char randomResistance(int seed){ // get a random resistance from the seed
        if(seed<=4)return 'n';
        return TYPES[floor(random(0,4))];
    }

    public void show(float x, float y, float w, float h){
        if(boss){
            x-=w/2;
            y-=h/2;
            w*=2;
            h*=2;
        }
        if(center==null)center=new PVector(x+w/2, y+h/2);
        tint(typeToTint(type));
        image(sprite, x, y, w, h);
        tint(255);
    }

    public void showHp(float x, float y, float w, float h, Theme t){
        float edge = map(hp,0,maxHp,9*w/64,w);
        edge = min(edge - edge%(w/15) + w/15, w);
        fill(t.getOff());
        rect(x+edge,y+h/20,w-edge,9*h/10);
        fill(t.getOn());
        rect(x, y+h/20, edge, 9*h/10);
        image(t.enemyHealthBar, x, y, w, h);
    }
}
