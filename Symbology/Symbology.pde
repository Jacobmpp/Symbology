boolean debug = true;
int screen = 2;
BattleScreen battleScreen;
Player player;
Theme currentTheme;

void setup(){
    fullScreen();
    ellipseMode(CENTER);
    rectMode(CORNER);
    margin = min(width, 3*height/4)/6;
    gameWidth = min(width, 3*height/4)-margin*2;
    textSize(margin/3);
    textAlign(CENTER);
}

void mousePressed(){
    if(screen==2){
        battleScreen.mousePressed(MouseX, MouseY);
    }
    size = grid.getState().getSize();
    int x = floor((mouseX-margin)/(gameWidth/size));
    int y = floor((mouseY-margin)/(gameWidth/size));

}

void keyPressed(){
    if(key=='d'){
        debug=!debug;
    }
}

void draw(){
    background(15);
    if(screen==2){
        BattleScreen.show();
    }
}

void drawBoard(float x, float y, float gWidth, boolean[][] state, color on, color off, color stroke, float strokeWeight){

}
void drawDebug(float x, float y, float gWidth, boolean[][] state, color fill, color stroke, float strokeWeight, float r){
    strokeWeight(strokeWeight);
    stroke(stroke);
    fill(fill);
    ellipseMode(CENTER);
    int sizeX = state.length;
    if(sizeX<1)return;
    int sizeY = state[0].length;
    for(int i = 0; i < sizeX; i++){
        for(int j = 0; j < sizeY; j++){
        if(state[i][j])ellipse(x+(i+0.5)*gWidth/sizeX, y+(j+0.5)*gWidth/sizeY, gWidth/sizeX/r, gWidth/sizeY/r);
        }
    }
}
