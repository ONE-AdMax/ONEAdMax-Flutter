import 'package:flutter/services.dart';
import '../../one_admax_flutter.dart';

class RewardCallBackListener {
  Function() onLoaded;

  Function(OAMError admaxError) onLoadFailed;

  Function() onOpened;

  Function(OAMError admaxError) onOpenFailed;

  Function() onClosed;

  Function(int adNetworkNo, bool completed) onCompleted;

  Function() onClicked;

  RewardCallBackListener({
    required this.onLoaded,
    required this.onLoadFailed,
    required this.onOpened,
    required this.onOpenFailed,
    required this.onClosed,
    required this.onCompleted,
    required this.onClicked,
  });
}

class OAMReward extends ChannelWrapper {
  late RewardCallBackListener callback;

  OAMReward() : super('reward') {
    channel.setMethodCallHandler(setMethodCallHandler);
  }

  Future<void> load(
      {required String placementId,
      int? networkTimeout,
      required RewardCallBackListener callback}) async {
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

  Future<void> resume() async {
    await invokeMethod('onResume');
  }

  Future<void> pause() async {
    await invokeMethod('onPause');
  }

  Future<void> setMethodCallHandler(MethodCall call) async {
    final dynamic args = call.arguments;
    switch (call.method) {
      case "onLoaded":
        callback.onLoaded();
        break;
      case "onLoadFailed":
        callback.onLoadFailed(
            OAMError(code: args['code'], message: args['message']));
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
      case "onCompleted":
        callback.onCompleted(args['adNetworkNo'], args['completed']);
        break;
      case "onClicked":
        callback.onClicked();
        break;
    }
  }
}
