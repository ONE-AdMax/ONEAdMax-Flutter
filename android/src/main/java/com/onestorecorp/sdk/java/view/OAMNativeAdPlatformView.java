package com.onestorecorp.sdk.java.view;


import static com.onestorecorp.sdk.java.OneAdMaxFlutterPlugin.ADMAX_CHANNEL_BASE_NAME;

import android.view.View;

import com.gaa.sdk.base.Logger;
import com.oneadmax.global.OAMError;
import com.oneadmax.global.OAMNative;
import com.oneadmax.global.listener.IOAMNativeEventListener;
import com.oneadmax.global.viewbinder.AppLovinMaxViewBinder;
import com.oneadmax.global.viewbinder.MobonViewBinder;
import com.oneadmax.global.viewbinder.OAMViewBinder;

import java.util.HashMap;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class OAMNativeAdPlatformView implements PlatformView, IOAMNativeEventListener {
    private OAMNative oamNative;
    private MethodChannel channel;

    // Constructor for mediation
    public <T> OAMNativeAdPlatformView(OAMNative oamNative, HashMap<String, Object> creationParams, OAMViewBinder oamViewBinder, T mediationViewBinder, BinaryMessenger binaryMessenger) {
        Logger.d("AdMaxNativeAdPlatformView", "AdMaxNativeMediation init");

        this.channel = new MethodChannel(binaryMessenger, ADMAX_CHANNEL_BASE_NAME + "/native");
        this.oamNative = oamNative;
        String placementId = creationParams.get("placementId") != null ? (String) creationParams.get("placementId") : "";
        Logger.d("AdMaxNativeAdPlatformView", "ViewBinder : " + mediationViewBinder.toString());

        // Set placementId, eventListener, and viewBinder
        oamNative.setPlacementId(placementId);
        oamNative.setEventListener(this);
        oamNative.setViewBinder(oamViewBinder);

        if (mediationViewBinder instanceof AppLovinMaxViewBinder) {
            oamNative.setAppLovinMaxViewBinder((AppLovinMaxViewBinder) mediationViewBinder);
        } else if (mediationViewBinder instanceof MobonViewBinder) {
            oamNative.setMobonViewBinder((MobonViewBinder) mediationViewBinder);
        } else {
            // In case of incorrect mediation viewbinder
            Logger.d("AdMaxNativeAdPlatformView", "ViewBinder is incorrect type");
            channel.invokeMethod("onLoadFailed", null);

        }

        Logger.d("AdMaxNativeAdView", "mediation Native load");

        oamNative.load();
    }


    // Constructor for non-mediation
    public OAMNativeAdPlatformView(OAMNative oamNative, HashMap<String, Object> creationParams, OAMViewBinder oamViewBinder, BinaryMessenger binaryMessenger) {
        Logger.d("AdMaxNativeAdPlatformView", "AdMaxPureNative init");

        this.channel = new MethodChannel(binaryMessenger, ADMAX_CHANNEL_BASE_NAME + "/native");
        this.oamNative = oamNative;

        // Set placementId, eventListener, and viewBinder
        String placementId = creationParams.get("placementId") != null ? (String) creationParams.get("placementId") : "";
        oamNative.setViewBinder(oamViewBinder);
        oamNative.setPlacementId(placementId);
        oamNative.setEventListener(this);

        Logger.d("AdMaxNativeAdPlatformView", "Pure Native load");
        oamNative.load();
    }


    /**
     * Returns the Android view that will be rendered on the Flutter side.
     *
     * @return
     */
    @Override
    public View getView() {
        return oamNative;
    }

    /**
     *  native ad dispose
     */
    @Override
    public void dispose() {
        Logger.d("AdMaxNativeAdPlatformView", "SDK dispose");
        oamNative.destroy();
    }

    /**
     *  native ad Loaded
     */
    @Override
    public void onLoaded() {
        Logger.d("AdMaxNativeAdPlatformView", "onLoaded");
        channel.invokeMethod("onLoaded", null);
    }

    /**
     *  native ad Load Failed
     * @param oamError
     */
    @Override
    public void onLoadFailed(OAMError oamError) {
        Logger.d("AdMaxNativeAdPlatformView", "onLoadFailed : " + oamError.toString());
        HashMap<String, Object> resultArgMap = new HashMap<>();
        resultArgMap.put("code", oamError.getCode());
        if (oamError.getMessage() != null) resultArgMap.put("message", oamError.getMessage());
        channel.invokeMethod("onLoadFailed", resultArgMap);
    }

    /**
     *  native ad Opened
     */
    @Override
    public void onOpened() {
        Logger.d("AdMaxNativeAdPlatformView", "onOpened");
        channel.invokeMethod("onOpened", null);
    }

    /**
     * native ad Clicked
     */
    @Override
    public void onClicked() {
        Logger.d("AdMaxNativeAdPlatformView", "onClicked");
        channel.invokeMethod("onClicked", null);
    }

    @Override
    public void onAdHidden() {
        Logger.d("AdMaxNativeAdPlatformView", "onAdHidden");
        channel.invokeMethod("onAdHidden", null);
    }

    @Override
    public void onFlutterViewDetached() {
        Logger.d("AdMaxNativeAdPlatformView", "onFlutterViewDetached");
        oamNative.destroy();
    }
}
