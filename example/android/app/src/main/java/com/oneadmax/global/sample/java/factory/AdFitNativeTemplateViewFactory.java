package com.oneadmax.global.sample.java.factory;


import com.oneadmax.global.sample.java.R;
import com.oneadmax.global.viewbinder.AdFitViewBinder;
import com.oneadmax.global.viewbinder.OAMViewBinder;
import com.onestorecorp.sdk.java.factory.OAMNativeMediationViewFactory;

import io.flutter.plugin.common.BinaryMessenger;

/**
 * AdFit Mediation Native Template Ad
 */
public class AdFitNativeTemplateViewFactory extends OAMNativeMediationViewFactory<AdFitViewBinder> {

    public AdFitNativeTemplateViewFactory(BinaryMessenger messenger) {
        super(messenger);
    }

    @Override
    public OAMViewBinder setViewBinder() {
        return new OAMViewBinder.Builder(R.id.include_oneadmax_native_ad)
                .iconImageViewId(R.id.icon_image_view)
                .titleViewId(R.id.title_text_view)
                .descViewId(R.id.desc_text_view)
                .callToActionViewId(R.id.cta_text_view)
                .mainImageViewId(R.id.main_image_view)
                .build();
    }
    // You can customize the native ad layout by changing the ViewBinder
    @Override
    public AdFitViewBinder setMediationViewBinder() {
        return new AdFitViewBinder.Builder(R.id.adfit_bizboard_native_ad)
                .bizBoardAd(true)
                .build();
    }


    // You can customize the native ad layout by changing the layout file
    @Override
    public int setNativeLayout() {
        return R.layout.native_platform_adfit_bizboard_layout;
    }
}