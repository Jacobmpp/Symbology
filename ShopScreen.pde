import java.util.Random;
import java.lang.Math;

class ShopScreen extends Screen{
    PowerUp powerUps[];
    Theme theme;
    PImage shop;
    HashMap<String, PImage> buttons = new HashMap<String, PImage>(10);
    float new_width=width/3+(width/12.5);
    float new_height=height/3-(height/33.75);
    float buttonSize = width*0.16533333333;
    boolean clicked=false;//prevents overlaping screens
    int bools[]={1,1,1,1,1,1,1,1};//prevents overlaping screens
    Spellbook spellbook;
    int randSpell[]={1,2,3,4};
    boolean RandSpell=false;
    boolean bought[]={false,false,false,false};//prevents repeats spells
    String Bought="assets/40f.png";//will appear if you buy spell
    int spellcount=1;


    public ShopScreen(int width_, int height_, Spellbook spellbook_, Theme theme_){
        super(width_, height_);
        addImage("assets/powerUps/grow.powerUp.png");
        addImage("assets/powerUps/shrink.powerUp.png");
        addImage("assets/powerUps/skip.powerUp.png");
        addImage("assets/powerUps/heal.powerUp.png");
        addImage("assets/items/spell.item.png");
        addImage("assets/40f.png");
        spellbook = spellbook_; // Fixed a thing where you made your own spellbook instead of using the player's spellbook
        theme =theme_;
      
    }

    private void addImage(String name){
        buttons.put(name, loadImage(name));
        buttons.get(name).resize((int)buttonSize,(int)buttonSize);
    }
    
    void makebutton(float width,float height,String image, float size){// draw a button with a size
             image(buttons.get(image), width, height, size, size); // this is not especially fast because it resizes, but it is necessary because of the different sized images
    }

    void RandomSpells(){//gets a random spell 
        spellbook.getSpellIndexed(0).available=true;
        for(int i=0;i<4;i++){
            boolean set=false;     
            while(set==false){
                Random rand = new Random(); //instance of random class
                int random = rand.nextInt(17)+1; 
                if(!spellbook.getSpellIndexed(random).available){
                  spellbook.getSpellIndexed(random).available=true;  
                  set=true;
                    randSpell[i]=random;   
                }              
            }
        }
        RandSpell=true;
    }
    
    
    public void buySpellScreen(String name,int spell){
        fill(255, 165, 44);
        int spellCost=(int)(Math.pow(1.1,spellcount)*100);
        rect(width/9.70,height/4,width*.8,height*0.47407407407);
     
        spellbook.getSpellIndexed(spell).show(width/2-(width/3.125), height/2-(height/4.7),(width/1.5),(width/1.5),theme);
        makebutton(width/2+width/4, height/2+width/4,name,buttonSize);//cancle
        makebutton(width/2-width/2.5, height/2+width/4,name,buttonSize);//buy
  
        textSize(width/15);
        text(spellCost+" coins", width/2.7, height/1.5); 
        textAlign(CENTER, BOTTOM);
        clicked=true;
        
      if(mouseX >= width/2+width/4 && mouseX <= width/2+width/4 + buttonSize && mouseY >= height/2+width/4 && mouseY <= height/2+width/4 + buttonSize&&mousePressed){   //cancle
             for(int i=4;i<8;i++)
             bools[i]=1;
             clicked=false;
        }
        if(mouseX >= width/2-width/2.5 && mouseX <= width/2-width/2.5 + buttonSize && mouseY >= height/2+width/4 && mouseY <=height/2+width/4 + buttonSize&&mousePressed){ 
          spellcount++;
          if(bools[4]==0){
            bought[0]=true;  
            bools[4]=1;//prevents mouse hold
            clicked=false;
          }
          if(bools[5]==0){
            bought[1]=true; 
            bools[5]=1;//prevents mouse hold
            clicked=false;
          }
          if(bools[6]==0){
            bought[2]=true;   
            bools[6]=1;//prevents mouse hold
            clicked=false;
          }
          if(bools[7]==0){
            bought[3]=true;  
            bools[7]=1;//prevents mouse hold
            clicked=false;
          }
        }  
    }

