boolean debug = true;
int screen = 2;
BattleScreen battleScreen;
Player player;
Theme currentTheme;

void setup(){
    fullScreen();
    ellipseMode(CENTER);
    rectMode(CORNER);
    float margin = min(width, 3*height/4)/6;
    float gameWidth = min(width, 3*height/4)-margin*2;
    textSize(margin/3);
    textAlign(CENTER);
    battleScreen = new BattleScreen(margin, gameWidth, new Player(1000, 1));
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
    if(screen==2){
        battleScreen.show(debug);
    }
}
