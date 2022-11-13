boolean debug = false;
int screen = 2;
BattleScreen battleScreen;
Player player;
ShopScreen shopScreen;
Theme currentTheme;
PowerUp[] powerUps = new PowerUp[4];
void setup(){
    //fullScreen(); // use when compiled for android
    size(500,800); // use when testing on Processing IDE

    // enitializing several drawing properties
    ellipseMode(CENTER);
    rectMode(CORNER);
    textSize(min(width, 3*height/4)/18);
    textAlign(CENTER);
    strokeWeight(0);

    // initializing system variables
    player = new Player(3000, 1); // 3000 base hp, level 1
    powerUps = new PowerUp[]{
        new PowerUp("Grow Board",5,"grow",1), // start with 5 grow powerUps
        new PowerUp("Shrink Board",5,"shrink",-1), // start with 5 shrink powerUps
        new PowerUp("Skip Level",5,"skip",'l'), // start with 5 skip powerUps
        new PowerUp("Heal Player",5,"heal",'h') // start with 5 heal powerUps
    };
    battleScreen = new BattleScreen(width, height, player, powerUps);
    shopScreen = new ShopScreen(width, height, player.spellbook);
    for(int i = 0; i < powerUps.length; i++){
        powerUps[i].resize(width/5, width/5);
        if(i>1)powerUps[i].loadScreen(battleScreen);
    }
    currentTheme = new AnimatedTheme(color(255, 150, 150), color(50, 20, 20), color(60, 20, 20), "0", .6, width, height);
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
        case 0:
            break;
        case 1:
            if(shopScreen.show(currentTheme,powerUps)==1)
                screen++;
            break;
        case 2:
            if(!battleScreen.update(currentTheme)){
                player.spellbook.toggleable = false;
                player.level -= (player.level - 1)%4;
                player.revive(); // may cause errors when maxHP is increased
                screen--;                                                       
            }
            battleScreen.show(currentTheme, debug);
            break;
    }
}
