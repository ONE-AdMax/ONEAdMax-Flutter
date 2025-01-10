import 'package:flutter/services.dart';
import 'package:one_admax_flutter/src/model/banner_mediation_config.dart';
import '../../one_admax_flutter.dart';

class BannerCallBackListener {
  Function() onLoaded;

  Function(OAMError error) onLoadFailed;

  Function() onClicked;

  BannerCallBackListener({
    required this.onLoaded,
    required this.onLoadFailed,
    required this.onClicked,
  });
}

class OAMBanner extends ChannelWrapper {
  final BannerCallBackListener _callback;
  final BannerMediationExtras? bannerMediationExtras;

  OAMBanner(this._callback, this.bannerMediationExtras) : super('banner') {
    channel.setMethodCallHandler(setMethodCallHandler);
  }

  Future<void> setPlacementId(String placementId) async {
    await invokeMethod<String>('setPlacementId', <String, dynamic>{
      'placementId': placementId,
    });
  }

  Future<void> setAnimType(AnimType animType) async {
    await invokeMethod<String>('setAnimType', <String, dynamic>{
      'animType': animType.toString(),
    });
  }

  Future<void> setRefreshTime(int refreshTime) async {
    await invokeMethod<String>('setRefreshTime', <String, dynamic>{
      'refreshTime': refreshTime,
    });
  }

  Future<void> setAutoBgColor(bool isEnabled) async {
    await invokeMethod<String>('setAutoBgColor', <String, dynamic>{
      'setAutoBgColor': isEnabled,
    });
  }

  Future<void> load() async {
    await invokeMethod('load', bannerMediationExtras?.toMap());
  }

  Future<void> setMethodCallHandler(MethodCall call) async {
    final dynamic args = call.arguments;
    switch (call.method) {
      case "onLoaded":
        _callback.onLoaded();
        break;
      case "onLoadFailed":
        _callback.onLoadFailed(
            OAMError(code: args['code'], message: args['message']));
        break;
      case "onClicked":
        _callback.onClicked();
        break;
    }
  }
}
