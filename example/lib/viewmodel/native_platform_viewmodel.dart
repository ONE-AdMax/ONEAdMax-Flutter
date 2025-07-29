import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_admax_flutter/one_admax_flutter.dart';

import '../model/native.dart';
import '../model/mediation.dart';
import 'mediation_viewmodel.dart';

class NativePlatformState {
  final List<String> logList;
  final MediationNative mediationNative;
  final bool isNotSupport;
  final bool isAdded;

  NativePlatformState({
    this.logList = const [],
    required this.mediationNative,
    this.isNotSupport = false,
    this.isAdded = false,
  });

  NativePlatformState copyWith({
    List<String>? logList,
    MediationNative? mediationNative,
    bool? isNotSupport,
  }) {
    return NativePlatformState(
      logList: logList ?? this.logList,
      mediationNative: mediationNative ?? this.mediationNative,
      isNotSupport: isNotSupport ?? this.isNotSupport,
    );
  }
}

class NativePlatformViewModel extends StateNotifier<NativePlatformState> {
  NativePlatformViewModel(Mediation mediation)
      : super(NativePlatformState(mediationNative: MediationNative.pure())) {
    switch (mediation) {
      case Mediation.pure:
        state = state.copyWith(mediationNative: MediationNative.pure());
        break;
      case Mediation.mobon:
        state = state.copyWith(mediationNative: MediationNative.mobon());
        break;
      case Mediation.mezzo:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.cauly:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.unityAds:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.vungle:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.applovinBidding:
        state = state.copyWith(mediationNative: MediationNative.applovin());
        break;
      case Mediation.applovinWaterfall:
        state = state.copyWith(isNotSupport: true);
        break;
    }
  }

  void changeMediationNative(MediationNative mediationNative) {
    state = state.copyWith(mediationNative: mediationNative);
  }

  void logEvent(String event) {
    state = state.copyWith(logList: [...state.logList, event]);
  }

  void onClicked() {
    logEvent("onClicked");
  }

  void onLoadFailed(OAMError admaxError) {
    logEvent(
        "onLoadFailed code : ${admaxError.code} message : ${admaxError.message}");
  }

  void onLoaded() {
    logEvent("onLoaded");
  }

  void onOpened() {
    logEvent("onOpened");
  }

  void onAdHidden() {
    logEvent("onAdHidden");
  }
}

final nativePlatformProvider =
    StateNotifierProvider<NativePlatformViewModel, NativePlatformState>((ref) {
  final mediation = ref.watch(mediationProvider).mediation;
  return NativePlatformViewModel(mediation);
});
