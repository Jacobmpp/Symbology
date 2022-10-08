boolean debug = false;
int screen = 2;
BattleScreen battleScreen;
Player player;
Theme currentTheme;
int mouseXPressed, mouseYPressed;

void setup(){
    //fullScreen();
    size(500,800);
    ellipseMode(CENTER);
    rectMode(CORNER);
    textSize(min(width, 3*height/4)/18);
    textAlign(CENTER);
    player = new Player(1000, 1);
    currentTheme = new AnimatedTheme(color(255, 150, 150), color(50, 20, 20), color(60, 20, 20), "0", .3);
    battleScreen = new BattleScreen(width, height, player);
}

void mousePressed(){
    mouseXPressed = mouseX;
    mouseYPressed = mouseY;
    if(screen==2){
        battleScreen.mousePressed(mouseX, mouseY);
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
            battleScreen.show(currentTheme, debug);
            break;
    }
}
