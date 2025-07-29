import 'package:flutter/services.dart';

abstract class OAMChannelWrapper {
  static const rootChannel = 'com.onestorecorp.sdk.flutter.plugins.admax';
  static const MethodChannel _channel = MethodChannel('$rootChannel/admax');
  static MethodChannel get channel => _channel;

  static void disposeChannel() {
    channel.setMethodCallHandler(null);
  }

  /// send method call to native
  static Future<T?> invokeMethod<T>(String funcName, [dynamic arg]) {
    return channel.invokeMethod(funcName, arg);
  }
}
