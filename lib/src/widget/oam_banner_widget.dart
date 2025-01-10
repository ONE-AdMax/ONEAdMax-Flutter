import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_admax_flutter/one_admax_flutter.dart';

class OAMBannerWidget extends StatefulWidget {
  final String placementId;
  final BannerSize bannerSize;
  late final OAMBanner _bannerPlugin;
  final BannerCallBackListener callback;
  final AnimType animType;
  final int? refreshTime;
  final int? networkTimeout;
  final bool? isEnabledAutoBgColor;
  final BannerMediationExtras? bannerMediationExtras;

  OAMBannerWidget({super.key,
    required this.placementId,
    required this.callback,
    required this.bannerSize,
    this.animType = AnimType.NONE,
    this.refreshTime,
    this.networkTimeout,
    this.isEnabledAutoBgColor,
    this.bannerMediationExtras}) {
    _bannerPlugin = OAMBanner(callback, bannerMediationExtras);
  }

  @override
  State<StatefulWidget> createState() => _OAMBannerWidgetState();
}

class _OAMBannerWidgetState extends State<OAMBannerWidget>
    with WidgetsBindingObserver {
  final UniqueKey _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: widget.bannerSize.toSize,
      child: AndroidView(
        key: _key,
        viewType: 'com.onestorecorp.sdk.flutter.plugins.admax/banner',
        creationParams: bannerCreationParams,
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }

  // parameter
  Map<String, dynamic> get bannerCreationParams =>
      <String, dynamic>{
        'placementId': widget.placementId,
        'bannerSize': widget.bannerSize.name,
        'animType': widget.animType.name,
        'refreshTime': widget.refreshTime,
        'networkTimeout': widget.networkTimeout,
        'setAutoBgColor': widget.isEnabledAutoBgColor
      };

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("resumed");
        widget._bannerPlugin.invokeMethod("resumed");
        break;
      case AppLifecycleState.inactive:
        debugPrint("inactive");
        break;
      case AppLifecycleState.paused:
        debugPrint("paused");
        widget._bannerPlugin.invokeMethod("paused");
        break;
      case AppLifecycleState.detached:
        debugPrint("detached");
        widget._bannerPlugin.disposeChannel();
        break;
      case AppLifecycleState.hidden:
        debugPrint("hidden");
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
