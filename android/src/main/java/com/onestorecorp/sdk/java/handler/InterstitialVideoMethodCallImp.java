package com.onestorecorp.sdk.java.handler;

import android.content.Context;

import com.gaa.sdk.base.Logger;
import com.oneadmax.global.OAMError;
import com.oneadmax.global.OAMInterstitialVideo;
import com.oneadmax.global.listener.IOAMInterstitialVideoEventListener;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class InterstitialVideoMethodCallImp implements MethodChannel.MethodCallHandler, IOAMInterstitialVideoEventListener {

    private final MethodChannel channel;
    private final OAMInterstitialVideo interstitialVideo;

    public InterstitialVideoMethodCallImp(MethodChannel channel, Context context) {
        this.channel = channel;
        this.interstitialVideo = new OAMInterstitialVideo(context);
        this.interstitialVideo.setEventListener(this);
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "load":
                String placementId = call.argument("placementId") != null ? call.argument("placementId") : "";
                Logger.d("InterstitialVideoMethodCallImp", "InterstitialVideo load: " + placementId);
                interstitialVideo.setPlacementId(placementId);

                int networkTimeout = call.argument("networkTimeout") != null ? call.argument("networkTimeout") : 5;
                interstitialVideo.setNetworkScheduleTimeout(networkTimeout);

                interstitialVideo.load();
                break;

            case "show":
                Logger.d("InterstitialVideoMethodCallImp", "show InterstitialVideo");
                interstitialVideo.show();
                break;
            case "dispose":
                Logger.d("InterstitialVideoMethodCallImp", "InterstitialVideo dispose");
                if (interstitialVideo != null) {
                    interstitialVideo.destroy();
                }
                break;

            default:
                result.notImplemented();
                break;
        }
    }

    /**
     * InterstitialVideo Loaded
     */
    @Override
    public void onLoaded() {
        channel.invokeMethod("onLoaded", null);
    }

    /**
     * InterstitialVideo Load Failed
     *
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
     * InterstitialVideo Opened
     */
    @Override
    public void onOpened() {
        channel.invokeMethod("onOpened", null);
    }

    /**
     * InterstitialVideo Open Failed
     *
     * @param error
     */
    @Override
    public void onOpenFailed(OAMError error) {
        HashMap<String, Object> resultArgMap = new HashMap<>();
        resultArgMap.put("code", error.getCode());
        if (error.getMessage() != null) resultArgMap.put("message", error.getMessage());
        channel.invokeMethod("onOpenFailed", resultArgMap);
    }

    /**
     * When the InterstitialVideo ends
     */
    @Override
    public void onClosed() {
        channel.invokeMethod("onClosed", null);
    }

    /**
     * When the InterstitialVideo is clicked
     */
    @Override
    public void onClicked() {
        channel.invokeMethod("onClicked", null);
    }
}