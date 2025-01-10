import 'dart:ui';

/// BannerSize class
/// Get banner size from AdMax
/// Dynamic Size is not yet supported.
class BannerSize {
  final int width, height;
  final String? name;

  const BannerSize({required this.width, required this.height, this.name});

  static const BannerSize BANNER_320x50 =
      BannerSize(width: 320, height: 50, name: 'BANNER_320x50');
  static const BannerSize BANNER_320x100 =
      BannerSize(width: 320, height: 100, name: 'BANNER_320x100');
  static const BannerSize BANNER_300x250 =
      BannerSize(width: 300, height: 250, name: 'BANNER_300x250');

  Size get toSize => Size(width.toDouble(), height.toDouble());
}
