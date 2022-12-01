import java.util.concurrent.*;
import java.util.Date;
import java.util.concurrent.TimeUnit;

//made by @ardentsuccubus @ardenttcg.com/// 

      


class SplashScreen extends Screen
{
  PImage SS;
  PImage Title;
  //wanted to add more images
String Filename[] = {"assets/backgrounds/splashScreen.png",
  "assets/backgrounds/SymbologyTitle.png"};

 HashMap<String, PImage> Background = new HashMap<String, PImage>(Filename.length*2);
 //constructer
 public SplashScreen(int width,int height)
 {
   super(width,height);
   for(String imageFilename : Filename)
   {
     addImage(imageFilename);
   }
   
 }
 //adds image 
    private void addImage(String name){
        Background.put(name, loadImage(name));
    }
    
    
    
     
    //loads image to show
    public int show()
    {
      // i is the condition to switch screens for the case we are case 1 and we incre by one for new screen
      int i = 0;
      SS = Background.get("assets/backgrounds/splashScreen.png");
      Title = Background.get("assets/backgrounds/SymbologyTitle.png");
      image(SS,0,0,wid,hei);
      image(Title,50,50,wid/1.3,hei/5);
      
      
      //
      
      /*
       this section is for the google play login 
       to call google play then auth the google play for firebase to get the userid from
       the database created
       
       it goes from the email -> user -> string stored to find the data
       
       GoogleSignnInOptions gso;
       GoogleSignInClient gsc;
       
       
       gso = new GoogleSignInoption.Builder (GoogleSignInOptions.DEFAULT_sign_in).requestEmail.().Build)'
       
       gsc = GoogleSignIn.getClient();
       
       
       SignIn();
       
       
       void SignIn()
       {
         Intent  signInIntent = gsc.getSignInIntent();
         startActivityForResult(signInIntent,1000);
       }
       
       @overide
       Protected void onActivityResults (int reqquestCode, int Resultcode, intent data){
         super. o n activity result(requestcode,resultCode,data);
         
         
         if(requestCode == 10000){
           Task google sing in stuff
           
           try {
             
             navigate to secoundActivity
           }
           catch(ApiException e)
           {
             error text
           }
           
         
      
      */
      
      //
      
      //fade()
      
      return i;
    }
  

}
