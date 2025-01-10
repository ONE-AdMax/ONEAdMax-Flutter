package com.onestorecorp.sdk.java.handler;

import android.content.Context;
import android.graphics.Color;
import android.util.Log;

import com.gaa.sdk.base.Logger;
import com.oneadmax.global.OAMError;
import com.oneadmax.global.OAMInterstitial;
import com.oneadmax.global.enums.OAMCloseEvent;
import com.oneadmax.global.listener.IOAMInterstitialEventListener;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class InterstitialMethodCallImp implements MethodChannel.MethodCallHandler, IOAMInterstitialEventListener {

    private final MethodChannel channel;
    private final OAMInterstitial interstitialAds;

    private final String TAG = "InterstitialMethodCall";

    public InterstitialMethodCallImp(MethodChannel channel, Context context) {
        this.channel = channel;
        this.interstitialAds = new OAMInterstitial(context);
        this.interstitialAds.setEventListener(this);
    }

    /**
     *  this method is called when the Flutter app sends a message to the platform channel.
     * @param call A {@link MethodCall}.
     * @param result A {@link Result} used for submitting the result of the call.
     */
    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {

            case "load":
                String placementId = call.argument("placementId") != null ? call.argument("placementId") : "";
                Logger.d(TAG, "Interstitial ads Loaded");
                interstitialAds.setPlacementId(placementId);
                interstitialAds.load();
                break;

            case "show":

                HashMap<String, Object> customExtraArgument;

                if (call.arguments instanceof HashMap) {
                    customExtraArgument = (HashMap<String, Object>) call.arguments;
                } else {
                    result.error("customExtraArgumentException", "customExtraArgumant is empty", null);
                    break;
                }

                Logger.d(TAG, "show : " + customExtraArgument.toString());

                int parsedColor = Color.parseColor((String) customExtraArgument.get("backgroundColor"));
                customExtraArgument.put("backgroundColor", parsedColor);

                interstitialAds.setCustomExtras(customExtraArgument);
                interstitialAds.show();
                break;
            case "dispose" :
                interstitialAds.destroy();
                break;

            default:
                result.notImplemented();
                break;
        }
    }

    /**
     * this method is called when the interstitial ad is loaded.
     */
    @Override
    public void onLoaded() {
        channel.invokeMethod("onLoaded", null);
    }

    /**
     * this method is called when the interstitial ad is failed to load.
     * @param error
     */
    @Override
    public void onLoadFailed(OAMError error) {
        HashMap<String, Object> resultArgMap = new HashMap<>();
        resultArgMap.put("code", error.getCode());
        if (error.getMessage() != null) resultArgMap.put("message", error.getMessage());
        channel.invokeMethod("onLoadFailed", resultArgMap);
    }

    /**
     * this method is called when the interstitial ad is opened.
     */
    @Override
    public void onOpened() {
        channel.invokeMethod("onOpened", null);
    }

    /**
     * this method is called when the interstitial ad is failed to open.
     * @param error
     */

    @Override
    public void onOpenFailed(OAMError error) {
        HashMap<String, Object> resultArgMap = new HashMap<>();
        resultArgMap.put("code", error.getCode());
        if (error.getMessage() != null) resultArgMap.put("message", error.getMessage());
        Log.d(TAG, "onOpenFailed : " + error.toString());
        channel.invokeMethod("onOpenFailed", resultArgMap);
    }

    /**
     * this method is called when the interstitial ad is closed.
     * @param oamCloseEvent
     */
    @Override
    public void onClosed(OAMCloseEvent oamCloseEvent) {
        HashMap<String, Object> resultArgMap = new HashMap<>();
        resultArgMap.put("closeEvent", oamCloseEvent.name());
        Log.d(TAG, "onClosed : " + oamCloseEvent.name());

        channel.invokeMethod("onClosed", resultArgMap);
    }

    /**
     * this method is called when the interstitial ad is clicked.
     */
    @Override
    public void onClicked() {
        channel.invokeMethod("onClicked", null);
    }
}