import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../plugin/oam_native.dart';

class OAMNativeWidget extends StatefulWidget {
  final String placementId;
  final NativeCallBackListener callback;
  final String factoryId;
  late final OAMNative nativePlugin;

  OAMNativeWidget(
      {super.key,
      required this.placementId,
      required this.callback,
      required this.factoryId}) {
    nativePlugin = OAMNative(callback);
  }

  @override
  State<OAMNativeWidget> createState() => _OAMNativeWidgetState();
}

class _OAMNativeWidgetState extends State<OAMNativeWidget> {
  final UniqueKey _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return AndroidView(
        key: _key,
        viewType: widget.factoryId,
        creationParams: bannerCreationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
  }

  // parameter
  Map<String, dynamic> get bannerCreationParams => <String, dynamic>{
        'placementId': widget.placementId,
      };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
