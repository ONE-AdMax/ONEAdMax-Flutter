import 'package:flutter/services.dart';

import '../../one_admax_flutter.dart';

class InterstitialVideoCallBackListener {
  Function() onLoaded;

  Function() onLoadFailed;

  Function() onOpened;

  Function(OAMError error) onOpenFailed;

  Function() onClosed;

  Function() onClicked;

  InterstitialVideoCallBackListener({
    required this.onLoaded,
    required this.onLoadFailed,
    required this.onOpened,
    required this.onOpenFailed,
    required this.onClosed,
    required this.onClicked,
  });
}

class OAMInterstitialVideo extends ChannelWrapper {
  late InterstitialVideoCallBackListener callback;

  OAMInterstitialVideo() : super('interstitial_video') {
    channel.setMethodCallHandler(setMethodCallHandler);
  }

  Future<void> load(
      {required String placementId,
      int? networkTimeout,
      required InterstitialVideoCallBackListener callback}) async {
    this.callback = callback;
    await invokeMethod('load', <String, dynamic>{
      'placementId': placementId,
      'networkTimeout': networkTimeout
    });
  }

  Future<void> show() async {
    await invokeMethod('show');
  }

  Future<void> dispose() async {
    await invokeMethod('dispose');
  }

  Future<void> setMethodCallHandler(MethodCall call) async {
    final dynamic args = call.arguments;
    switch (call.method) {
      case "onLoaded":
        callback.onLoaded();
        break;
      case "onLoadFailed":
        callback.onLoadFailed();
        break;
      case "onOpened":
        callback.onOpened();
        break;
      case "onOpenFailed":
        callback.onOpenFailed(
            OAMError(code: args['code'], message: args['message']));
        break;
      case "onClosed":
        callback.onClosed();
        break;
      case "onClicked":
        callback.onClicked();
        break;
    }
  }
}
