import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/mediation.dart';

class MediationState {
  const MediationState({required this.mediation});

  final Mediation mediation;

  copyWith({Mediation? mediation}) => MediationState(
        mediation: mediation ?? this.mediation,
      );
}

class MediationViewModel extends StateNotifier<MediationState> {
  MediationViewModel()
      : super(const MediationState(mediation: Mediation.mobon));

  void setMediation(Mediation mediation) {
    state = state.copyWith(mediation: mediation);
  }
}

final mediationProvider =
    StateNotifierProvider<MediationViewModel, MediationState>(
  (ref) => MediationViewModel(),
);
