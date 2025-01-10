package com.oneadmax.global.sample.java.factory;


import com.oneadmax.global.sample.java.R;
import com.oneadmax.global.viewbinder.MobonViewBinder;
import com.oneadmax.global.viewbinder.OAMViewBinder;
import com.onestorecorp.sdk.java.factory.OAMNativeMediationViewFactory;

import io.flutter.plugin.common.BinaryMessenger;

/**
 * Mobon Mediation Native Ad
 */
public class MobonNativeViewFactory extends OAMNativeMediationViewFactory<MobonViewBinder> {

    public MobonNativeViewFactory(BinaryMessenger messenger) {
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
    public MobonViewBinder setMediationViewBinder() {
        return new MobonViewBinder.Builder(R.id.include_mobon_native_ad, R.layout.layout_mobon_native_ad)
                .titleViewId(R.id.title_text_view)
                .mainImageViewId(R.id.main_image_view)
                .logoImageViewId(R.id.logo_image_view)
                .descViewId(R.id.desc_text_view)
                .priceViewId(R.id.price_text_view)
                .build();
    }



    // You can customize the native ad layout by changing the layout file
    @Override
    public int setNativeLayout() {
        return R.layout.native_platform_mobon_layout;
    }
}