boolean debug = false;
int screen = 2;
BattleScreen battleScreen;
Player player;
Theme currentTheme;

void setup(){
    //fullScreen();
    size(500,800);
    ellipseMode(CENTER);
    rectMode(CORNER);
    textSize(min(width, 3*height/4)/18);
    textAlign(CENTER);
    strokeWeight(0);
    player = new Player(10000, 1);
    currentTheme = new AnimatedTheme(color(255, 150, 150), color(50, 20, 20), color(60, 20, 20), "0", .3);
    battleScreen = new BattleScreen(width, height, player);
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
        battleScreen.grid.resize(battleScreen.grid.getSize()+1);
    }
    if(key=='-'){
        battleScreen.grid.resize(battleScreen.grid.getSize()-1);
    }
}

void draw(){
    switch (screen){
        case 0:
            break;
        case 1:
            break;
        case 2:
            if(!battleScreen.update(currentTheme)){
                screen--;
                player.revive(); // may cause errors when maxHP is increased
            }
            battleScreen.show(currentTheme, debug);
            break;
    }
}
