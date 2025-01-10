package com.onestorecorp.sdk.java.factory;

import android.content.Context;
import android.view.LayoutInflater;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.oneadmax.global.OAMNative;
import com.oneadmax.global.viewbinder.OAMViewBinder;
import com.onestorecorp.sdk.java.view.OAMNativeAdPlatformView;

import java.util.HashMap;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * this class is a factory class for creating pure native ad view
 *
 * if you want to customize the native ad layout, you implement this class
 * and override getViewBinder() and setNativeLayout() method
 */

public abstract class OAMNativeViewFactory extends PlatformViewFactory {


    public OAMViewBinder viewBinder;


    BinaryMessenger messenger;

    protected OAMNativeViewFactory(BinaryMessenger messenger) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;

        viewBinder = setViewBinder();
    }

    @NonNull
    @Override
    public PlatformView create(Context context, int viewId, @Nullable Object args) {

        HashMap<String, Object> creationParams = (HashMap<String, Object>) args;

        assert creationParams != null;

        // An error occurs when OAMNative is recycled.
        OAMNative oamNative = (OAMNative) LayoutInflater.from(context).inflate(setNativeLayout(), null);

        return new OAMNativeAdPlatformView(oamNative, creationParams, viewBinder, messenger);
    }

    /**
     * set the OAM View Binder for the native ad
     */
    public abstract OAMViewBinder setViewBinder();

    /**
     * set the layout for the native ad
     * ex) R.layout.native_ad_layout
     */
    public abstract int setNativeLayout();

}





