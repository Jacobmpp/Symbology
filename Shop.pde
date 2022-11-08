import java.util.Random;


class Shop extends Screen{
  PowerUp powerUps[];
  PImage shop;
  PImage button;
  float new_width=width/3+(width/12.5);
  float new_height=height/3-(height/33.75);
  boolean clicked=false;//prevents overlaping screens
  int bools[]={1,1,1,1};//prevents overlaping screens
  Spellbook spellbook;
  Spell[] spell;
  
  public Shop(int width_, int height_){
       super(width_, height_);
       spellbook = new Spellbook("spells.dat", "0");
  }
  
  void makebutton(float width,float height,PImage button,String image,int size){// creates a button
       button = loadImage(image);
       button.resize(size,size);
       image(button, width, height); 
  }
 
  void RandomSpells(Spell[] spell){//gets a random spell 
    for(int i=0;i<4;i++){
      boolean set=false;   
      while(set==false){
        Random rand = new Random(); //instance of random class
        int random = rand.nextInt(10); 
        spell[i]=  spellbook.getSpell(random);
        print( spell[i].getName()); 
      }
    } 
  }
  
  void buyScreen(String name,PowerUp powerup[]){// you can buy or cancle items
    
    rect(width/5-37,height/4,300,300);
    fill(255,255,255);
    makebutton(width/2-70, height/2-170,button,name,150);//displayimage
    makebutton(width/2+80, height/2+60,button,name,70);//cancle
    makebutton(width/2-150, height/2+60,button,name,70);//buy
    clicked=true;
 
    if(mouseX >= width/2+80 && mouseX <= width/2+80 + 70 && mouseY >= height/2+60 && mouseY <= height/2+60 + 70&&mousePressed){      //cancle
       for(int i=0;i<4;i++)
       bools[i]=1;
       clicked=false;
    }
    if(mouseX >= width/2-150 && mouseX <= width/2-150 + 70 && mouseY >= height/2+60 && mouseY <= height/2+60 + 70&&mousePressed){   //buy
      if(name=="assets/powerUps/grow.powerUp.png"){
          powerup[0].setCount(powerup[0].getCount()+1);
          bools[0]=1;//prevents mouse hold
          clicked=false;
      }
      if(name=="assets/powerUps/shrink.powerUp.png"&&(bools[1]==0)){
          powerup[1].setCount(powerup[1].getCount()+1);
          bools[1]=1;//prevents mouse hold
          clicked=false;
      }
      if(name=="assets/powerUps/skip.powerUp.png"&&(bools[2]==0)){
         powerup[2].setCount(powerup[2].getCount()+1);
         bools[2]=1;//prevents mouse hold
         clicked=false;
      }
      if(name=="assets/powerUps/heal.powerUp.png"&&(bools[3]==0)){
         powerup[3].setCount(powerup[3].getCount()+1);
         bools[3]=1;//prevents mouse hold
         clicked=false;
      }
    }
  
  }
 
  void buttonLayout(){ // creates the layout
    //powerups
    makebutton(new_width, new_height,button,"assets/powerUps/grow.powerUp.png",62);
    makebutton(new_width-86, new_height,button,"assets/powerUps/shrink.powerUp.png",62);
    makebutton(new_width, new_height+70,button,"assets/powerUps/skip.powerUp.png",62);
    makebutton(new_width-86, new_height+70,button,"assets/powerUps/heal.powerUp.png",62);
    //spells
    makebutton(new_width-86, new_height+140,button,"assets/items.png",62);
    makebutton(new_width, new_height+140,button,"assets/items.png",62);
    makebutton(new_width+86, new_height,button,"assets/items.png",62);
    makebutton(new_width+86, new_height+70,button,"assets/items.png",62);
    //done
    makebutton(new_width, new_height+230,button,"assets/powerUps/heal.powerUp.png",62);
  } 
  
  void printshop(PowerUp powerup[]){//prints buysrceen in shop
    if(bools[0]==0)
    buyScreen("assets/powerUps/grow.powerUp.png",powerup);
    if(bools[1]==0)
    buyScreen("assets/powerUps/shrink.powerUp.png",powerup);
    if(bools[2]==0)
    buyScreen("assets/powerUps/skip.powerUp.png",powerup);
    if(bools[3]==0)
    buyScreen("assets/powerUps/heal.powerUp.png",powerup);
  }
  
  void mouseClicked(){//for the items in the shop
    if(clicked==false){ 
      if(mouseX >= new_width && mouseX <= new_width + 62 && mouseY >= new_height && mouseY <= new_height + 62&&mousePressed)
      
      bools[0]=0;
      if(mouseX >= new_width-86&& mouseX <= new_width-86 + 62 && mouseY >= new_height && mouseY <= new_height + 62&&mousePressed)
      bools[1]=0;
  
      if(mouseX >= new_width && mouseX <= new_width + 62 && mouseY >= new_height+70 && mouseY <= new_height+70 + 62&&mousePressed)
      bools[2]=0;
  
      if(mouseX >= new_width-86&& mouseX <= new_width-86 + 62 && mouseY >= new_height+70 && mouseY <= new_height+70 + 62&&mousePressed)
      bools[3]=0;
  
    }
  
  }
  
  public int exitShop(){ //if done is pressed you return back to battle screen
    if(mouseX >= new_width&& mouseX <= new_width + 62 && mouseY >= new_height+230 && mouseY <= new_height+230 + 62&&mousePressed&&(clicked==false))
      return 1;
    return 0; 
  }
  
     
  public int show(Theme theme,PowerUp powerup[]){
    shop= loadImage("assets/Shop.png");
    background(theme.getBackground());
    image(shop,0,0,wid,hei);
    buttonLayout();
    mouseClicked();
    printshop(powerup);
    return exitShop();   
  }
}
