import java.util.Random;
import java.lang.Math;


class ShopScreen extends Screen{
    private static final float widthRatio  = 4.3605;
    private static final float heightRatio = 9.6429;
    private final float new_width   = width/3+(width/25f*2);
    private final float new_height  = height/3-(height/(135f/4));
    private final float buttonSize  = width*(496f/3000);

    PowerUp powerUps[];
    Theme theme;
    PImage shop;
    String buttonFilenames[] = { 
        "assets/powerUps/grow.powerUp.png", 
        "assets/powerUps/shrink.powerUp.png", 
        "assets/powerUps/skip.powerUp.png", 
        "assets/powerUps/heal.powerUp.png", 
        "assets/buttons/buy.png", 
        "assets/buttons/cancel.png", 
        "assets/buttons/chest.png", 
        "assets/buttons/go.png", 
        "assets/items/spell.item.png", 
        "assets/40f.png", 
        "assets/Shop.png",
        "assets/items/shopkeeper.png"
        };
    HashMap<String, PImage> buttons = new HashMap<String, PImage>(buttonFilenames.length*2);
    boolean clicked=false;//prevents overlaping screens
    int bools[]={1, 1, 1, 1, 1, 1, 1, 1,1};//prevents overlaping screens
    Spellbook spellbook;
    int randSpell[]={1, 2, 3, 4};
    boolean RandSpell=false;
    boolean bought[]={false, false, false, false,false};//prevents repeats spells
    String Bought="assets/buttons/chest.png";//will appear if you buy spell
    int spellcount=1;
    int cantAfford=0;
    int max=0;
    int Statprice=0;
   
    Player player;
    
    
    public void getStatPrice(){

       if(player.currency>max)
       max=player.currency;
       
       float random = random(1.5)+.2; 
       Statprice=int(max*random);
         
        
    }
    
   
    public ShopScreen(int width_, int height_, Player player_, Theme theme_){
        super(width_, height_);
        for(String imageFilename : buttonFilenames){
            addImage(imageFilename);
        }
        player=player_;
        spellbook = player_.spellbook; // Fixed a thing where you made your own spellbook instead of using the player's spellbook
        theme = theme_;
        
    }

    private void addImage(String name){
        buttons.put(name, loadImage(name));
    }
    
    void makebutton(float width, float height, String image, float size){ // draw a button with a size
        image(buttons.get(image), width, height, size, size); // this is not especially fast because it resizes, but it is necessary because of the different sized images
    }
    
    
    public boolean priceCheck(int price){
      if(player.getCurrency()<price){
        for(int i=0;i<8;i++)
           bools[i]=1;
           clicked=false;
           cantAfford=1;
           return false;   
      }
      return true;
    }
    
    /*public void shoopKeeper(){
        if(clicked==false){
          makebutton(new_width+(width/widthRatio), new_height+(height/5), "assets/items/shopkeeper.png", buttonSize);
          if(cantAfford==1){
             textSize(width/25);
             text("why you no\n"+ "have money",new_width+(width/widthRatio)*1.4,new_height+(height/5)*1.53);  
          }
        }     
    }
*/
    void RandomSpells(){//gets a random spell 
        spellbook.getSpellIndexed(0).available=true;
        int remaining=min(spellbook.someSpellsUnavailable(), 4);

        for(int i=0;i<4;i++){
            boolean set=false;  
            if(i>=remaining){
                set=true;
                randSpell[i]=-1; 
            } else while(set==false){
                int random = floor(random(spellbook.getSpellCount()-1)+1); 
                if(!spellbook.getSpellIndexed(random).available){
                    spellbook.getSpellIndexed(random).available=true;  
                    set=true;
                    randSpell[i]=random;   
                
                }        
            }
        }   

        RandSpell=true;
    }
    
