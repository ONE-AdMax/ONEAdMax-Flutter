package com.onestorecorp.sdk.java.factory;

import android.content.Context;
import android.view.LayoutInflater;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.oneadmax.global.OAMNative;
import com.onestorecorp.sdk.java.view.OAMNativeAdPlatformView;

import java.util.HashMap;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;

/**
 * if you want to Mediation Native Ad, you implement this class
 * @param <T>
 */
public abstract class OAMNativeMediationViewFactory<T> extends OAMNativeViewFactory {

    public T mediationViewBinder;

    protected OAMNativeMediationViewFactory(BinaryMessenger messenger) {
        super(messenger);
        mediationViewBinder = setMediationViewBinder();
    }

    @NonNull
    @Override
    public PlatformView create(Context context, int viewId, @Nullable Object args) {
        HashMap<String, Object> creationParams = (HashMap<String, Object>) args;

        assert creationParams != null;

        // Child View 생성 문제로 Create될때마다 초기화 되도록 변경
        OAMNative oamNative = (OAMNative) LayoutInflater.from(context).inflate(setNativeLayout(), null);

        return new OAMNativeAdPlatformView(oamNative, creationParams, viewBinder, mediationViewBinder, messenger);
    }

    /**
     * set the mediation view binder for the native ad
     * must be implemented
     */
    public abstract T setMediationViewBinder();

}
