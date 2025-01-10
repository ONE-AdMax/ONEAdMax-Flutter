package com.onestorecorp.sdk.java;

import android.app.Activity;

import androidx.annotation.NonNull;

import com.onestorecorp.sdk.java.factory.BannerViewFactory;
import com.onestorecorp.sdk.java.handler.InterstitialMethodCallImp;
import com.onestorecorp.sdk.java.handler.InterstitialVideoMethodCallImp;
import com.onestorecorp.sdk.java.handler.OneAdMaxMethodCallImp;
import com.onestorecorp.sdk.java.handler.RewardMethodCallImp;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodChannel;

/**
 * OneAdMaxFlutterPlugin
 */
public class OneAdMaxFlutterPlugin implements FlutterPlugin, ActivityAware {
    private MethodChannel adMaxChannel;
    private MethodChannel rewardChannel;
    private MethodChannel interstitialVideoChannel;
    private MethodChannel interstitialChannel;


    /**
     * Application이 시작될때 호출
     *
     * @param flutterPluginBinding
     */
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {

        adMaxChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), ADMAX_CHANNEL_BASE_NAME + "/admax");
        rewardChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), ADMAX_CHANNEL_BASE_NAME + "/reward");
        interstitialChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), ADMAX_CHANNEL_BASE_NAME + "/interstitial");
        interstitialVideoChannel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), ADMAX_CHANNEL_BASE_NAME + "/interstitial_video");

        // Register BannerViewFactory
        flutterPluginBinding.getPlatformViewRegistry().registerViewFactory(ADMAX_CHANNEL_BASE_NAME + "/banner", new BannerViewFactory(flutterPluginBinding.getBinaryMessenger()));
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        rewardChannel.setMethodCallHandler(null);
        interstitialVideoChannel.setMethodCallHandler(null);
        interstitialChannel.setMethodCallHandler(null);
    }

    public static final String ADMAX_CHANNEL_BASE_NAME = "com.onestorecorp.sdk.flutter.plugins.admax";

    // Activity Aware로, Activity가 생성될때 호출
    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        Activity activity = binding.getActivity();

        adMaxChannel.setMethodCallHandler(new OneAdMaxMethodCallImp(adMaxChannel, activity));
        rewardChannel.setMethodCallHandler(new RewardMethodCallImp(rewardChannel, activity));
        interstitialChannel.setMethodCallHandler(new InterstitialMethodCallImp(interstitialChannel, activity));
        interstitialVideoChannel.setMethodCallHandler(new InterstitialVideoMethodCallImp(interstitialVideoChannel, activity));
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {

    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

    }

    @Override
    public void onDetachedFromActivity() {

    }
}
