import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_admax_flutter/one_admax_flutter.dart';

import 'package:one_admax_flutter_example/const/oam_placement_ids.dart';
import '../model/mediation.dart';
import 'mediation_viewmodel.dart';

class InterstitialVideoState {
  final List<String> logList;
  final bool isLoading;
  final bool isNotSupport;

  InterstitialVideoState({
    this.logList = const [],
    this.isLoading = false,
    this.isNotSupport = false,
  });

  InterstitialVideoState copyWith({
    List<String>? logList,
    bool? isLoading,
    bool? isNotSupport,
  }) {
    return InterstitialVideoState(
      logList: logList ?? this.logList,
      isLoading: isLoading ?? this.isLoading,
      isNotSupport: isNotSupport ?? this.isNotSupport,
    );
  }
}

class InterstitialVideoViewModel extends StateNotifier<InterstitialVideoState> {
  late OAMInterstitialVideo _oamInterstitialVideo;

  InterstitialVideoViewModel(Mediation mediation)
      : super(InterstitialVideoState()) {
    String interstitialVideoPlacementId = "";

    switch (mediation) {
      case Mediation.pure:
        interstitialVideoPlacementId = OamPlacementIds.interstitialVideoId;
        break;
      case Mediation.mobon:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.mezzo:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.cauly:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.unityAds:
        interstitialVideoPlacementId = dotenv.env['UNITYADS_INTERSTITIAL_VIDEO_PLACEMENT_ID']!;
        break;
      case Mediation.vungle:
        interstitialVideoPlacementId = dotenv.env['VUNGLE_INTERSTITIAL_VIDEO_PLACEMENT_ID']!;
        break;
      case Mediation.applovinBidding:
        interstitialVideoPlacementId = dotenv.env['APPLOVIN_BIDDING_INTERSTITIAL_VIDEO_PLACEMENT_ID']!;
        break;
      case Mediation.applovinWaterfall:
        interstitialVideoPlacementId = dotenv.env['APPLOVIN_WATERFALL_INTERSTITIAL_VIDEO_PLACEMENT_ID']!;
        break;
    }

    _oamInterstitialVideo = OAMInterstitialVideo();

    _oamInterstitialVideo.load(
        placementId: interstitialVideoPlacementId,
        callback: InterstitialVideoCallBackListener(
          onLoaded: onLoaded,
          onLoadFailed: onLoadFailed,
          onOpened: onOpened,
          onOpenFailed: onOpenFailed,
          onClosed: onClosed,
          onClicked: onClicked,
        ),
        networkTimeout: 10
      );
    state = state.copyWith(isLoading: true);
  }

  void showInterstitialVideo() {
    _oamInterstitialVideo.show();
  }

  void onClicked() {
    _logEvent("onClicked");
  }

  void onClosed() {
    _logEvent("onClosed");
  }

  void onLoaded() {
    state = state.copyWith(isLoading: false);
    _logEvent("onLoaded");
  }

  void onOpened() {
    _logEvent("onOpened");
  }

  void onLoadFailed() {
    _logEvent("onLoadFailed");
  }

  void onOpenFailed(OAMError admaxError) {
    _logEvent(
        "onOpenFailed code : ${admaxError.code}, message : ${admaxError.message}");
  }

  void _logEvent(String event) {
    state = state.copyWith(
      logList: [...state.logList, event],
    );
  }

  void onDispose() {
    _oamInterstitialVideo.dispose();
  }
}

final interstitialVideoProvider =
    StateNotifierProvider<InterstitialVideoViewModel, InterstitialVideoState>(
        (ref) {
  final mediation = ref.watch(mediationProvider).mediation;
  return InterstitialVideoViewModel(mediation);
});
