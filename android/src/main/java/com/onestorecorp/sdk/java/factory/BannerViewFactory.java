package com.onestorecorp.sdk.java.factory;

import android.content.Context;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;


import com.onestorecorp.sdk.java.view.OAMBannerPlatformView;

import java.util.HashMap;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public final class BannerViewFactory extends PlatformViewFactory {

    private BinaryMessenger binaryMessenger;


    public BannerViewFactory(BinaryMessenger binaryMessenger) {
        super(StandardMessageCodec.INSTANCE);
        this.binaryMessenger = binaryMessenger;
    }


    @NonNull
    @Override
    public PlatformView create(Context context, int viewId, @Nullable Object args) {
        HashMap<String, Object> creationParams = (HashMap<String, Object>) args;
        return new OAMBannerPlatformView(context, binaryMessenger, creationParams);
    }
}
