import 'package:flutter/services.dart';
import 'package:one_admax_flutter/one_admax_flutter.dart';

class NativeCallBackListener {
  Function() onLoaded;
  Function(OAMError error) onLoadFailed;

  Function() onOpened;

  Function() onClicked;

  Function() onAdHidden;

  NativeCallBackListener({
    required this.onLoaded,
    required this.onLoadFailed,
    required this.onOpened,
    required this.onClicked,
    required this.onAdHidden
  });
}

class OAMNative extends ChannelWrapper {
  final NativeCallBackListener _callback;

  OAMNative(this._callback) : super('native') {
    channel.setMethodCallHandler(setMethodCallHandler);
  }

  Future<void> load() async {
    await invokeMethod('load');
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
      case "onAdHidden":
        _callback.onAdHidden();
        break;
    }
  }
}
