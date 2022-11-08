boolean debug = false;
int screen = 2;
BattleScreen battleScreen;
Player player;
Shop Shop;
Theme currentTheme;
PowerUp[] powerUps = new PowerUp[4];
void setup(){
    fullScreen();
    //size(375,675);
    ellipseMode(CENTER);
    rectMode(CORNER);
    textSize(min(width, 3*height/4)/18);
    textAlign(CENTER);
    strokeWeight(0);
    player = new Player(3000, 1);
    powerUps = new PowerUp[]{new PowerUp("Grow Board",5,"grow",1), new PowerUp("Shrink Board",5,"shrink",-1), new PowerUp("Skip Level",5,"skip",'l'), new PowerUp("Heal Player",5,"heal",'h')};
    battleScreen = new BattleScreen(width, height, player, powerUps);
    Shop = new Shop(width, height);
    powerUps[2].loadScreen(battleScreen);
    powerUps[3].loadScreen(battleScreen);
    currentTheme = new AnimatedTheme(color(255, 150, 150), color(50, 20, 20), color(60, 20, 20), "0", .6);
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
            if(Shop.show(currentTheme,powerUps)==1)
                screen++;
            break;
        case 2:
            if(!battleScreen.update(currentTheme)){
                screen--;                                                       uncomment this when other screens are ready
                player.revive(); // may cause errors when maxHP is increased
            }
            battleScreen.show(currentTheme, debug);
            break;
    }
}
