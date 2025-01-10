import 'dart:io';

import 'package:flutter/services.dart';

abstract class OAMChannelWrapper {
  static const rootChannel = 'com.onestorecorp.sdk.flutter.plugins.admax';
  static MethodChannel? _channel = const MethodChannel('$rootChannel/admax');

  static MethodChannel get channel => _channel!;

  ChannelWrapper(String channelName) {
    if (!Platform.isAndroid) {
      throw PlatformException(code: '-1', message: 'Not supported platform.');
    }

    _channel = MethodChannel('$rootChannel/$channelName');
  }

  static void disposeChannel() {
    channel.setMethodCallHandler(null);
  }

  /// send method call to native
  static Future<T?> invokeMethod<T>(String funcName, [dynamic arg]) {
    return channel.invokeMethod(funcName, arg);
  }
}
