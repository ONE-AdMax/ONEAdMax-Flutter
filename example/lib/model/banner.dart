import 'package:one_admax_flutter/one_admax_flutter.dart';

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
      placementId: "ONESTORE_BANNER_320x50",
      bannerSize: BannerSize.BANNER_320x50),
  Banner(
      title: "320x100",
      placementId: "ONESTORE_BANNER_320x100",
      bannerSize: BannerSize.BANNER_320x100),
  Banner(
      title: "300x250",
      placementId: "ONESTORE_BANNER_300x250",
      bannerSize: BannerSize.BANNER_300x250),
];

final List<Banner> adfitBanners = [
  Banner(
      title: "320x50",
      placementId: "F9z0waYJDr1uRTC",
      bannerSize: BannerSize.BANNER_320x50),
  Banner(
      title: "320x100",
      placementId: "ZzyLXVsaiJy4bXL",
      bannerSize: BannerSize.BANNER_320x100),
  Banner(
      title: "300x250",
      placementId: "ywYVp0SkXLVJaPC",
      bannerSize: BannerSize.BANNER_300x250),
];

final List<Banner> mobonBanners = [
  Banner(
      title: "320x50",
      placementId: "WvVMKWUxn49yYx8",
      bannerSize: BannerSize.BANNER_320x50),
  Banner(
      title: "320x100",
      placementId: "op3H3BilGvq97Gf",
      bannerSize: BannerSize.BANNER_320x100),
  Banner(
      title: "300x250",
      placementId: "ywYVp0SkXLVJaPC",
      bannerSize: BannerSize.BANNER_300x250),
];

final List<Banner> mezzoBanners = [
  Banner(
      title: "320x50",
      placementId: "geJJbgrtjSqX5Ci",
      bannerSize: BannerSize.BANNER_320x50,
      bannerMediationExtras: MezzoExtras(
          ageLevel: 1,
          isEnableBackgroundCheck: false,
          storeUrl: "https://dev.onestore.net/devpoc/index.omp")),
  Banner(
      title: "320x100",
      placementId: "285kLtYUAcHJQvY",
      bannerSize: BannerSize.BANNER_320x100),
  Banner(
      title: "300x250",
      placementId: "93PSNaJXhT2LCIL",
      bannerSize: BannerSize.BANNER_300x250),
];

final List<Banner> caulyBanners = [
  Banner(
      title: "320x50",
      placementId: "e7XQ6rkO0D1cg3p",
      bannerSize: BannerSize.BANNER_320x50,
      bannerMediationExtras: CaulyExtras(isEnableDynamicReloadInterval: false)),
  Banner(
      title: "320x100",
      placementId: "9mG2udG9XRg0HoM",
      bannerSize: BannerSize.BANNER_320x100),
  Banner(
      title: "300x250",
      placementId: "WQxmVVeJNId4UnH",
      bannerSize: BannerSize.BANNER_300x250),
];

final List<Banner> unityAdBanners = [
  Banner(
      title: "320x50",
      placementId: "dDiKB74RZCP5Tp2",
      bannerSize: BannerSize.BANNER_320x50),
  Banner(
      title: "320x100",
      placementId: "zzKPri2tu1We5km",
      bannerSize: BannerSize.BANNER_320x100),
  Banner(
      title: "300x250",
      placementId: "mUFRJESPbDgP7d2",
      bannerSize: BannerSize.BANNER_300x250),
];
