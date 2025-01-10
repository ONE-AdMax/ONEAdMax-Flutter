package com.onestorecorp.sdk.java.handler;

import android.app.Activity;
import android.content.Context;

import androidx.annotation.NonNull;

import com.gaa.sdk.base.Logger;
import com.oneadmax.global.ONEAdMax;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class OneAdMaxMethodCallImp implements MethodChannel.MethodCallHandler {

    private final MethodChannel channel;
    private final Activity context;

    public OneAdMaxMethodCallImp(MethodChannel channel, Activity context) {
        this.channel = channel;
        this.context = context;
    }

    @Override
    public void onMethodCall(MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            // ONE AdMax Init
            case "init":
                if (!ONEAdMax.isInit(context)) {
                    ONEAdMax.init(context, () -> {
                        Logger.d("OneAdMaxMethodCallImp", "ONE AdMax init: ");
                        result.success(true);
                    });
                }
                break;
            // ONE AdMax LogEnable
            case "setLogEnable":
                boolean enable = call.argument("enable");
                Logger.d("OneAdMaxMethodCallImp", "ONE AdMax setEnable: " + enable);
                ONEAdMax.setLogEnable(enable);
                break;
            // ONE AdMax SetGDPR
            case "gdprConsentAvailable":
                boolean available = call.argument("enable");
                Logger.d("OneAdMaxMethodCallImp", "ONE AdMax gdprConsentAvailable: " + available);
                ONEAdMax.gdprConsentAvailable(available);
                break;
            // ONE AdMax SetTagForChildDirectedTreatment
            case "tagForChildDirectedTreatment":
                boolean tagForChildEnable = call.argument("enable");
                Logger.d("OneAdMaxMethodCallImp", "ONE AdMax tagForChildDirectedTreatment: " + tagForChildEnable);
                ONEAdMax.tagForChildDirectedTreatment(context, tagForChildEnable);
                break;
            // ONE AdMax SetUserId
            case "setUserId":
                String userId = call.argument("userId");
                Logger.d("OneAdMaxMethodCallImp", "ONE AdMax setUserId: " + userId);
                ONEAdMax.setUserId(context, userId);
                break;
            // ONE AdMax OpenRewardVideoCSPage
            case "openRewardVideoCSPage":
                String csUserId = call.argument("userId");
                Logger.d("OneAdMaxMethodCallImp", "ONE AdMax openRewardVideoCSPage: " + csUserId);
                ONEAdMax.openRewardVideoCSPage(context, csUserId);
                break;
            // ONE AdMax unInit
            case "unInit":
                Logger.d("OneAdMaxMethodCallImp", "unInit");
                ONEAdMax.unInit();
                break;
            default:
                result.notImplemented();
                break;
        }
    }

}
