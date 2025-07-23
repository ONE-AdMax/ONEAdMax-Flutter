import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:one_admax_flutter/one_admax_flutter.dart';
import 'package:one_admax_flutter_example/const/oamPlacementIds.dart';

class Banner {
  final String title;
  final String placementId;
  final BannerSize bannerSize;
  final BannerMediationExtras? bannerMediationExtras;

  Banner(
      {required this.title,
      required this.placementId,
      required this.bannerSize,
      this.bannerMediationExtras});
}

final List<Banner> pureBanners = [
  Banner(
      title: "320x50",
      placementId: OamPlacementIds.BANNER_ID_320x50,
      bannerSize: BannerSize.BANNER_320x50),
  Banner(
      title: "320x100",
      placementId: OamPlacementIds.BANNER_ID_320x100,
      bannerSize: BannerSize.BANNER_320x100),
  Banner(
      title: "300x250",
      placementId: OamPlacementIds.BANNER_ID_300x250,
      bannerSize: BannerSize.BANNER_300x250),
];

final List<Banner> mobonBanners = [
  Banner(
      title: "320x50",
      placementId: dotenv.env['MOBON_BANNER_PLACEMENT_ID_320_50']!,
      bannerSize: BannerSize.BANNER_320x50),
  Banner(
      title: "320x100",
      placementId: dotenv.env['MOBON_BANNER_PLACEMENT_ID_320_100']!,
      bannerSize: BannerSize.BANNER_320x100),
  Banner(
      title: "300x250",
      placementId: dotenv.env['MOBON_BANNER_PLACEMENT_ID_300_250']!,
      bannerSize: BannerSize.BANNER_300x250),
];

final List<Banner> mezzoBanners = [
  Banner(
      title: "320x50",
      placementId: dotenv.env['MEZZO_BANNER_PLACEMENT_ID_320_50']!,
      bannerSize: BannerSize.BANNER_320x50,
      bannerMediationExtras: MezzoExtras(
          ageLevel: 1,
          isEnableBackgroundCheck: false,
          storeUrl: "https://dev.onestore.net/devpoc/index.omp")),
  Banner(
      title: "320x100",
      placementId: dotenv.env['MEZZO_BANNER_PLACEMENT_ID_320_100']!,
      bannerSize: BannerSize.BANNER_320x100),
  Banner(
      title: "300x250",
      placementId: dotenv.env['MEZZO_BANNER_PLACEMENT_ID_300_250']!,
      bannerSize: BannerSize.BANNER_300x250),
];

final List<Banner> caulyBanners = [
  Banner(
      title: "320x50",
      placementId: dotenv.env['CAULY_BANNER_PLACEMENT_ID_320_50']!,
      bannerSize: BannerSize.BANNER_320x50,
      bannerMediationExtras: CaulyExtras(isEnableDynamicReloadInterval: false)),
  Banner(
      title: "320x100",
      placementId: dotenv.env['CAULY_BANNER_PLACEMENT_ID_320_100']!,
      bannerSize: BannerSize.BANNER_320x100),
  Banner(
      title: "300x250",
      placementId: dotenv.env['CAULY_BANNER_PLACEMENT_ID_300_250']!,
      bannerSize: BannerSize.BANNER_300x250),
];

final List<Banner> unityAdBanners = [
  Banner(
      title: "320x50",
      placementId: dotenv.env['UNITYADS_BANNER_PLACEMENT_ID_320_50']!,
      bannerSize: BannerSize.BANNER_320x50),
  Banner(
      title: "320x100",
      placementId: dotenv.env['UNITYADS_BANNER_PLACEMENT_ID_320_100']!,
      bannerSize: BannerSize.BANNER_320x100),
  Banner(
      title: "300x250",
      placementId: dotenv.env['UNITYADS_BANNER_PLACEMENT_ID_300_250']!,
      bannerSize: BannerSize.BANNER_300x250),
];
