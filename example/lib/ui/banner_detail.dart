import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_admax_flutter/one_admax_flutter.dart';
import 'package:one_admax_flutter_example/viewmodel/banner_viewmodel.dart';

class BannerDetailScreen extends ConsumerStatefulWidget {
  const BannerDetailScreen({super.key});

  @override
  ConsumerState createState() => _BannerDetailScreenState();
}

class _BannerDetailScreenState extends ConsumerState<BannerDetailScreen> {
  late BannerDetailViewmodel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ref.read(bannerDetailProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bannerDetailProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Banner'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
          children: state.bannerList.map((banner) {
        return OAMBannerWidget(
            placementId: banner.placementId,
            callback: BannerCallBackListener(
                onLoaded: onLoaded,
                onLoadFailed: onLoadFailed,
                onClicked: onClicked),
            bannerSize: banner.bannerSize,
            bannerMediationExtras: banner.bannerMediationExtras);
      }).toList()),
    );
  }

  void onClicked() {
    debugPrint("onClicked");
  }

  void onLoadFailed(OAMError admaxError) {
    debugPrint("OnBannerAdReceiveFailed");
  }

  void onLoaded() {
    debugPrint("onLoaded");
  }
}
