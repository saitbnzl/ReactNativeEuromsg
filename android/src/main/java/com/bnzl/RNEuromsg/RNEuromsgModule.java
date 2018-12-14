
package com.bnzl.RNEuromsg;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.LifecycleEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import euromsg.com.euromobileandroid.EuroMobileManager;
import euromsg.com.euromobileandroid.utils.EuroLogger;

import static com.google.android.gms.internal.zzs.TAG;


public class RNEuromsgModule extends ReactContextBaseJavaModule implements ActivityEventListener, LifecycleEventListener {
  public  static EuroMobileManager sharedEuroManagerInstance;

  public static EuroMobileManager sharedEuroManager(Context context, String applicationKey, String senderId) {
    if (sharedEuroManagerInstance == null) {
      sharedEuroManagerInstance = new EuroMobileManager(applicationKey,context);
    }
    sharedEuroManagerInstance.senderId = senderId;
    EuroLogger.debugLog("SharedManager App Key : " + sharedEuroManagerInstance.subscription.getAppKey());
    return sharedEuroManagerInstance;
  }

  public class Constant {
    public static final String EURO_KEY = "APP_ID";
  }

  private ReactApplicationContext reactContext;

  public RNEuromsgModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
    this.reactContext.addActivityEventListener(this);

    this.sharedEuroManagerInstance = this.sharedEuroManager(reactContext, Constant.EURO_KEY, "402215696693");
  }

  @Override
  public void onNewIntent(Intent intent) {
    Log.d("onNewIntent", intent.toString());
    Bundle extras = intent.getExtras();
    if(extras!=null){
      WritableMap params = Arguments.createMap();
      params.putString("url",extras.getString("url"));
      this.sendEvent(this.reactContext,"opened", params);
    }
  }

  public static void sendEvent(ReactContext reactContext,
                               String eventName,
                               @Nullable WritableMap map) {
    reactContext
            .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
            .emit(eventName, map);
  }

  @ReactMethod
  public void configUser(ReadableMap config) {
    PackageInfo pInfo = null;
    try {
      pInfo = this.reactContext.getApplicationContext().getPackageManager().getPackageInfo(this.reactContext.getPackageName(), 0);
    } catch (PackageManager.NameNotFoundException e) {
      e.printStackTrace();
    }
    sharedEuroManagerInstance.setEmail(config.getString("email"));
    sharedEuroManagerInstance.setEuroUserKey(config.getString("userKey"));
    if(pInfo!=null)
      sharedEuroManagerInstance.setAppVersion(pInfo.versionName);
    sharedEuroManagerInstance.sync();
  }

  public static void registerToken(String token){
    sharedEuroManagerInstance.subscribe(token);
  }

  public static void reportRead(String pushId){
    sharedEuroManagerInstance.reportRead(pushId);
  }

  @ReactMethod
  public void getInitialNotification(Promise promise){
    Activity activity = getCurrentActivity();
    if(activity == null){
      promise.resolve(null);
      return;
    }
    promise.resolve(parseIntent(activity.getIntent()));
  }

  private WritableMap parseIntent(Intent intent){
    WritableMap params = Arguments.createMap();
    Bundle extras = intent.getExtras();
    if(extras!=null)
    if (extras != null) {
      try {
        String url = extras.getString("url");
        Log.d("parseIntent url", url);
        if(url!=null)
          params.putString("url", url);
      }
      catch (Exception e){
        params = Arguments.createMap();

      }
    } else {
      params = Arguments.createMap();
    }
    Log.d("parseIntent", params.toString());
    return params;
  }

  @Override
  public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {

  }

  @Override
  public void onHostResume() {

  }

  @Override
  public void onHostPause() {

  }

  @Override
  public void onHostDestroy() {

  }
  @Override
  public String getName() {
    return "RNEuromsg";
  }
}