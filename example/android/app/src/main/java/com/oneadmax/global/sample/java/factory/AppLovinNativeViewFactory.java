package com.oneadmax.global.sample.java.factory;


import com.oneadmax.global.sample.java.R;
import com.oneadmax.global.viewbinder.AppLovinMaxViewBinder;
import com.oneadmax.global.viewbinder.OAMViewBinder;
import com.onestorecorp.sdk.java.factory.OAMNativeMediationViewFactory;

import io.flutter.plugin.common.BinaryMessenger;

/**
 *  AppLovin Mediation Native Ad
 */
public class AppLovinNativeViewFactory extends OAMNativeMediationViewFactory<AppLovinMaxViewBinder> {

    public AppLovinNativeViewFactory(BinaryMessenger messenger) {
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
    public AppLovinMaxViewBinder setMediationViewBinder() {
        return new AppLovinMaxViewBinder.Builder(R.id.include_applovin_native_ad, R.layout.layout_applovin_native_ad)
                .titleViewId(R.id.title_text_view)
                .bodyViewId(R.id.body_text_view)
                .iconViewId(R.id.icon_image_view)
                .mediaViewId(R.id.media_view_container)
                .ctaViewId(R.id.cta_button)
                .advertiserViewId(R.id.advertiser_text_view)
                .optionViewId(R.id.options_view)
                .build();
    }


    // You can customize the native ad layout by changing the layout file
    @Override
    public int setNativeLayout() {
        return R.layout.native_platform_applovin_max_layout;
    }
}