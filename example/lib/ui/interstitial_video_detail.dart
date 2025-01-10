import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/interstitial_video_viewmodel.dart';
import '../widget/my_error_widget.dart';

class InterstitialVideoDetailScreen extends ConsumerStatefulWidget {
  const InterstitialVideoDetailScreen({super.key});

  @override
  _InterstitialVideoDetailScreenState createState() =>
      _InterstitialVideoDetailScreenState();
}

class _InterstitialVideoDetailScreenState
    extends ConsumerState<InterstitialVideoDetailScreen> {
  late InterstitialVideoViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(interstitialVideoProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(interstitialVideoProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('InterstitialVideo Screen'),
      ),
      body: state.isNotSupport
          ? const MyErrorWidget()
          : _interstitialVideoContent(state),
    );
  }

  Widget _interstitialVideoContent(InterstitialVideoState state) {
    return Stack(
      children: [
        if (state.isLoading) const Center(child: CircularProgressIndicator()),
        Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: state.logList.map((e) => _buildLog(e)).toList(),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _viewModel.showInterstitialVideo,
                child: const Text('Generate Interstitial Video'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  dispose() {
    _viewModel.onDispose();
    super.dispose();
  }

  Widget _buildLog(String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Text(value),
    );
  }
}
