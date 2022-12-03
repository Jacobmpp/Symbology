package processing.test.symbology;


import android.os.Bundle;
import android.content.Intent;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;


import processing.android.PFragment;
import processing.android.CompatUtils;
import processing.core.PApplet;

import com.google.android.gms.auth.api.signin.GoogleSignInClient;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.games.PlayGamesSdk;
import com.google.firebase.analytics.FirebaseAnalytics;
import com.google.android.gms.auth.api.signin.GoogleSignIn;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInClient;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.common.api.ApiException;
import com.google.android.gms.tasks.Task;



public class MainActivity extends AppCompatActivity {
  private PApplet sketch;
  private FirebaseAnalytics mFirebaseAnalytics;

  GoogleSignInOptions gso;
  GoogleSignInClient gsc;


  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    FrameLayout frame = new FrameLayout(this);
    frame.setId(CompatUtils.getUniqueViewId());
    setContentView(frame, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, 
                                                     ViewGroup.LayoutParams.MATCH_PARENT));

    gso = new GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN).requestEmail().build();
    gsc = GoogleSignIn.getClient(this,gso);
    sketch = new Symbology();
    PlayGamesSdk.initialize(this);

    signIn();

    mFirebaseAnalytics = FirebaseAnalytics.getInstance(this);
    
    PFragment fragment = new PFragment(sketch);
    fragment.setView(frame, this);
  }


  void signIn() {
    Intent signInIntent = gsc.getSignInIntent();
    startActivityForResult(signInIntent, 1000);
  }

  @Override
  public void onRequestPermissionsResult(int requestCode, String permissions[], int[] grantResults) {
    if (sketch != null) {
      sketch.onRequestPermissionsResult(requestCode, permissions, grantResults);
    }
  }


  
  @Override
  public void onNewIntent(Intent intent) {
    if (sketch != null) {
      sketch.onNewIntent(intent);
    }  
  }
  
  @Override
  public void onActivityResult(int requestCode, int resultCode, Intent data) {
    if (sketch != null) {
      sketch.onActivityResult(requestCode, resultCode, data);

    }
      if(requestCode == 1000){
        Task<GoogleSignInAccount> task = GoogleSignIn.getSignedInAccountFromIntent(data);

        try {
          task.getResult(ApiException.class);

        } catch (ApiException e) {
          Toast.makeText(getApplicationContext(), "Something went wrong", Toast.LENGTH_SHORT).show();
        }
      }
  }  
  
  @Override
  public void onBackPressed() {
    if (sketch != null) {
      sketch.onBackPressed();
    }

  }

}
