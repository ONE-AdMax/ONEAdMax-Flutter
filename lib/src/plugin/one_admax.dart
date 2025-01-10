import 'package:one_admax_flutter/src/message/channel_wrapper_static.dart';


class ONEAdMax extends OAMChannelWrapper {
  ONEAdMax() : super();

  static Future<void> initialize(void Function(bool) onInitListener) async {
    bool? result = await OAMChannelWrapper.invokeMethod<bool>('init');
    onInitListener(result ?? false);
  }

  static Future<void> setLogEnabled(bool enabled) async {
    await OAMChannelWrapper.invokeMethod<String>(
        'setLogEnable', <String, dynamic>{
      'enable': enabled,
    });
  }

  static Future<void> gdprConsentAvailable(bool enabled) async {
    await OAMChannelWrapper.invokeMethod<String>(
        'gdprConsentAvailable', <String, dynamic>{
      'enable': enabled,
    });
  }

  static Future<void> tagForChildDirectedTreatment(bool enabled) async {
    await OAMChannelWrapper.invokeMethod<String>(
        'tagForChildDirectedTreatment', <String, dynamic>{
      'enable': enabled,
    });
  }

  static Future<void> setUserId(String userId) async {
    await OAMChannelWrapper.invokeMethod<String>(
        'setUserId', <String, dynamic>{
      'userId': userId,
    });
  }

  static Future<void> openRewardVideoCSPage(String userId) async {
    await OAMChannelWrapper.invokeMethod<String>(
        'openRewardVideoCSPage', <String, dynamic>{
      'userId': userId,
    });
  }

  static Future<void> dispose() async {
    await OAMChannelWrapper.invokeMethod<String>('unInit');
  }
}
