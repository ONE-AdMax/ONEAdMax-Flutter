import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_admax_flutter/one_admax_flutter.dart';

import '../viewmodel/native_platform_viewmodel.dart';
import '../widget/my_error_widget.dart';

class NativePlatformDetail extends ConsumerStatefulWidget {
  const NativePlatformDetail({super.key});

  @override
  ConsumerState<NativePlatformDetail> createState() => _NativePlatformDetailState();
}

class _NativePlatformDetailState extends ConsumerState<NativePlatformDetail> {
  late NativePlatformViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(nativePlatformProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nativePlatformProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Native'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
              children: [
                state.isNotSupport
                    ? const MyErrorWidget()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 320,
                        child: OAMNativeWidget(
                          placementId: state.mediationNative.placementId,
                          callback: NativeCallBackListener(
                            onLoaded: _viewModel.onLoaded,
                            onLoadFailed: _viewModel.onLoadFailed,
                            onOpened: _viewModel.onOpened,
                            onClicked: _viewModel.onClicked,
                            onAdHidden: _viewModel.onAdHidden,
                          ),
                          factoryId: state.mediationNative.factoryId,
                        ),
                      ),
                ...state.logList.map((e) => _buildLog(e)),
              ],
            ),
    );
  }

  Widget _buildLog(String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Text(value),
    );
  }
}
