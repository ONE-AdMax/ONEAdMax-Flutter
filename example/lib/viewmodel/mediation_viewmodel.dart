import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/mediation.dart';

class MediationState {
  const MediationState({required this.mediation});

  final Mediation mediation;

  copyWith({String? appKey, Mediation? mediation}) => MediationState(
        mediation: mediation ?? this.mediation,
      );
}

class MediationViewModel extends StateNotifier<MediationState> {
  MediationViewModel()
      : super(const MediationState(mediation: Mediation.adFit));

  void setMediation(Mediation mediation) {
    final appKey = (mediation == Mediation.pure) ? "938555472" : "466125395";
    state = state.copyWith(mediation: mediation, appKey: appKey);
  }
}

final mediationProvider =
    StateNotifierProvider<MediationViewModel, MediationState>(
  (ref) => MediationViewModel(),
);
