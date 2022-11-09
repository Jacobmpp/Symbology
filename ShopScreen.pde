import java.util.Random;


class ShopScreen extends Screen{
    PowerUp powerUps[];
    PImage shop;
    HashMap<String, PImage> buttons = new HashMap<String, PImage>(10);
    float new_width=width/3+(width/12.5);
    float new_height=height/3-(height/33.75);
    int buttonSize = 62;
    boolean clicked=false;//prevents overlaping screens
    int bools[]={1,1,1,1};//prevents overlaping screens
    Spellbook spellbook;
    Spell[] spell;

    public ShopScreen(int width_, int height_, Spellbook spellbook_){
        super(width_, height_);
        addImage("assets/powerUps/grow.powerUp.png");
        addImage("assets/powerUps/shrink.powerUp.png");
        addImage("assets/powerUps/skip.powerUp.png");
        addImage("assets/powerUps/heal.powerUp.png");
        addImage("assets/items/spell.item.png");
        spellbook = spellbook_; // Fixed a thing where you made your own spellbook instead of using the player's spellbook
    }

    private void addImage(String name){
        buttons.put(name, loadImage(name));
        buttons.get(name).resize(buttonSize,buttonSize);
    }
    
    void makebutton(float width,float height,String image, int size){// draw a button with a size
             image(buttons.get(image), width, height, size, size); // this is not especially fast because it resizes, but it is necessary because of the different sized images
    }

    void RandomSpells(Spell[] spell){//gets a random spell 
        for(int i=0;i<4;i++){
            boolean set=false;     
            while(set==false){
                Random rand = new Random(); //instance of random class
                int random = rand.nextInt(10); 
                spell[i]=    spellbook.getSpell(random);
                print(spell[i].name); 
            }
        } 
    }

    void buyScreen(String name,PowerUp powerup[]){// you can buy or cancle items
        // You are gonna have to fix so much hard coding, I lowkey feel sorry for you.
        // You may consider a scaleFactor like just put *scaleFactorX or Y by each hard coded value
        // scaleFactorX based on width and scaleFactorY based on height ezpz
        rect(width/5-37,height/4,300,300);
        fill(255,255,255);
        makebutton(width/2-70, height/2-170,name,150);//displayimage
        makebutton(width/2+80, height/2+60,name,70);//cancle
        makebutton(width/2-150, height/2+60,name,70);//buy
        clicked=true;

        if(mouseX >= width/2+80 && mouseX <= width/2+80 + 70 && mouseY >= height/2+60 && mouseY <= height/2+60 + 70&&mousePressed){   //cancle
             for(int i=0;i<4;i++)
             bools[i]=1;
             clicked=false;
        }
        if(mouseX >= width/2-150 && mouseX <= width/2-150 + 70 && mouseY >= height/2+60 && mouseY <= height/2+60 + 70&&mousePressed){ //buy
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
        //powers
        makebutton(new_width, new_height,"assets/powerUps/grow.powerUp.png",width*0.16533333333);
        makebutton(new_width-(width/4.36046511628), new_height,"assets/powerUps/shrink.powerUp.png",width*0.16533333333);
        makebutton(new_width, new_height+70,"assets/powerUps/skip.powerUp.png",width*0.16533333333);
        makebutton(new_width-(width/4.36046511628), new_height+(height/9.6428571),"assets/powerUps/heal.powerUp.png",width*0.16533333333);
        //spells
        makebutton(new_width-(width/4.36046511628), new_height+(height/4.82142857143),"assets/items/spell.item.png",width*0.16533333333);
        makebutton(new_width, new_height+(height/4.82142857143),"assets/items/spell.item.png",width*0.16533333333);
        makebutton(new_width+(width/4.36046511628), new_height,"assets/items/spell.item.png",width*0.16533333333);
        makebutton(new_width+(width/4.36046511628), new_height+(height/9.6428571),"assets/items/spell.item.png",width*0.16533333333);
        //done
        makebutton(new_width, new_height+230,"assets/powerUps/heal.powerUp.png",width*0.16533333333);//chage when done button is made
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
            if(mouseX >= new_width && mouseX <= new_width + width*0.16533333333 && mouseY >= new_height && mouseY <= new_height + width*0.16533333333&&mousePressed)

            bools[0]=0;
            if(mouseX >= new_width-86&& mouseX <= new_width-(width/4.36046511628) + width*0.16533333333 && mouseY >= new_height && mouseY <= new_height + width*0.16533333333&&mousePressed)
            bools[1]=0;

            if(mouseX >= new_width && mouseX <= new_width + width*0.16533333333 && mouseY >= new_height+(height/9.6428571) && mouseY <= new_height+(height/9.6428571) + width*0.16533333333&&mousePressed)
            bools[2]=0;

            if(mouseX >= new_width-(width/4.36046511628)&& mouseX <= new_width-(width/4.36046511628) + width*0.16533333333 && mouseY >= new_height+(height/9.6428571) && mouseY <= new_height+(height/9.6428571) + width*0.16533333333&&mousePressed)
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
