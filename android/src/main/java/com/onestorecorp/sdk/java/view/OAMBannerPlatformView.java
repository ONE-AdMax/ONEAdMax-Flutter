package com.onestorecorp.sdk.java.view;

import static com.onestorecorp.sdk.java.OneAdMaxFlutterPlugin.ADMAX_CHANNEL_BASE_NAME;

import android.content.Context;
import android.view.View;
import android.widget.FrameLayout;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.gaa.sdk.base.Logger;
import com.oneadmax.global.OAMBanner;
import com.oneadmax.global.OAMError;
import com.oneadmax.global.listener.IOAMBannerEventListener;

import java.util.HashMap;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class OAMBannerPlatformView implements PlatformView, MethodChannel.MethodCallHandler,  IOAMBannerEventListener {


    private MethodChannel channel;
    private OAMBanner banner;
    //Arguments
    private HashMap<String, Object> args;
    private FrameLayout view;

    public OAMBannerPlatformView(Context context, BinaryMessenger binaryMessenger, HashMap<String, Object> args) {
        this.channel = new MethodChannel(binaryMessenger, ADMAX_CHANNEL_BASE_NAME+ "/banner");
        this.args = args;
        view = new FrameLayout(context);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "resumed":
                Logger.d("BannerMethodPlatformView", "resumed");
                banner.onResume();
                break;
            case "paused":
                Logger.d("BannerMethodPlatformView", "paused");
                banner.onPause();
                break;
        }

    }

    @Nullable
    @Override
    public View getView() {
        return view;
    }


    @Override
    public void dispose() {
        Logger.d("BannerMethodPlatformView", "dispose");
        banner.setVisibility(View.GONE);
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onFlutterViewAttached(@NonNull View flutterView) {
        // Initialized in onFlutterView Attached because it requires Activity Context.
        this.banner = new OAMBanner(flutterView.getContext());
        channel.setMethodCallHandler(this);
        // Set PlacementId
        String placementId = args.get("placementId") != null ? (String) args.get("placementId") : "";
        Logger.d("BannerMethodPlatformView", "placementId : " + placementId);
        banner.setPlacementId(placementId);

        // Set Banner Size
        String bannerSize = args.get("bannerSize") != null ? (String) args.get("bannerSize") : "";
        Logger.d("BannerMethodPlatformView", "bannerSize : " + bannerSize);
        OAMBanner.Size bannerSizeEnum = OAMBanner.Size.valueOf(bannerSize);
        banner.setSize(bannerSizeEnum);


        // Set Banner AnimType
        String animType = args.get("animType") != null ? (String) args.get("animType") : "";
        Logger.d("BannerMethodPlatformView", "animType : " + animType);
        OAMBanner.AnimType animTypeEnum = OAMBanner.AnimType.valueOf(animType);
        banner.setAnimType(animTypeEnum);

        // NetworkScheduleTimeout is optional
        Integer networkScheduleTimeout = args.get("networkScheduleTimeout") != null ? (Integer) args.get("networkScheduleTimeout") : Integer.valueOf(10);
        banner.setNetworkScheduleTimeout(networkScheduleTimeout);

        // RefreshTime is optional
        Integer refreshTime = args.get("refreshTime") != null ? (Integer) args.get("refreshTime") : Integer.valueOf(0);
        banner.setRefreshTime(refreshTime);

        // AutoBgColor is optional
        boolean setAutoBgColor = args.get("setAutoBgColor") == null || (boolean) args.get("setAutoBgColor");
        banner.setAutoBgColor(setAutoBgColor);

        banner.setEventListener(this);
        banner.OnBannerAdReceiveSuccess();
        banner.load();
        view.addView(banner);
    }

    /**
     *  Banner Loaded Callback
     */
    @Override
    public void onLoaded() {
        Logger.d("BannerMethodPlatformView", "onLoaded");
        channel.invokeMethod("onLoaded", null);
    }

    /**
     * Banner Load Failed Callback
     */
    @Override
    public void onLoadFailed(OAMError oamError) {
        Logger.d("BannerMethodPlatformView", "onLoadFailed : " + oamError.toString());
        channel.invokeMethod("onLoadFailed", null);
    }

    /**
     * Banner Opened Callback
     */
    @Override
    public void onClicked() {
        Logger.d("BannerMethodPlatformView", "onClicked");
        channel.invokeMethod("onClicked", null);
    }
}