    void buyScreen(String name,PowerUp powerup[]){// you can buy or cancle items
        fill(255, 165, 44);
        int cost=20;
        rect(width/9.70,height/4,width*.8,height*0.47407407407);
        makebutton(width/3, height/3,name,buttonSize*2);//displayimage
        makebutton(width/2+width/4, height/2+width/4,name,buttonSize);//cancle
        makebutton(width/2-width/2.5, height/2+width/4,name,buttonSize);//buy
        
        fill(0, 0, 0);
        textSize(width/15);
        text(cost+" coins", width/2, height/1.5); 
 
        
        clicked=true;

         if(mouseX >= width/2+width/4 && mouseX <= width/2+width/4 + buttonSize && mouseY >= height/2+width/4 && mouseY <= height/2+width/4 + buttonSize&&mousePressed){   //cancle
             for(int i=0;i<4;i++)
             bools[i]=1;
             clicked=false;
        }
        if(mouseX >= width/2-width/2.5 && mouseX <= width/2-width/2.5 + buttonSize && mouseY >= height/2+width/4 && mouseY <=height/2+width/4 + buttonSize&&mousePressed){ //buy
            if(name=="assets/powerUps/grow.powerUp.png"){
                    powerup[0].count++;
                    bools[0]=1;//prevents mouse hold
                    clicked=false;
            }
            if(name=="assets/powerUps/shrink.powerUp.png"&&(bools[1]==0)){
                    powerup[1].count++;
                    bools[1]=1;//prevents mouse hold
                    clicked=false;
            }
            if(name=="assets/powerUps/skip.powerUp.png"&&(bools[2]==0)){
                 powerup[2].count++;
                 bools[2]=1;//prevents mouse hold
                 clicked=false;
            }
            if(name=="assets/powerUps/heal.powerUp.png"&&(bools[3]==0)){
                 powerup[3].count++;
                 bools[3]=1;//prevents mouse hold
                 clicked=false;
            }
        }

    }

    void buttonLayout(){ // creates the layout
        //powerups
        makebutton(new_width, new_height,"assets/powerUps/grow.powerUp.png",buttonSize);
        makebutton(new_width-(width/4.36046511628), new_height,"assets/powerUps/shrink.powerUp.png",buttonSize);
        makebutton(new_width, new_height+(height/9.6428571),"assets/powerUps/skip.powerUp.png",buttonSize);
        makebutton(new_width-(width/4.36046511628), new_height+(height/9.6428571),"assets/powerUps/heal.powerUp.png",buttonSize);
        //spells
        if(bought[0]==false)
          makebutton(new_width-(width/4.36046511628), new_height+(height/5),"assets/items/spell.item.png",buttonSize);
        else
          makebutton(new_width-(width/4.36046511628), new_height+(height/5),Bought,buttonSize);
        
        if(bought[1]==false)
          makebutton(new_width, new_height+(height/5),"assets/items/spell.item.png",buttonSize);
        else
        makebutton(new_width, new_height+(height/5),Bought,buttonSize);
        
        if(bought[2]==false)
          makebutton(new_width+(width/4.36046511628), new_height,"assets/items/spell.item.png",buttonSize);
        else
          makebutton(new_width+(width/4.36046511628), new_height,Bought,buttonSize);
        
        if(bought[3]==false)
          makebutton(new_width+(width/4.36046511628), new_height+(height/9.6428571),"assets/items/spell.item.png",buttonSize);
        else
          makebutton(new_width+(width/4.36046511628), new_height+(height/9.6428571),Bought,buttonSize);
        
  
        //done
        makebutton(new_width, height/1.58,"assets/powerUps/heal.powerUp.png",buttonSize);//chage when done button is made
    } 

