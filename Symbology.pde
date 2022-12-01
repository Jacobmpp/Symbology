boolean debug = false;
int screen = 1;
BattleScreen battleScreen;
Player player;
ShopScreen shopScreen;
SplashScreen splashscreen;
Theme currentTheme;
PowerUp[] powerUps = new PowerUp[4];

void setup(){
    //fullScreen(); // use when compiled for android
    size(450,800); // use when testing on Processing IDE

    // enitializing several drawing properties
    ellipseMode(CENTER);
    rectMode(CORNER);
    textSize(min(width, 3*height/4)/18);
    fill(0);
    stroke(0);
    textAlign(CENTER);
    strokeWeight(0);

    // initializing system variables
    player = new Player(3000, 1, 1000); // 3000 base hp, level 1, 1000 currency
    powerUps = new PowerUp[]{
        new PowerUp("Grow Board",5,"grow",1), // start with 5 grow powerUps
        new PowerUp("Shrink Board",5,"shrink",-1), // start with 5 shrink powerUps
        new PowerUp("Skip Level",5,"skip",'l'), // start with 5 skip powerUps
        new PowerUp("Heal Player",5,"heal",'h') // start with 5 heal powerUps
    };
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
        case 2:
            battleScreen.mousePressed(mouseX, mouseY);
            break;
    }

}

void mouseReleased(){
    switch(screen){
        case 2:
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
            if(splashscreen.show()==1)
            screen++
            break;
        case 2:
            if(shopScreen.show(powerUps)==1)
                screen++;
            break;
        case 3:
            if(!battleScreen.update(currentTheme)){
                player.spellbook.toggleable = false;
                player.level -= (player.level - 1)%4;
                player.revive(); // may cause errors when maxHP is increased
                screen--;
                println(getSaveString());
            }
            battleScreen.show(currentTheme, debug);
            break;
    }
}

void loadFromSaveString(String save){
    String greaterParts[] = save.split("#");
    player = new Player(greaterParts[0]);
    String powerUpParts[] = greaterParts[1].split(";");
    for(int i = 0; i < 4; i++){
        powerUps[i].count = parseInt(powerUpParts[i]);
    }
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
