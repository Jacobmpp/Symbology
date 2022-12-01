import java.util.concurrent.*;
import java.util.Date;
import java.util.concurrent.TimeUnit;

//made by @ardentsuccubus @ardenttcg.com/// 

      


class SplashScreen extends Screen
{
  PImage SS;
String Filename[] = {"assets/backgrounds/splashScreen.png",
  "assets/backgrounds/SymbologyTitle.png"};

 HashMap<String, PImage> Background = new HashMap<String, PImage>(Filename.length*2);
 
 public SplashScreen(int width,int height)
 {
   super(width,height);
   for(String imageFilename : Filename)
   {
     addImage(imageFilename);
   }
   
 }
 
    private void addImage(String name){
        Background.put(name, loadImage(name));
    }
    
    
    
     
    
    public int show()
    {
      int i = 0;
      SS = Background.get("assets/backgrounds/splashScreen.png");
      image(SS,0,0,wid,hei);
      
      
      
      
      
      
      return i;
    }
  

}
