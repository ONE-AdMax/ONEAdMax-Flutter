package com.oneadmax.global.sample.java.factory;

import com.oneadmax.global.sample.java.R;
import com.oneadmax.global.viewbinder.OAMViewBinder;
import com.onestorecorp.sdk.java.factory.OAMNativeViewFactory;

import io.flutter.plugin.common.BinaryMessenger;

// Using the template native ad layout
public class NativeTemplateViewFactory extends OAMNativeViewFactory {

    public NativeTemplateViewFactory(BinaryMessenger messenger) {
        super(messenger);
    }

    // You can use the template native ad layout by setting the template id to -1 and useTemplate to true
    @Override
    public OAMViewBinder setViewBinder() {
        return new OAMViewBinder.Builder(-1)
                .useTemplate(true)
                .build();
    }

    // You can customize the native ad layout by changing the layout file
    @Override
    public int setNativeLayout() {
        return R.layout.native_template_layout;
    }
}
