boolean debug = true;
int screen = 2;
BattleScreen battleScreen;
Player player;
Theme currentTheme = new AnimatedTheme(color(200, 100, 100), color(50, 20, 20), color(30, 10, 10), 1);

void setup(){
    fullScreen();
    ellipseMode(CENTER);
    rectMode(CORNER);
    textSize(min(width, 3*height/4)/18);
    textAlign(CENTER);
    battleScreen = new BattleScreen(width, height, new Player(1000, 1));
}

void mousePressed(){
    if(screen==2){
        battleScreen.mousePressed(mouseX, mouseY);
    }

}

void keyPressed(){
    if(key=='d'){
        debug=!debug;
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
