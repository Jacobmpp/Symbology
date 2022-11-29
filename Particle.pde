class Particle {
    PVector pos, vel, target, shape;
    color c;
    float forceMagnitude, shrinkRadius, vanishRadius;
    int age = 0, maxAge;
    /* 
    Notes:
    - monster dies spews out coins in all directions (possible a number related to log of actual coins or something capped) that go to coin bank
    - spell activates throw based on damage size and type color at monster
    - on hit, spalsh particles out of monster on hit with color based on spell type and number based on damage done (ie if they are resistant less particles)
    - magic particles are at least a little translucent
    */

    public Particle(float posx, float posy, float velx, float vely, float forceMagnitude_, float targetx, float targety, float shapex, float shapey, int c_, float shrinkRadius_, float vanishRadius_, int maxAge_){
        pos = new PVector(posx, posy);
        vel = new PVector(velx, vely);
        forceMagnitude = forceMagnitude_;
        target = new PVector(targetx, targety);
        shape = new PVector(shapex, shapey);
        c = c_;
        shrinkRadius = shrinkRadius_;
        vanishRadius = vanishRadius_;
        maxAge = maxAge_;
    }
    // age based vanishing
    public Particle(float posx, float posy, float velx, float vely, int maxAge_, float shapex, float shapey, int c_){
        this(posx, posy, velx, vely, 0, -10, -10, shapex, shapey, c_, 0, 0, maxAge_);
    }
    public Particle(float posx, float posy, float velx, float vely, int maxAge_, float size, int c_){
        this(posx, posy, velx, vely, 0, -10, -10, size, size, c_, 0, 0, maxAge_);
    }
    // target based vanishing
    public Particle(float posx, float posy, float forceMagnitude_, float targetx, float targety, float size, int c_, float shrinkRadius_, float vanishRadius_){
        this(posx, posy, 0, 0, forceMagnitude_, targetx, targety, size, size, c_, shrinkRadius_, vanishRadius_, -1);
    }
    public Particle(float posx, float posy, float velx, float vely, float forceMagnitude_, float targetx, float targety, float size, int c_, float shrinkRadius_, float vanishRadius_){
        this(posx, posy, velx, vely, forceMagnitude_, targetx, targety, size, size, c_, shrinkRadius_, vanishRadius_, -1);
    }

    public void update(){
        age++;
        float angle = atan2(target.y-pos.y, target.x-pos.x), m = forceMagnitude/(.001 + sqdist(pos, target));
        PVector acc = new PVector(cos(angle)*m, sin(angle)*m);
        acc.limit(3);
        vel.add(acc);
        vel.limit(10);
        pos.add(vel);

    }
    public void show(){
        fill(c);
        stroke(c);
        ellipse(pos.x, pos.y, shape.x, shape.y);
    }
    public boolean inactive(){
        if(maxAge != -1)return age > maxAge;
        return (vanishRadius*vanishRadius > sqdist(pos, target));
    }

    private float sqdist(PVector a, PVector b){
        float x = a.x - b.x;
        float y = a.y - b.y;
        float d = x*x+y*y;
        return (d==d)?d:1;
    }
    private float dist(PVector a, PVector b){
        return sqrt(sqdist(a, b));
    }
}