    void printshop(PowerUp powerup[]){//prints buysrceen in shop
        //shop
        if(bools[0]==0)
            buyScreen("assets/powerUps/grow.powerUp.png",powerup);
        if(bools[1]==0)
            buyScreen("assets/powerUps/shrink.powerUp.png",powerup);
        if(bools[2]==0)
            buyScreen("assets/powerUps/skip.powerUp.png",powerup);
        if(bools[3]==0)
            buyScreen("assets/powerUps/heal.powerUp.png",powerup);
        if(bools[4]==0)
            buySpellScreen("assets/items/spell.item.png",randSpell[0]);
        if(bools[5]==0)
            buySpellScreen("assets/items/spell.item.png",randSpell[1]);
        if(bools[6]==0)
            buySpellScreen("assets/items/spell.item.png",randSpell[2]);
        if(bools[7]==0)
            buySpellScreen("assets/items/spell.item.png",randSpell[3]);      
    }

    void mouseClicked(){//for the items in the shop
        if(clicked==false){ 
            //power ups
            if(mouseX >= new_width && mouseX <= new_width + buttonSize && mouseY >= new_height && mouseY <= new_height + buttonSize&&mousePressed)
                bools[0]=0;
            
            if(mouseX >= new_width-(width/4.36046511628)&& mouseX <= new_width-(width/4.36046511628) + buttonSize && mouseY >= new_height && mouseY <= new_height + buttonSize&&mousePressed)
                bools[1]=0;

            if(mouseX >= new_width && mouseX <= new_width + buttonSize && mouseY >= new_height+(height/9.6428571) && mouseY <= new_height+(height/9.6428571) + buttonSize&&mousePressed)
                bools[2]=0;

            if(mouseX >= new_width-(width/4.36046511628)&& mouseX <= new_width-(width/4.36046511628) + buttonSize && mouseY >= new_height+(height/9.6428571) && mouseY <= new_height+(height/9.6428571) + buttonSize&&mousePressed)
                bools[3]=0;
            
            
            //spells
            if(mouseX >= new_width-(width/4.36046511628)&& mouseX <= new_width-(width/4.36046511628) + buttonSize && mouseY >= new_height+(height/5) && mouseY <= new_height+(height/5) + buttonSize&&mousePressed&&(bought[0]==false))
                bools[4]=0;
            
            if(mouseX >= new_width&& mouseX <= new_width+ buttonSize && mouseY >= new_height+(height/5) && mouseY <= new_height+(height/5) + buttonSize&&mousePressed&&(bought[1]==false))
                bools[5]=0;
          
            if(mouseX >= new_width+(width/4.36046511628)&& mouseX <= new_width+(width/4.36046511628) + buttonSize && mouseY >= new_height&& mouseY <= new_height+ buttonSize&&mousePressed&&(bought[2]==false))
                bools[6]=0; 
           
           if(mouseX >= new_width+(width/4.36046511628)&& mouseX <= new_width+(width/4.36046511628) + buttonSize && mouseY >= new_height+(height/9.6428571) && mouseY <= new_height+(height/9.6428571) + buttonSize&&mousePressed&&(bought[3]==false))
                bools[7]=0;

        }

    }

    public int exitShop(){ //if done is pressed you return back to battle screen
        if(mouseX >= new_width && mouseX <= new_width + buttonSize && mouseY >= height/1.58 && mouseY <= height/1.58 + buttonSize&&mousePressed){
          for(int i=0;i<4;i++){
           if(bought[i]==false)
           spellbook.getSpellIndexed(randSpell[i]).available=false; 
           bought[i]=false;
          } 
          RandSpell=false;
          return 1;
        }
        return 0; 
    }
     
    public int show(PowerUp powerup[]){
        shop= loadImage("assets/Shop.png");
        if(RandSpell==false)
        RandomSpells();
        background(theme.getBackground());
        image(shop,0,0,wid,hei);
        buttonLayout();
        mouseClicked();
        printshop(powerup);
        return exitShop();     
    }
}
