import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_admax_flutter/one_admax_flutter.dart';
import 'package:one_admax_flutter_example/const/oamPlacementIds.dart';
import 'package:one_admax_flutter_example/model/mediation.dart';

import 'mediation_viewmodel.dart';

class RewardDetailViewModel extends StateNotifier<RewardDetailState> {
  late OAMReward _oamReward;

  RewardDetailViewModel(Mediation mediation) : super(RewardDetailState()) {
    String rewardPlacementId = "";

    switch (mediation) {
      case Mediation.pure:
        rewardPlacementId = OamPlacementIds.REWARD_ID;
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
        rewardPlacementId = dotenv.env['UNITYADS_REWARD_VIDEO_PLACEMENT_ID']!;
        break;
      case Mediation.vungle:
        rewardPlacementId = dotenv.env['VUNGLE_REWARD_VIDEO_PLACEMENT_ID']!;
        break;
      case Mediation.applovinBidding:
        rewardPlacementId = dotenv.env['APPLOVIN_BIDDING_REWARD_VIDEO_PLACEMENT_ID']!;
        break;
      case Mediation.applovinWaterfall:
        rewardPlacementId = dotenv.env['APPLOVIN_WATERFALL_REWARD_VIDEO_PLACEMENT_ID']!;
        break;
    }

    _oamReward = OAMReward()
      ..load(
        placementId: rewardPlacementId,
        callback: RewardCallBackListener(
          onLoaded: onLoaded,
          onLoadFailed: onLoadFailed,
          onOpened: onOpened,
          onOpenFailed: onOpenFailed,
          onClosed: onClosed,
          onCompleted: onCompleted,
          onClicked: onClicked,
        ),
      );
    state = state.copyWith(isLoading: true);
  }

  void showRewardVideo() {
    _oamReward.show();
  }

  void onClicked() {
    _logEvent("onClicked");
  }

  void onClosed() {
    _logEvent("onClosed");
  }

  void onLoadFailed(OAMError admaxError) {
    _logEvent("onLoadFailed${admaxError.code}${admaxError.message}");

    state = state.copyWith(isLoading: false);
  }

  void onLoaded() {
    _logEvent("onLoaded");
    state = state.copyWith(isLoading: false);
  }

  void onCompleted(int adNetworkNo, bool completed) {
    _logEvent("onCompleted adNetworkNo : $adNetworkNo, completed : $completed");
  }

  void onOpenFailed(OAMError admaxError) {
    _logEvent(
        "onOpenFailed code : $admaxError.code, message : $admaxError.message");
  }

  void onOpened() {
    _logEvent("onOpened");
  }

  void _logEvent(String event) {
    state = state.copyWith(
      logList: [...state.logList, event],
    );
  }

  void resume() {
    _oamReward.resume();
  }

  void pause() {
    _oamReward.pause();
  }

  void disposePlugin() {
    _oamReward.dispose();
  }
}

class RewardDetailState {
  final List<String> logList;
  final bool isLoading;
  final bool isNotSupport;
  final String placementId;

  RewardDetailState({
    this.logList = const [],
    this.isLoading = false,
    this.isNotSupport = false,
    this.placementId = "",
  });

  RewardDetailState copyWith({
    List<String>? logList,
    bool? isLoading,
    bool? isNotSupport,
    String? placementId,
    bool? isAdded,
  }) {
    return RewardDetailState(
      logList: logList ?? this.logList,
      isLoading: isLoading ?? this.isLoading,
      isNotSupport: isNotSupport ?? this.isNotSupport,
      placementId: placementId ?? this.placementId,
    );
  }
}

// 뷰모델 재구성
final rewardDetailProvider =
    StateNotifierProvider<RewardDetailViewModel, RewardDetailState>((ref) {
  final mediation = ref.watch(mediationProvider).mediation;
  return RewardDetailViewModel(mediation);
});
