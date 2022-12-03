package processing.test.symbology;

import android.app.Application;

import com.google.firebase.analytics.FirebaseAnalytics;
import com.google.android.gms.games.PlayGamesSdk;

public class App extends Application {
    private FirebaseAnalytics mFirebaseAnalytics;
    @Override
    public void onCreate() {
        super.onCreate();
        mFirebaseAnalytics = FirebaseAnalytics.getInstance(this);
        PlayGamesSdk.initialize(this);

        // Required initialization logic here!
    }


}
