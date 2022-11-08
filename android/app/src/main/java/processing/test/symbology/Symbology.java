package processing.test.symbology;

/* autogenerated by Processing revision 1286 on 2022-11-03 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.Hashtable;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class Symbology extends PApplet {

boolean debug = false;
int screen = 2;
BattleScreen battleScreen;
Player player;
Theme currentTheme;
PowerUp[] powerUps = new PowerUp[4];
 public void setup(){
    /* size commented out by preprocessor */;
    //size(375,675);
    ellipseMode(CENTER);
    rectMode(CORNER);
    textSize(min(width, 3*height/4)/18);
    textAlign(CENTER);
    strokeWeight(0);
    player = new Player(3000, 1);
    powerUps = new PowerUp[]{new PowerUp("Grow Board",5,"grow",1), new PowerUp("Shrink Board",5,"shrink",-1), new PowerUp("Skip Level",5,"skip",'l'), new PowerUp("Heal Player",5,"heal",'h')};
    battleScreen = new BattleScreen(width, height, player, powerUps);
    powerUps[2].loadScreen(battleScreen);
    powerUps[3].loadScreen(battleScreen);
    currentTheme = new AnimatedTheme(color(255, 150, 150), color(50, 20, 20), color(60, 20, 20), "0", .6f);
}

 public void mousePressed(){
    switch(screen){
        case 2:
            battleScreen.mousePressed(mouseX, mouseY);
            break;
    }

}

 public void mouseReleased(){
    switch(screen){
        case 2:
            battleScreen.mouseReleased(mouseX, mouseY);
            break;
    }
}

 public void keyPressed(){
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

 public void draw(){
    switch (screen){
        case 0:
            break;
        case 1:
            break;
        case 2:
            if(!battleScreen.update(currentTheme)){
                //screen--;                                                       uncomment this when other screens are ready
                player.revive(); // may cause errors when maxHP is increased
            }
            battleScreen.show(currentTheme, debug);
            break;
    }
}
class AnimatedTheme extends Theme {
    float speed;
    float hue;

    public AnimatedTheme(int on_, int off_, int background_, String backgroundImageFilename, float speed_){
        super(on_, off_, background_, backgroundImageFilename);
        speed=speed_;
        hue = hue(on);
    }

    @Override
    public void update(){
        hue = (hue+speed);
        if(hue>256)hue-=256;
    }
    @Override
    public int getOn(){
        colorMode(HSB,255);
        on = color(floor(hue), saturation(on), brightness(on));
        colorMode(RGB,255);
        return on;
    }
    @Override
    public int getOff(){
        colorMode(HSB,255);
        off = color(floor(hue), saturation(off), brightness(off));
        colorMode(RGB,255);
        return off;
    }
    @Override
    public int getBackground(){
        colorMode(HSB,255);
        background = color(floor(hue), saturation(background), brightness(background));
        colorMode(RGB,255);
        return background;
    }
}
class BattleScreen extends Screen{
    Player player; // Stores player stats and Spell book
    Enemy enemy;
    GameBoard gameBoard; // Wraps a State with rendering data and methods
    PowerUp powerUps[];
    int lastX, lastY; // The x,y position of the mouse when the mouse was last clicked

    public BattleScreen(int width_, int height_, Player player_, PowerUp powerUps_[]){
        super(width_, height_);
        player = player_;
        enemy = new Enemy(player.getLevel());
        gameBoard = new GameBoard((int)gameWidth);
        powerUps = powerUps_;
    }

    public void mousePressed(int mx, int my){
        lastX = mx;
        lastY = my;
        player.spellbook.toggleable = true;
    }

    public void mouseReleased(int mx, int my){
        player.spellbook.toggleable = false;
        float displacement = map(lastX-mouseX, 0, 2*margin, 0, 1);
        if(displacement > 0.5f)player.spellbook.visible = true;
        if(displacement <-0.5f)player.spellbook.visible = false;
        if(!player.spellbook.visible && pow(lastX-mx,2)+pow(lastY-my, 2)<pow(margin/2,2)){
            gameBoard.click(mx, my);
            Spell temp = player.spellbook.getSpell(gameBoard.getEncoded());
            if(temp!=null){
                enemy.takeDamage(temp.damage, temp.type);
                gameBoard.scramble();
                if(!enemy.alive()){
                    player.level++;
                    enemy = new Enemy(player.level);
                }
            }
        }
        if(mx==constrain(mx, wid/10, 9*wid/10)&&my==constrain(my, hei/3.2f + gameWidth*1.1f + margin/2, hei/3.2f + gameWidth*1.1f + margin/2 + wid/5)){
            int x = floor((mx-wid/10)/(wid/5));
            if(x == constrain(x, 0, 3))
                powerUps[x].use(gameBoard);
        }
        else player.spellbook.click(mx,my, this);
    }

    public boolean update(Theme theme){
        theme.update();
        if(!player.spellbook.visible)player.takeDamage(enemy.getDamage());
        return player.alive();
    }

    public void show(Theme theme, boolean debug){
        background(theme.getBackground());
        image(theme.getBackgroundImage(),0,0,wid,hei);
        enemy.show(wid/2-margin, margin, margin*2, margin*2);
        enemy.showHp(0, 0, wid, margin/2, theme);
        gameBoard.show(wid/2-gameWidth/2, hei/3.2f, gameWidth, theme.getOn(), theme.getOff(), debug);
        player.showHp(0,height-margin/2, width, margin/2, theme);
        player.spellbook.show(map(lastX-mouseX, 0, 2*margin, 0, 1), wid-1.5f*margin, gameWidth+2*margin, this, theme);
        for(int i=0; i<4; i++){
            powerUps[i].show(wid/10 * (1+2*i), hei/3.2f + gameWidth*1.1f + margin/2, wid/5, wid/5);
        }
    }
}
class Enemy{
    private char[] TYPES = {'n','a','e','f','w'};
    private int maxHp;
    private int hp;
    private int damage;
    private char type;
    private PImage sprite;
    private boolean boss = false;

    Enemy(int maxHp_, int damage_, char type_, PImage sprite_){
        maxHp = maxHp_;
        hp = maxHp_;
        damage = damage_;
        type = type_;
        sprite = sprite_;
    }
    Enemy(int seed){
        randomSeed(seed);
        maxHp = floor(4*pow(1.01f, seed)*random(.8f,1.2f)*map((1+seed%4), 1, 4, 1, 3));
        hp = maxHp;
        damage = floor(pow(1.01f, seed)*random(0.5f,2)*map((1+seed%4), 1, 4, 1, 3));
        type = randomResistance(seed);
        sprite = loadImage("assets/monsters/"+floor(random(0,4))+".monster.png");
        boss = seed%4==0;
    }

    public void takeDamage(int amount, char damageType){
        switch(type){
            case 'n':
                hp-=amount;
                break;
            case 'a':
                hp-=(damageType=='a')?amount*2:amount/2;
                break;
            case 'e':
                hp-=(damageType=='f')?amount*2:amount/2;
                break;
            case 'f':
                hp-=(damageType=='w')?amount*2:amount/2;
                break;
            case 'w':
                hp-=(damageType=='e')?amount*2:amount/2;
                break;
        }
    }

    public boolean alive(){
        return hp>0;
    }

    public int getHp(){
        return hp;
    }
    public int getMaxHp(){
        return maxHp;
    }
    public int getDamage(){
        return damage;
    }
    private int typeToTint(){
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

    private char randomResistance(int seed){
        if(seed<=4)return 'n';
        return TYPES[floor(random(0,4))];
    }

    public void show(float x, float y, float w, float h){
        if(boss){
            x-=w/2;
            y-=h/2;
            w*=2;
            h*=2;
        }
        if(sprite.width!=w||sprite.height!=h) sprite.resize((int)w,(int)h);
        tint(typeToTint());
        image(sprite, x, y);
        tint(255);
    }

    public void showHp(float x, float y, float w, float h, Theme t){
        float edge = map(hp,0,maxHp,0,w);
        edge = min(edge - edge%(w/15) + w/15, w);
        fill(t.getOff());
        rect(x+edge,y,w-edge,h);
        fill(t.getOn());
        rect(x, y, edge, h);
    }
}
class GameBoard{
    private int scaleFactor = 20;
    private State state;
    private int lastSize = 0;
    private PImage board, original, boarder; 
    private PVector topCorner = null;
    private PVector dimensions = null;

    // Constructor
    GameBoard(State state_, int gWidth){
        state = state_;
        loadImages("assets/brick.board.png", gWidth);
        boarder = loadImage("assets/boarder.board.png");
        boarder.resize((int)(gWidth*1.2f), (int)(gWidth*1.2f));
    }
    GameBoard(int gWidth){
      this(new State(3), gWidth);
    }

    // State Functions
    public void click(int mx, int my){
        int size = getState().getSize();
        int x = floor((mx-topCorner.x)/(dimensions.x/size));
        int y = floor((my-topCorner.y)/(dimensions.y/size));
        if(!(x>=size||x<0 || y>=size||y<0)){
            state.click(x,y);
        }
    }
    public void scramble(){
        state.scramble();
    }
    public int getSize(){
        return state.getSize();
    }
    public State getState(){
        return state;
    }
    public boolean resize(int newSize){
      return state.resize(newSize);
    }
    public boolean onBoard(int mx, int my){
        int x = floor((mx-topCorner.x));
        int y = floor((my-topCorner.y));
        return !(x>=dimensions.x||x<0 || y>=dimensions.y||y<0);
    }
    public long getEncoded(){
        return state.getEncoded();
    }

    // Load Images
    private void loadImages(String filename, int gWidth){
        original = loadImage(filename);
        board = original.get(((7-state.getSize())/2+(1-state.getSize()%2))*16*scaleFactor,((7-state.getSize())/2+(1-state.getSize()%2))*16*scaleFactor,16*state.getSize()*scaleFactor,16*state.getSize()*scaleFactor);
        board.resize(gWidth, gWidth);
    }

    // Show
    public void show(float x, float y, float gWidth, int on, int off, boolean debug){
        int size = state.getSize();
        if(topCorner==null)topCorner=new PVector(x, y);
        if(dimensions==null)dimensions=new PVector(gWidth, gWidth);
        if(size<1)return;
            if(size!=lastSize){
                board = original.get(((7-state.getSize())/2+(1-state.getSize()%2))*16*scaleFactor, ((7-state.getSize())/2+(1-state.getSize()%2))*16*scaleFactor, 16*state.getSize()*scaleFactor, 16*state.getSize()*scaleFactor);
                lastSize = size;
                board.resize((int)gWidth, (int)gWidth);
            }
        tint(red(on), green(on), blue(on));
        image(boarder, x-gWidth*0.1f, y-gWidth*0.1f, gWidth*1.2f, gWidth*1.2f);
        tint(255,255,255);
        state.show(x, y, gWidth, on, off, debug);
        image(board, x, y, gWidth, gWidth);
    }
}
class Player{

    private int hp;
    private int maxHp;
    private int level;
    public Spellbook spellbook;

    public Player(int maxHp_, int level_){
        maxHp = maxHp_;
        hp = maxHp_;
        level = level_;
        spellbook = new Spellbook("spells.dat", "0");
    }

    public void takeDamage(int damage){
        hp-=damage;
    }

    public void effect(char stat){
        switch(stat) {
            case 'h':
                hp = maxHp;
                break;
            case 'l':
                level++;
                break;
        }
    }
    
    public int getLevel(){
      return level;
    }

    public boolean alive(){
        return hp > 0;
    }

    public void revive(){
        hp = maxHp;
    }

    public void showHp(float x, float y, float w, float h, Theme t){
        float edge = map(hp,0,maxHp,0,w);
        edge = min(edge - edge%(w/(maxHp/50)) + w/(maxHp/50), w);
        fill(t.getOff());
        rect(x+edge,y,w-edge,h);
        fill(t.getOn());
        rect(x, y, edge, h);
    }
}
class PowerUp{
    String name;
    int count;
    int resize;
    char stat;
    int magnitude;
    PImage favicon;
    BattleScreen screen;

    public PowerUp(String name_, int count_, String favicon_){
      name = name_;
      count = count_;
      favicon = loadImage("assets/powerUps/" + favicon_ + ".powerUp.png");
    }
    public PowerUp(String name_, int count_, String favicon_, int resize_){
        this(name_, count_, favicon_);
        resize = resize_;
    }
    public PowerUp(String name_, int count_, String favicon_, char stat_){
        this(name_, count_, favicon_);
        stat = stat_;
    }

    public void loadScreen(BattleScreen screen_){
        screen = screen_;
    }

    public void show(float x, float y, int w, int h) {
        image(favicon, x, y, w, h);
        fill(255);
        ellipse(x+w*.8f, y+h*.85f, w/3, h/3);
        textAlign(CENTER, CENTER);
        String tempCount = "" + count;
        textSize(w/3/tempCount.length());
        fill(0);
        text(tempCount, x+w*.8f, y+h*.83f);
    }

    public boolean use(GameBoard gb){
        if(count > 0){
            if(resize!=0){
                gb.resize(gb.getSize()+resize);
                gb.scramble();
            }
            if(screen != null){
                screen.player.effect(stat);
                if(stat == 'l')
                    screen.enemy = new Enemy(screen.player.getLevel());
            }
            count--;
            return true;
        }
        return false;
    }
}
abstract class Screen {
    int wid;
    int hei;
    float margin;
    float gameWidth;
    
    public Screen(int width_, int height_){
        wid = width_;
        hei = height_;
        margin = min(width_, 3*height_/4)/8;
        gameWidth = min(width_, 3*height_/4)-margin*2;;
    }
}
class Spell{
    String name;
    int damage;
    char type;
    String flavor;
    boolean discoverable;
    State state;
    
    Spell(String encoded){
        String parts[] = encoded.split(";");
        name = parts[0];
        damage = parseInt(parts[1]);
        type = parts[2].charAt(0);
        flavor = parts[3];
        discoverable = parts[4].equals("1") || parts[4].toLowerCase().equals("true");
        state = new State(Long.parseLong(parts[5]));
        
    }

    public void show(float x, float y, float w, float h, Theme theme){
        state.show(x, y, w/2, theme.getOn(), theme.getOff());
        textAlign(CENTER, CENTER);
        float tSize = w/2/(""+damage).length();
        textSize(tSize);
        fill(typeToTint());
        rect(x+w/2,y,w/2,w/2);
        fill(0);
        text(""+damage, x+3*w/4, y+h/5-tSize/5);
        textAlign(CENTER, BOTTOM);
        fill(theme.getOff());
        textSize(w/10);
        text(name, x+w/2, y+3*w/4);
        textAlign(LEFT, TOP);
        textSize(w/15);
        text(flavor, x, y+3*w/4, w, y+5*h/8);

    }

    public long getEncoded(){
        return state.getEncoded();
    }

    private int typeToTint(){
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
}
  // Import the File class
  // Import this class to handle errors
 // Import the Scanner class to read text files


class Spellbook{
    private Hashtable <Long, Spell> spells = new Hashtable<Long, Spell>();
    private long spellsLookup[];
    private PImage background;
    private float x, y, w, h;

    public boolean visible, toggleable = false;
    public int visibleIndex = 0;
    boolean avalable[];
    int spellCount = 0;
    
    Spellbook(String spellFile, String bgFile){
        loadSpells(spellFile);
        background = loadImage("assets/"+ bgFile + ".spellbook.png");
    }
    
    private void loadSpells(String filename){
        try {
            String[] lines = loadStrings(filename);
            spellsLookup = new long[lines.length];
            avalable  = new boolean[lines.length];
            for(int i=0; i<lines.length;i++) {
                if(lines[i].split(";").length>5){
                    Spell temp = new Spell(lines[i]);
                    spells.put(temp.getEncoded(), temp);
                    avalable[spellCount] = true;
                    spellsLookup[spellCount++] = temp.getEncoded();
                }
            }
        } catch (NullPointerException e) {
            System.out.println("Spells file not found!"); // Display to screen
            e.printStackTrace();
        }
    }

    public void click(int mX, int mY, BattleScreen screen){
        int attempts = 0;
        do {
            if(pow(x+3*w/16-mX,2)+pow(y+7*h/8-mY,2)<pow(screen.margin,2)){
                visibleIndex = ((visibleIndex - 1)+spellCount)%spellCount;
            } else if(pow(x+13*w/16-mX,2)+pow(y+7*h/8-mY,2)<pow(screen.margin,2)){
                visibleIndex = (visibleIndex + 1)%spellCount;
            }
        } while(!avalable[visibleIndex] && attempts++<spellCount-1);
    }
    
    public void show(float deployment, float w_, float h_, BattleScreen screen, Theme theme){
        w = w_;
        h = h_;
        if(toggleable){
            if(visible){
                x = map(constrain(deployment, -1, 0), -1, 0, width-screen.margin/2, width/2-w/2);
            } else {
                x = map(constrain(deployment,  0, 1),  0, 1, width-screen.margin/2, width/2-w/2);
            }
            if(deployment>1){
                visible=true;
            } else if(deployment<-1){
                visible=false;
            }
        } else if(visible){
            x = width/2-w/2;
        } else {
            x = width-screen.margin/2;
        }
        y = height/2-h/2;
        tint(theme.getOn());
        image(background, x, y, w, h);
        tint(255);
        fill(theme.getOff());
        triangle(x+w/8,y+7*h/8, x+w/4,y+13*h/16, x+w/4,y+15*h/16);
        triangle(x+7*w/8,y+7*h/8, x+3*w/4,y+13*h/16, x+3*w/4,y+15*h/16);
        if(x+screen.margin/2<width)spells.get(spellsLookup[visibleIndex]).show(x+screen.margin/2,y+screen.margin/2,w-screen.margin,h-screen.margin, theme);
    }

    public Spell getSpell(long encodedTopState){
        return spells.get(encodedTopState);
    }
}
class State{
    boolean[][] subState;
    boolean[][] topState;
    long encodedTopState;
    int size;
    
    // Constructors
    State(boolean[][] state){
        size = state.length;
        subState = state;
        calc();
    }
    State(long state){
        this((int)8);
        subState = convert(state);
        calc();
    }
    State(int size_){
        size = size_;
        subState = new boolean[size][size];
        topState = new boolean[size][size];
        for(int i = 0; i < size; i++){
            for(int j = 0; j < size; j++){
                subState[i][j] = false;
            }
        }
        calc();
    }
    State(){ // This is weird, make sure it works
        this((long)random(1<<3,1<<54) + 3); 
    }

    // Cell Math
    public void click(int x, int y){
        subState[x][y] = !subState[x][y];
        calc();
    }
    public void calc(){
        for(int i = 0; i < size; i++){
            for(int j = 0; j < size; j++){
                sum(i, j);
            }
        }
        encodedTopState = convert(topState);
    }
    private void sum(int x, int y){
        boolean out = !subState[x][y];
        if(x>0&&subState[x-1][y])out=!out;
        if(y>0&&subState[x][y-1])out=!out;
        if(x<size-1&&subState[x+1][y])out=!out;
        if(y<size-1&&subState[x][y+1])out=!out;
        topState[x][y] = out;
    }
    public void scramble(){
        for(int i = 0; i < size; i++){
            for(int j = 0; j < size; j++){
                subState[i][j] = random(0,1) < 0.5f;
            }
        }
        calc();
    }

    // Resizing
    public int getSize(){
        return size;
    }
    private boolean[][] resize(boolean[][] board, int newSize){
        if(board.length == newSize)return board;
        boolean[][] out = new boolean[newSize][newSize];
        int offset = abs(newSize-board.length)/2 + (newSize + ((0<(board.length - newSize))?1:0))%2;
        boolean bigger = newSize > board.length;
        for(int i = 0; i < min(newSize, board.length); i++){
            for(int j = 0; j < min(newSize, board.length); j++){
                if(bigger){
                    out[i+offset][j+offset] = board[i][j];
                } else {
                    out[i][j] = board[i+offset][j+offset];
                }
            }
        }
        return out;
    }
    public boolean resize(int newSize){
        if(newSize<3||newSize>7)return false;
        subState = resize(subState, newSize);
        topState = resize(topState, newSize);
        size = newSize;
        calc();
        return true;
    }

    // Encoding
    public long getEncoded(){
        calc();
        return encodedTopState;
    }
    public long convert(boolean[][] state){
        long out = 0;
        for(int i = 0; i < size*size; i++){
            out<<=1;
            out+=(state[i%size][i/size])?1:0;
        }
        out<<=3;
        out+=size;
        return out;
    }
    public boolean[][] convert(long in){
        size = (int)(in%8);
        boolean out[][] = new boolean[size][size];
        in>>=3;
        for(int i = size*size-1; i >= 0; i--){
        out[i%size][i/size] = in%2==1;
        in>>=1;
        }
        return out;
    }

    // Show
    public void show(float x, float y, float gWidth, int on, int off){
        if(size<1)return;
        strokeWeight(1);
        stroke(0);
        fill(on);
        for(int i = 0; i < size; i++)
          for(int j = 0; j < size; j++)
            if(topState[i][j])
              rect(x+i*gWidth/size, y+j*gWidth/size, gWidth/size, gWidth/size);
        fill(off);
        for(int i = 0; i < size; i++)
          for(int j = 0; j < size; j++)
            if(!topState[i][j])
              rect(x+i*gWidth/size, y+j*gWidth/size, gWidth/size, gWidth/size);
    }
    public void show(float x, float y, float gWidth, int on, int off, boolean debug){
        show(x, y, gWidth, on, off);
        if(!debug)return;
        fill(color(255,0,0));
        for(int i = 0; i < size; i++)
          for(int j = 0; j < size; j++)
            if(subState[i][j])
              ellipse(x+(i+.5f)*gWidth/size, y+(j+.5f)*gWidth/size, gWidth/size/2, gWidth/size/2);
    }
 }
class Theme{
    protected int on;
    protected int off;
    protected int background;
    protected PImage backgroundImage;

    Theme(int on_, int off_, int background_, String backgroundImageFilename){
        on = on_;
        off = off_;
        background = background_;
        backgroundImage = loadImage("assets/backgrounds/"+backgroundImageFilename+".background.png");
    }

    public int getOn(){
        return on;
    }
    public int getOff(){
        return off;
    }
    public int getBackground(){
        return background;
    }
    public PImage getBackgroundImage(){
        return backgroundImage;
    }

    public void update(){}
}


  public void settings() { fullScreen(); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Symbology" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
