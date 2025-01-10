package com.oneadmax.global.sample.java.factory;

import com.oneadmax.global.sample.java.R;
import com.oneadmax.global.viewbinder.OAMViewBinder;
import com.onestorecorp.sdk.java.factory.OAMNativeViewFactory;

import io.flutter.plugin.common.BinaryMessenger;

// Customizing the native ad layout
public class NativeViewFactory extends OAMNativeViewFactory {

    public NativeViewFactory(BinaryMessenger messenger) {
        super(messenger);
    }

    // You can customize the native ad layout by changing the ViewBinder
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

    // You can customize the native ad layout by changing the layout file
    @Override
    public int setNativeLayout() {
        return R.layout.native_plaform_layout;
    }
}
