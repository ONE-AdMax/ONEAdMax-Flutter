import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/interstitial_ad_viewmodel.dart';
import '../widget/my_error_widget.dart';

class InterstitialAdDetailScreen extends ConsumerStatefulWidget {
  const InterstitialAdDetailScreen({super.key});

  @override
  _InterstitialAdDetailScreenState createState() =>
      _InterstitialAdDetailScreenState();
}

class _InterstitialAdDetailScreenState
    extends ConsumerState<InterstitialAdDetailScreen> {
  late InterstitialAdViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(interstitialAdProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(interstitialAdProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('InterstitialAd Screen'),
      ),
      body: state.isNotSupport ? const MyErrorWidget() : _interstitialAdContent(state),
    );
  }

  Widget _buildLog(String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Text(value),
    );
  }

  Widget _interstitialAdContent(InterstitialAdState state) {
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
                onPressed: _viewModel.showInterstitialAds,
                child: const Text('Generate Interstitial Ads'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
