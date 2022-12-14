boolean debug = false;
int screen = 1;
BattleScreen battleScreen;
Player player;
ShopScreen shopScreen;
SplashScreen splashscreen;
Theme currentTheme;
PowerUp[] powerUps = new PowerUp[4];
int fadeMax = 60;
int fade = 0;
boolean fading = true;
int screenAfter = 1;
String LOCAL_SAVEDATA_FILENAME = "save.symbosave";
PrintWriter saver;
boolean loaded = false;

void setup(){
    //fullScreen(); // use when compiled for android
    size(450,800); // use when testing on Processing IDE

    // enitializing several drawing properties
    frameRate(30);
    ellipseMode(CENTER);
    rectMode(CORNER);
    textSize(min(width, 3*height/4)/18);
    fill(0);
    stroke(0);
    textAlign(CENTER);
    strokeWeight(0);

    // initializing system variables
    player = new Player(5000, 1, 0); // 3000 base hp, level 1, 1000 currency
    powerUps = new PowerUp[]{
        new PowerUp("Grow Board",0,"grow",1), // start with 0 grow powerUps
        new PowerUp("Shrink Board",0,"shrink",-1), // start with 0 shrink powerUps
        new PowerUp("Skip Level",0,"skip",'l'), // start with 0 skip powerUps
        new PowerUp("Heal Player",0,"heal",'h') // start with 0 heal powerUps
    };
    new State().testIntToChar();
    //save();
    currentTheme = new AnimatedTheme(color(255, 150, 150), color(50, 20, 20), color(60, 20, 20), "0", .6, width, height);
    battleScreen = new BattleScreen(width, height, player, powerUps);
    shopScreen = new ShopScreen(width, height, player,currentTheme);
    splashscreen = new SplashScreen(width,height);
    for(int i = 0; i < powerUps.length; i++){
        powerUps[i].resize(width/5, width/5);
        if(i>1)powerUps[i].loadScreen(battleScreen);
    }
}

void mousePressed(){
    switch(screen){
        case 3:
            battleScreen.mousePressed(mouseX, mouseY);
            break;
    }

}

void mouseReleased(){
    switch(screen){
        case 3:
            battleScreen.mouseReleased(mouseX, mouseY);
            break;
    }
}

void keyPressed(){
    if(key=='d'){
        debug=!debug;
    }
    if(key=='+'){
        battleScreen.gameBoard.resize(battleScreen.gameBoard.getSize()+1);
    }
    if(key=='-'){
        battleScreen.gameBoard.resize(battleScreen.gameBoard.getSize()-1);
    }
}

void draw(){
    switch (screen){
        case 1:
            if(splashscreen.show(player)&&!fading){
                fade(30,2);
            }
            fade();
            break;
        case 2:
            if(shopScreen.show(powerUps)==1){
                fade(30,3);
                save();
            }
            fade();
            break;
        case 3:
            if(!fading && !battleScreen.update(currentTheme)){
                player.spellbook.toggleable = false;
                player.level = player.level - (player.level - 1)%4;
                shopScreen.resetSpellBuy();
                fade(30, 2);
                save();
            }
            battleScreen.show(currentTheme, debug);
            fade();
            break;
    }
}

void loadFromFilename(Player p, String filename){
    try {
        String[] lines = loadStrings(filename);
        loadFromSaveString(p, lines[0]);
    } catch (Exception e) {
        println("File not found loading from starting values");
        loadFromSaveString(p, "");
    }
}

void loadFromSaveString(Player p, String save){
    if(save.length()==0)save = "500;1;0;1.0;1.0;23,wb#0;0;0;0";
    String greaterParts[] = save.split("#");
    p.reload(greaterParts[0].split(";"));
    String powerUpParts[] = greaterParts[1].split(";");
    for(int i = 0; i < 4; i++){
        powerUps[i].count = parseInt(powerUpParts[i]);
    }
}
void save(){
    saver = createWriter("data/" + LOCAL_SAVEDATA_FILENAME);
    saver.println(getSaveString());
    saver.flush();
    saver.close();
}
String getSaveString(){
    String out = player.toString() + "#";
    for(int i = 0; i < 3; i++)
        out += powerUps[i].count + ";";
    out += powerUps[3].count + "";
    return out;
}

color typeToTint(char type){ // get the color tint based on a type char code
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

void addParticle(Particle p){
    battleScreen.addParticleP(p);
}

void fade(int frames, int screenAfter_){
    if(!fading){
        fading = true;
        fadeMax = frames;
        fade = -frames;
        screenAfter = screenAfter_;
    }
    fade();
}
void fade(){
    if(fading){
        fill(0,0,0,255-(255*abs(fade++))/(fadeMax+1));
        stroke(0,0,0,255-(255*abs(fade++))/(fadeMax+1));
        rect(-3,-3,width+3,height+3);
        if(fade==0)
            screen = screenAfter;
        if(fade>=fadeMax){
            fading = false;
            fade = 0;
            fadeMax = 0;
        }
    }
}
