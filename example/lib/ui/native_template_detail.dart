import 'package:flutter/material.dart';
import 'package:one_admax_flutter/one_admax_flutter.dart';
import 'package:one_admax_flutter_example/const/oamPlacementIds.dart';
import 'package:one_admax_flutter_example/widget/banner_header.dart';

class NativeTemplateDetail extends StatefulWidget {
  const NativeTemplateDetail({super.key});

  @override
  State<NativeTemplateDetail> createState() => _NativeTemplateDetailState();
}

class _NativeTemplateDetailState extends State<NativeTemplateDetail> {
  final List<String> _logList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(children: [
        ...nativeTemplateDetail(
            OamPlacementIds.NATIVE_TEMPLATE_1, 'plugin/native_template_widget'),
        ...nativeTemplateDetail(
            OamPlacementIds.NATIVE_TEMPLATE_2, 'plugin/native_template_widget'),
        ...nativeTemplateDetail(
            OamPlacementIds.NATIVE_TEMPLATE_3, 'plugin/native_template_widget'),
        ...nativeTemplateDetail(
            OamPlacementIds.NATIVE_TEMPLATE_4, 'plugin/native_template_widget'),
        ...nativeTemplateDetail(
            OamPlacementIds.NATIVE_TEMPLATE_5, 'plugin/native_template_widget'),
        ...nativeTemplateDetail(
            OamPlacementIds.NATIVE_TEMPLATE_6, 'plugin/native_template_widget'),
        ...nativeTemplateDetail(
            OamPlacementIds.NATIVE_TEMPLATE_7, 'plugin/native_template_widget'),
        ..._logList.map((e) => _buildLog(e)).toList(),
      ]),
    );
  }

  List<Widget> nativeTemplateDetail(String placementId, String factoryId) {
    return [
      ListHeader(text: placementId),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 300,
        child: OAMNativeWidget(
            placementId: placementId,
            callback: NativeCallBackListener(
              onLoaded: onLoaded,
              onLoadFailed: onLoadFailed,
              onOpened: onOpened,
              onClicked: onClicked,
              onAdHidden: onAdHidden,
            ),
            factoryId: factoryId),
      ),
    ];
  }

  void onClicked() {
    debugPrint("onClicked");
    setState(() {
      _logList.add("onClicked");
    });
  }

  void onLoadFailed(OAMError admaxError) {
    debugPrint("onLoadFailed");
    setState(() {
      _logList.add("onLoadFailed");
    });
  }

  void onLoaded() {
    debugPrint("onLoaded");
    setState(() {
      _logList.add("onLoaded");
    });
  }

  void onOpened() {
    debugPrint("onLoaded");
    setState(() {
      _logList.add("onLoaded");
    });
  }

  void onAdHidden() {
    debugPrint("onAdHidden");
    setState(() {
      _logList.add("onAdHidden");
    });
  }

  Widget _buildLog(String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Text(value),
    );
  }
}
