import 'dart:io';

import 'package:flutter/services.dart';
/// MethodChannel wrapper class
abstract class ChannelWrapper {
  static const rootChannel = 'com.onestorecorp.sdk.flutter.plugins.admax';
  MethodChannel? _channel;

  MethodChannel get channel => _channel!;

  ChannelWrapper(String channelName) {
    if (!Platform.isAndroid) {
      throw PlatformException(code: '-1', message: 'Not supported platform.');
    }

    _channel = MethodChannel('$rootChannel/$channelName');
  }

  void disposeChannel() {
    channel.setMethodCallHandler(null);
  }

  /// send method call to native
  Future<T?> invokeMethod<T>(String funcName, [dynamic arg]) {
    return channel.invokeMethod(funcName, arg);
  }
}
