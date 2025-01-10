package com.oneadmax.global.sample.java;

import androidx.annotation.NonNull;

import com.oneadmax.global.sample.java.factory.AdFitNativeTemplateViewFactory;
import com.oneadmax.global.sample.java.factory.AdFitNativeViewFactory;
import com.oneadmax.global.sample.java.factory.AppLovinNativeViewFactory;
import com.oneadmax.global.sample.java.factory.MobonNativeViewFactory;
import com.oneadmax.global.sample.java.factory.NativeTemplateViewFactory;
import com.oneadmax.global.sample.java.factory.NativeViewFactory;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        // if you want to customize the native ad layout, you can use the following code
        flutterEngine.getPlatformViewsController().getRegistry()
                .registerViewFactory("plugin/native_widget", new NativeViewFactory(flutterEngine.getDartExecutor().getBinaryMessenger()));

        // mediation sample code

        //AdFit
        flutterEngine.getPlatformViewsController().getRegistry()
                .registerViewFactory("plugin/native_adfit_widget", new AdFitNativeViewFactory(flutterEngine.getDartExecutor().getBinaryMessenger()));

        //AdFIt Template
        flutterEngine.getPlatformViewsController().getRegistry()
                .registerViewFactory("plugin/native_adfit_template_widget", new AdFitNativeTemplateViewFactory(flutterEngine.getDartExecutor().getBinaryMessenger()));


        //Mobon
        flutterEngine.getPlatformViewsController().getRegistry()
                .registerViewFactory("plugin/native_mobon_widget", new MobonNativeViewFactory(flutterEngine.getDartExecutor().getBinaryMessenger()));

        //AppLovin
        flutterEngine.getPlatformViewsController().getRegistry()
                .registerViewFactory("plugin/native_applovin_widget", new AppLovinNativeViewFactory(flutterEngine.getDartExecutor().getBinaryMessenger()));


        // if you want to use the template native ad layout, you can use the following code
        flutterEngine.getPlatformViewsController().getRegistry()
                .registerViewFactory("plugin/native_template_widget", new NativeTemplateViewFactory(flutterEngine.getDartExecutor().getBinaryMessenger()));

        super.configureFlutterEngine(flutterEngine);
    }

}


