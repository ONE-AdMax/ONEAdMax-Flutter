import 'package:flutter/services.dart';
import 'package:one_admax_flutter/one_admax_flutter.dart';

class InterstitialCallBackListener {
  Function() onLoaded;

  Function() onLoadFailed;

  Function() onOpened;

  Function(OAMError error) onOpenFailed;

  Function(OAMCloseEvent event) onClosed;

  Function() onClicked;

  InterstitialCallBackListener({
    required this.onLoaded,
    required this.onLoadFailed,
    required this.onOpened,
    required this.onOpenFailed,
    required this.onClosed,
    required this.onClicked,
  });
}

class OAMInterstitial extends ChannelWrapper {
  late InterstitialCallBackListener _callback;
  InterstitialExtras interstitialConfig = InterstitialExtras();

  OAMInterstitial() : super('interstitial') {
    channel.setMethodCallHandler(setMethodCallHandler);
  }

  Future<void> load(
      {required String placementId,
      required InterstitialCallBackListener callback}) async {
    _callback = callback;

    await invokeMethod('load', <String, dynamic>{
      'placementId': placementId,
    });
  }

  Future<void> show() async {
    await invokeMethod('show', interstitialConfig.toMap());
  }

  Future<void> dispose() async {
    await invokeMethod('dispose');
  }

  Future<void> setMethodCallHandler(MethodCall call) async {
    final dynamic args = call.arguments;
    switch (call.method) {
      case "onLoaded":
        _callback.onLoaded();
        break;
      case "onLoadFailed":
        _callback.onLoadFailed();
        break;
      case "onOpened":
        _callback.onOpened();
        break;
      case "onOpenFailed":
        _callback.onOpenFailed(
            OAMError(code: args['code'], message: args['message']));
        break;
      case "onClosed":
        _callback.onClosed(OAMCloseEvent.fromJson(args['closeEvent']));
        break;
      case "onClicked":
        _callback.onClicked();
        break;
    }
  }
}
