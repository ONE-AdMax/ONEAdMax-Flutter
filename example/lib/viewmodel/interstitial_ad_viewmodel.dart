import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_admax_flutter/one_admax_flutter.dart';

import '../model/mediation.dart';
import 'mediation_viewmodel.dart';

class InterstitialAdState {
  final List<String> logList;
  final bool isLoading;
  final bool isNotSupport;

  InterstitialAdState({
    this.logList = const [],
    this.isLoading = false,
    this.isNotSupport = false,
  });

  InterstitialAdState copyWith({
    List<String>? logList,
    bool? isLoading,
    bool? isNotSupport,
  }) {
    return InterstitialAdState(
      logList: logList ?? this.logList,
      isLoading: isLoading ?? this.isLoading,
      isNotSupport: isNotSupport ?? this.isNotSupport,
    );
  }
}

class InterstitialAdViewModel extends StateNotifier<InterstitialAdState> {
  late OAMInterstitial _oamInterstitial;

  InterstitialAdViewModel(Mediation mediation) : super(InterstitialAdState()) {
    String interstitialPlacementId = "";

    switch (mediation) {
      case Mediation.pure:
        interstitialPlacementId = "ONESTORE_INTERSTITIAL";
        break;
      case Mediation.adFit:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.mobon:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.mezzo:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.caluly:
        interstitialPlacementId = "p5hKWt7wUAz951W";
        break;
      case Mediation.unityAds:
        interstitialPlacementId = "NdLcdsbuDEffITU";
        break;
      case Mediation.vungle:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.applovinBidding:
        state = state.copyWith(isNotSupport: true);
      case Mediation.applovinWaterfall:
        state = state.copyWith(isNotSupport: true);
        break;
    }

    _oamInterstitial = OAMInterstitial();

    _oamInterstitial.load(
        placementId: interstitialPlacementId,
        callback: InterstitialCallBackListener(
          onLoaded: onLoaded,
          onLoadFailed: onLoadFailed,
          onOpened: onOpened,
          onOpenFailed: onOpenFailed,
          onClosed: onClosed,
          onClicked: onClicked,
        ),
      );

    state = state.copyWith(isLoading: true);
  }

  void showInterstitialAds() {
    _oamInterstitial.interstitialConfig.isHideCloseButton = false;
    _oamInterstitial.interstitialConfig.backgroundColor = Colors.red;
    _oamInterstitial.interstitialConfig.endingText = const EndingText(
      'Sample Text',
      12,
      Colors.white,
      TextAlign.center,
      true,
    );
    _oamInterstitial.interstitialConfig.closeBtnMargin = const CloseBtnMargin(
      top: 10,
      left: 10,
      right: 10,
      bottom: 10,
    );

    _oamInterstitial.show();
  }

  void onClicked() {
    _logEvent("onClicked");
  }

  void onLoadFailed() {
    _logEvent("onLoadFailed");
  }

  void onLoaded() {
    state = state.copyWith(isLoading: false);
    _logEvent("onLoaded");
  }

  void onOpened() {
    _logEvent("onOpened");
  }

  void onClosed(OAMCloseEvent event) {
    _logEvent("onClosed AdMaxCloseEvent : $event");
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

  @override
  void dispose() {
    _oamInterstitial.dispose();
    super.dispose();
  }
}

final interstitialAdProvider =
    StateNotifierProvider<InterstitialAdViewModel, InterstitialAdState>((ref) {
  final mediation = ref.watch(mediationProvider).mediation;
  return InterstitialAdViewModel(mediation);
});