    public void StatScreen(){     
   
      if( bought[4]==false){
       bought[4]=true;
       getStatPrice();   
      }
    
      fill(255, 165, 44); 
     
      rect(width/9.70, height/4, width*.8, height*0.47407407407);
      
      makebutton(width/3, height/3, "assets/items/shopkeeper.png", buttonSize*2);//displayimage change whne image made
      makebutton(3*width/4, height/2+width/4, "assets/buttons/cancel.png", buttonSize);//cancel
      makebutton(width/10, height/2+width/4, "assets/buttons/buy.png", buttonSize);//buy
      fill(0, 0, 0);
      textSize(width/15);
      text(Statprice+" coins", width/2, height/1.5); 
      text(player.getUpgrade(), width/2, height/1.8); 
      
      
       if(mouseX >= width/2+width/4 && mouseX <= width/2+width/4 + buttonSize && mouseY >= height/2+width/4 && mouseY <= height/2+width/4 + buttonSize && mousePressed){   //cancle
             bools[8]=1;
             clicked=false;
       }
       if(mouseX >= width/2-width/2.5 && mouseX <= width/2-width/2.5 + buttonSize && mouseY >= height/2+width/4 && mouseY <=height/2+width/4 + buttonSize && mousePressed){ 
         print("hi"); 
         if(priceCheck(Statprice)){
           if(bools[8]==0){
            bought[4]=false;  
            bools[8]=1;//prevents mouse hold
            player.upgrade();
            clicked=false;
            
           }
            player.setCurrency(player.getCurrency()-Statprice);
            cantAfford=0;
          
           }  
        }  
    
 
    }
    
    public void buySpellScreen(int spell){
        fill(255, 165, 44);
        int spellCost=(int)(Math.pow(1.1, spellcount)*100);
        rect(width/9.70, height/4, width*.8, height*0.47407407407);
     
        spellbook.getSpellIndexed(spell).show(width/2-(width/3.125), height/2-(height/4.7), (width/1.5), (width/1.5), theme);
        makebutton(3*width/4, height/2+width/4, "assets/buttons/cancel.png", buttonSize);//cancel
        makebutton(width/10, height/2+width/4, "assets/buttons/buy.png", buttonSize);//buy
    
        textSize(width/15);
        text(spellCost+" coins", width/2.7, height/1.5); 
        textAlign(CENTER);
        clicked=true;
        
        if(mouseX >= width/2+width/4 && mouseX <= width/2+width/4 + buttonSize && mouseY >= height/2+width/4 && mouseY <= height/2+width/4 + buttonSize && mousePressed){   //cancle
             for(int i=4;i<8;i++)
             bools[i]=1;
             clicked=false;
        }
        if(mouseX >= width/2-width/2.5 && mouseX <= width/2-width/2.5 + buttonSize && mouseY >= height/2+width/4 && mouseY <=height/2+width/4 + buttonSize && mousePressed){ 
          if(priceCheck(spellCost)){
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
            player.setCurrency(player.getCurrency()-spellCost);
            cantAfford=0;
           }
        }  
    }

    void buyScreen(String name, PowerUp powerup[]){// you can buy or cancle items
        fill(255, 165, 44);
        int cost=20;
        rect(width/9.70, height/4, width*.8, height*0.47407407407);
        makebutton(width/3, height/3, name, buttonSize*2);//displayimage
        makebutton(width/2+width/4, height/2+width/4, "assets/buttons/cancel.png", buttonSize);//cancle
        makebutton(width/2-width/2.5, height/2+width/4, "assets/buttons/buy.png", buttonSize);//buy
        
        fill(0, 0, 0);
        textSize(width/15);
        text(cost+" coins", width/2, height/1.5); 
 
        
        clicked=true;

         if(mouseX >= width/2+width/4 && mouseX <= width/2+width/4 + buttonSize && mouseY >= height/2+width/4 && mouseY <= height/2+width/4 + buttonSize && mousePressed){   //cancle
             for(int i=0;i<4;i++)
             bools[i]=1;
             clicked=false;
        }
        if(mouseX >= width/2-width/2.5 && mouseX <= width/2-width/2.5 + buttonSize && mouseY >= height/2+width/4 && mouseY <=height/2+width/4 + buttonSize && mousePressed){ //buy
           
            if(priceCheck(cost)){
              if(name=="assets/powerUps/grow.powerUp.png"){
                    powerup[0].count++;
                    bools[0]=1;//prevents mouse hold
                    clicked=false;
              }
              if(name=="assets/powerUps/shrink.powerUp.png" && (bools[1]==0)){
                    powerup[1].count++;
                    bools[1]=1;//prevents mouse hold
                    clicked=false;
              }
              if(name=="assets/powerUps/skip.powerUp.png" && (bools[2]==0)){
                   powerup[2].count++;
                   bools[2]=1;//prevents mouse hold
                   clicked=false;
              }
              if(name=="assets/powerUps/heal.powerUp.png" && (bools[3]==0)){
                   powerup[3].count++;
                   bools[3]=1;//prevents mouse hold
                   clicked=false;
              }
              player.setCurrency(player.getCurrency()-cost);
              cantAfford=0;
            }
        }

    }
    
    
    void spellPurOrNot(int Boughtnum,String name,float width ,float height,float size){
      
       if(!bought[Boughtnum]){
    
               makebutton(width, height,name,size);
        } 
        else
            makebutton(width, height,Bought,size);
    }

