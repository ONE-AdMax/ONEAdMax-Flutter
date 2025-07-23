import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_admax_flutter_example/model/mediation.dart';

import '../model/banner.dart';
import 'mediation_viewmodel.dart';

class BannerDetailViewmodel extends StateNotifier<BannerDetailState> {
  BannerDetailViewmodel(Mediation mediation) : super(BannerDetailState()) {
    switch (mediation) {
      case Mediation.pure:
        state = state.copyWith(bannerList: pureBanners);
        break;
      case Mediation.mobon:
        state = state.copyWith(bannerList: mobonBanners);
        break;
      case Mediation.mezzo:
        state = state.copyWith(bannerList: mezzoBanners);
        break;
      case Mediation.cauly:
        state = state.copyWith(bannerList: caulyBanners);
        break;
      case Mediation.unityAds:
        state = state.copyWith(bannerList: unityAdBanners);
        break;
      case Mediation.vungle:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.applovinBidding:
        state = state.copyWith(isNotSupport: true);
        break;
      case Mediation.applovinWaterfall:
        state = state.copyWith(isNotSupport: true);
        break;
    }
  }
}

class BannerDetailState {
  final List<Banner> bannerList;
  final bool isNotSupport;

  BannerDetailState({
    this.bannerList = const [],
    this.isNotSupport = false,
  });

  BannerDetailState copyWith({
    List<Banner>? bannerList,
    bool? isNotSupport,
  }) {
    return BannerDetailState(
      bannerList: bannerList ?? this.bannerList,
      isNotSupport: isNotSupport ?? this.isNotSupport,
    );
  }
}

final bannerDetailProvider =
    StateNotifierProvider<BannerDetailViewmodel, BannerDetailState>((ref) {
  final mediation = ref.watch(mediationProvider).mediation;
  return BannerDetailViewmodel(mediation);
});
