import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/reward_viewmodel.dart';
import '../widget/my_error_widget.dart';

class RewardDetailScreen extends ConsumerStatefulWidget {
  const RewardDetailScreen({super.key});

  @override
  ConsumerState<RewardDetailScreen> createState() => _RewardDetailScreenState();
}

class _RewardDetailScreenState extends ConsumerState<RewardDetailScreen>
    with WidgetsBindingObserver {
  late RewardDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _viewModel = ref.read(rewardDetailProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(rewardDetailProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Reward'),
          automaticallyImplyLeading: false,
        ),
        body: state.isNotSupport
            ? const MyErrorWidget()
            : _rewardContent(state));
  }

  Widget _buildLog(String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Text(value),
    );
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("resumed");
        _viewModel.resume();
        break;
      case AppLifecycleState.inactive:
        debugPrint("inactive");
        break;
      case AppLifecycleState.paused:
        debugPrint("paused");
        _viewModel.pause();
        break;
      case AppLifecycleState.detached:
        debugPrint("detached");
        break;
      case AppLifecycleState.hidden:
        debugPrint("hidden");
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    debugPrint("dispose");
    _viewModel.disposePlugin();
    super.dispose();
  }

  Widget _rewardContent(RewardDetailState state) {
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
                onPressed: _viewModel.showRewardVideo,
                child: const Text('Generate Reward Video'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
