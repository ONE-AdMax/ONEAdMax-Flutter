package com.onestorecorp.sdk.java.handler;

import android.content.Context;
import android.util.Log;

import com.gaa.sdk.base.Logger;
import com.oneadmax.global.OAMError;
import com.oneadmax.global.OAMRewardVideo;
import com.oneadmax.global.listener.IOAMRewardVideoEventListener;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class RewardMethodCallImp implements MethodChannel.MethodCallHandler, IOAMRewardVideoEventListener {

    private final MethodChannel channel;

    private final OAMRewardVideo rewardVideoAd;

    public RewardMethodCallImp(MethodChannel channel, Context context) {
        this.channel = channel;
        this.rewardVideoAd = new OAMRewardVideo(context);
        this.rewardVideoAd.setEventListener(this);
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        if (rewardVideoAd == null) {
            result.error("rewardVideoAd", "rewardVideoAd is null", null);
            return;
        }

        switch (call.method) {
            case "load":
                String placementId = call.argument("placementId") != null ? call.argument("placementId") : "";
                rewardVideoAd.setPlacementId(placementId);

                int networkTimeout = call.argument("networkTimeout") != null ? call.argument("networkTimeout") : 5;
                rewardVideoAd.setNetworkScheduleTimeout(networkTimeout);

                rewardVideoAd.load();
                break;

            case "show":
                if (rewardVideoAd.isLoaded()) {
                    rewardVideoAd.show();
                } else {
                    result.error("rewardVideoAd", "rewardVideoAd is not loaded.", null);
                }
                break;

            case "onPause":
                rewardVideoAd.onPause();
                break;

            case "onResume":
                rewardVideoAd.onResume();
                break;

            case "dispose":
                rewardVideoAd.destroy();
                break;

            default:
                result.notImplemented();
                break;
        }
    }

    /**
     * RewardVideo Loaded
     */
    @Override
    public void onLoaded() {
        channel.invokeMethod("onLoaded", null);
    }

    /**
     * RewardVideo Load Failed
     *
     * @param error
     */
    @Override
    public void onLoadFailed(OAMError error) {
        Logger.d("RewardMethodCallImp", "onLoadFailed: " + error.toString());
        HashMap<String, Object> resultArgMap = new HashMap<>();
        resultArgMap.put("code", error.getCode());
        if (error.getMessage() != null) resultArgMap.put("message", error.getMessage());
        channel.invokeMethod("onLoadFailed", resultArgMap);
    }

    /**
     * RewardVideo Opened
     */
    @Override
    public void onOpened() {
        channel.invokeMethod("onOpened", null);
    }

    /**
     * RewardVideo Open Failed
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
     * After watching the Reward Video
     */
    @Override
    public void onClosed() {
        channel.invokeMethod("onClosed", null);
    }

    /**
     * RewardVideo Completed
     *
     * @param adNetworkNo
     * @param completed   user watched the video
     */
    @Override
    public void onCompleted(int adNetworkNo, boolean completed) {
        HashMap<String, Object> resultArgMap = new HashMap<>();
        resultArgMap.put("adNetworkNo", adNetworkNo);
        resultArgMap.put("completed", completed);
        channel.invokeMethod("onCompleted", resultArgMap);
    }

    /**
     * User Clicked the Reward Video
     */
    @Override
    public void onClicked() {
        channel.invokeMethod("onClicked", null);
    }
}