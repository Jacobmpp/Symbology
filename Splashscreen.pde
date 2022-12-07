import java.util.concurrent.*;
import java.util.Date;
import java.util.concurrent.TimeUnit;

//made by @ardentsuccubus @ardenttcg.com/// 

      


class SplashScreen extends Screen
{
  
  // done is the condition to switch screens and we incre by one for new screen
  boolean done = true; // This is wrong for testing
  //wanted to add more images
  String Filename[] = {"assets/backgrounds/splashScreen.png",
    "assets/backgrounds/SymbologyTitle.png"};

  String loadedString = ""; // Put the string you get from firebase in here before you return true.

  HashMap<String, PImage> Background = new HashMap<String, PImage>(Filename.length*2);
  //constructer
  public SplashScreen(int width,int height)
  {
    super(width,height);
    for(String imageFilename : Filename)
    {
      addImage(imageFilename);
    }
    // Start the google and firebase queries
  }
  //adds image 
  private void addImage(String name){
      Background.put(name, loadImage(name));
  }
    
    
    
     
  //loads image to show
  public boolean show(Player player){
    image(Background.get("assets/backgrounds/splashScreen.png"),    0,  0, wid,     hei  );
    image(Background.get("assets/backgrounds/SymbologyTitle.png"), 50, 50, wid/1.3, wid/10);
    loadFromFilename(player, LOCAL_SAVEDATA_FILENAME);
    return done;
  }
    
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
      
      @Override
      Protected void onActivityResults (int reqquestCode, int Resultcode, intent data){
        super. o n activity result(requestcode,resultCode,data);
        
        
        if(requestCode == 10000){
          //Task google sing in stuff
          
          try {
            
            //navigate to secoundActivity
          }
          catch(ApiException e)
          {
            //error text
          }
          
        
    
    */
  

}
