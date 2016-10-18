package com.pdachoice.rentalroi;

import android.content.res.Configuration;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.ActionBarActivity;
import android.view.Display;
import android.view.View;
import android.view.Window;
import android.view.animation.Animation;
import android.view.animation.AnimationSet;
import android.view.animation.DecelerateInterpolator;
import android.view.animation.TranslateAnimation;

import com.google.analytics.tracking.android.EasyTracker;
import com.google.analytics.tracking.android.MapBuilder;

public class MainActivity extends ActionBarActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    requestWindowFeature(Window.FEATURE_PROGRESS);

    // setup the content view.
    setContentView(R.layout.activity_main);

    // b: Adding the first fragment to the navigation stack.
    pushViewController(new RentalPropertyViewFragment(), false);
  }

  @Override
  public void onStart() {
    super.onStart();
    EasyTracker.getInstance(this).activityStart(this);  // Add this method.
  }

  @Override
  public void onStop() {
    super.onStop();
    EasyTracker.getInstance(this).activityStop(this);  // Add this method.
  }
  
  // to be called when you want to show the toFragments in Activity
  void pushViewController(Fragment toFragment, boolean addToStack) {
    // 1: Create a FragmentTransaction from FragmentManager via activity
    FragmentManager manager = getSupportFragmentManager();
    FragmentTransaction transaction = manager.beginTransaction();
    
    transaction.setCustomAnimations(R.anim.slide_left_enter, R.anim.slide_left_exit, 
        R.anim.slide_right_enter, R.anim.slide_right_exit);

    // 2: tug in this toFragment into Activity ViewGroup
    transaction.replace(R.id.fragment_container, toFragment, toFragment
        .getClass().getSimpleName());
    
    if (addToStack) {
      // 3: add the transaction to the back stack so we can pop it out later
      transaction.addToBackStack(null);
    }

    // 4: commit the transaction.
    transaction.commit();
  }
  
  // Go back to previous screen.
  void popViewController() {
    FragmentManager manager = getSupportFragmentManager();
    manager.popBackStack();
  }

  @Override
  public void onConfigurationChanged(Configuration newConfig) {
    super.onConfigurationChanged(newConfig);

    // do the needful, for example:
    if (newConfig.orientation == Configuration.ORIENTATION_LANDSCAPE) {
      EasyTracker easyTracker = EasyTracker.getInstance(this);

      // MapBuilder.createEvent().build() returns a Map of event fields and values
      // that are set and sent with the hit.
      easyTracker.send(MapBuilder
          .createEvent("config_changed",      // Event category (required)
                       "device_orientation",  // Event action (required)
                       "landscape",           // Event label
                       null)                  // Event value
          .build());      
    } else if (newConfig.orientation == Configuration.ORIENTATION_PORTRAIT) {
      // Toast.makeText(this, "portrait", Toast.LENGTH_SHORT).show();
    }
  }
  
  public static final int SLIDE_UP = 0;
  public static final int SLIDE_DOWN = 1;
  public static final int SLIDE_LEFT = 2;
  public static final int SLIDE_RIGHT = 3;
  public void slideIn(View view, int direction) {
    AnimationSet screentransition = new AnimationSet(true);
    Display display = getWindowManager().getDefaultDisplay(); 
    int width = display.getWidth();  // deprecated
    int height = display.getHeight();  // deprecated
    
    float fromXDelta = 0, fromYDelta = 0;
    
    switch (direction) {
    case SLIDE_UP:
      fromYDelta = height;
      break;
    case SLIDE_DOWN:
      fromYDelta = height * -1;
      break;
    case SLIDE_LEFT:
      fromXDelta = width;
      break;
    case SLIDE_RIGHT:
      fromXDelta = width * -1;
      break;
    default:
      break;
    }
    
    Animation slide = new TranslateAnimation (fromXDelta,0, fromYDelta, 0);
    screentransition.setInterpolator(new DecelerateInterpolator());
    screentransition.addAnimation(slide);
    screentransition.setDuration(200);
    view.startAnimation(screentransition);
  }
 
}
