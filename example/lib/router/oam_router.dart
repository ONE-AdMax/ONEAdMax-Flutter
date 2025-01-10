import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:one_admax_flutter_example/ui/banner_detail.dart';
import 'package:one_admax_flutter_example/ui/home_detail.dart';
import 'package:one_admax_flutter_example/ui/native_platform_detail.dart';
import 'package:one_admax_flutter_example/ui/native_template_detail.dart';
import 'package:one_admax_flutter_example/ui/reward_detail.dart';
import 'package:one_admax_flutter_example/widget/bottom_navigation.dart';

import '../ui/interstitial_ad_detail.dart';
import '../ui/interstitial_video_detail.dart';
import '../ui/native_choice_detail.dart';
import '../widget/choice_widget.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter admaxRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _shellNavigatorKey,
  routes: [
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) =>
          Scaffold(
        body: child,
        bottomNavigationBar: const OAMBottomNavigation(),
      ),
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              const HomeDetailScreen(),
          routes: [
            GoRoute(
                path: 'reward',
                builder: (BuildContext context, GoRouterState state) =>
                    const RewardDetailScreen()),
            GoRoute(
              path: 'interstitial',
              builder: (BuildContext context, GoRouterState state) =>
                  ChoiceWidget(
                title: 'Interstitial Ad',
                firstButtonTitle: 'Interstitial Ads',
                secondButtonTitle: 'Interstitial Video',
                firstButtonClicked: () => context.go('/interstitial/ads'),
                secondButtonClicked: () => context.go('/interstitial/video'),
              ),
              routes: [
                GoRoute(
                    path: 'video',
                    builder: (BuildContext context, GoRouterState state) =>
                        const InterstitialVideoDetailScreen()),
                GoRoute(
                    path: 'ads',
                    builder: (BuildContext context, GoRouterState state) =>
                        const InterstitialAdDetailScreen()),
              ],
            ),
            GoRoute(
                path: 'banner',
                builder: (BuildContext context, GoRouterState state) =>
                    const BannerDetailScreen()),
            GoRoute(
              path: 'native',
              builder: (BuildContext context, GoRouterState state) => const NativeChoiceDetail(),
              routes: [
                GoRoute(
                  path: 'platform',
                  builder: (BuildContext context, GoRouterState state) =>
                      const NativePlatformDetail(),
                ),
                GoRoute(
                  path: 'template',
                  builder: (BuildContext context, GoRouterState state) =>
                      const NativeTemplateDetail(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