    void buttonLayout(){ // creates the layout
    
        textSize(width/15);
        text(player.getCurrency()+" coins", new_width*1.2, new_height-(height/heightRatio)*.6); 
        textAlign(CENTER);
        
        String name="assets/items/spell.item.png";
        
        //powerups
        makebutton(new_width, new_height, "assets/powerUps/grow.powerUp.png", buttonSize);
        makebutton(new_width-(width/widthRatio), new_height, "assets/powerUps/shrink.powerUp.png", buttonSize);
        makebutton(new_width, new_height+(height/heightRatio), "assets/powerUps/skip.powerUp.png", buttonSize);
        makebutton(new_width-(width/widthRatio), new_height+(height/heightRatio), "assets/powerUps/heal.powerUp.png", buttonSize);
        
        //spells
        spellPurOrNot(0,name,new_width-(width/widthRatio),new_height+(height/5),buttonSize);
        spellPurOrNot(1,name,new_width,new_height+(height/5),buttonSize);
        spellPurOrNot(2,name,new_width+(width/widthRatio),new_height,buttonSize);
        spellPurOrNot(3,name,new_width+(width/widthRatio), new_height+(height/heightRatio),buttonSize);
        
        makebutton(new_width+(width/widthRatio), new_height+(height/5), "assets/items/shopkeeper.png", buttonSize);//chage when image is ready
      

    
        //done
        makebutton(new_width, height/1.58, "assets/buttons/go.png", buttonSize);//chage when done button is made
    } 

    void printshop(PowerUp powerup[]){//prints buysrceen in shop
        //shop
        if(bools[0]==0)
            buyScreen("assets/powerUps/grow.powerUp.png", powerup);
        if(bools[1]==0)
            buyScreen("assets/powerUps/shrink.powerUp.png", powerup);
        if(bools[2]==0)
            buyScreen("assets/powerUps/skip.powerUp.png", powerup);
        if(bools[3]==0)
            buyScreen("assets/powerUps/heal.powerUp.png", powerup);
        for(int i = 0; i < 4; i++)
            if(bools[i+4]==0 && randSpell[i]!=-1)
                buySpellScreen(randSpell[i]); 
                
        if(bools[8]==0)
          StatScreen();
    }

    void mouseClicked(int boolnum,float new_width,float new_height,float buttonSize ){//for the items in the shop
        if(clicked==false){ 
            //power ups
            if(mouseX >= new_width && mouseX <= new_width + buttonSize && mouseY >= new_height && mouseY <= new_height + buttonSize && mousePressed)
                bools[boolnum]=0;     
        }

    }
    
    public void presses(){
      //powerup
      mouseClicked(0,new_width,new_height,buttonSize);
      mouseClicked(1,new_width-(width/widthRatio),new_height,buttonSize);
      mouseClicked(2,new_width,new_height+(height/heightRatio),buttonSize);
      mouseClicked(3,new_width-(width/widthRatio) ,new_height+(height/heightRatio),buttonSize);
      //spell
  
      if(bought[0]==false)
      mouseClicked(4,new_width-(width/widthRatio),new_height+(height/5),buttonSize);
      if(bought[1]==false)
      mouseClicked(5,new_width,new_height+(height/5),buttonSize);
      if(bought[2]==false)
      mouseClicked(6,new_width+(width/widthRatio),new_height,buttonSize);
      if(bought[3]==false)
      mouseClicked(7,new_width+(width/widthRatio),new_height+(height/heightRatio),buttonSize);
      
      
      mouseClicked(8,new_width+(width/widthRatio),new_height+(height/5),buttonSize);
      
      
    }

    public int exitShop(){ //if done is pressed you return back to battle screen
        if(mouseX >= new_width && mouseX <= new_width + buttonSize && mouseY >= height/1.58 && mouseY <= height/1.58 + buttonSize && mousePressed){
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
        shop = buttons.get("assets/Shop.png");
        if(RandSpell==false)
        RandomSpells();
        background(theme.getBackground());
        image(shop, 0, 0, wid, hei);
        buttonLayout();
        presses();
        printshop(powerup);
        //shoopKeeper();
        return exitShop();   
    }
}
