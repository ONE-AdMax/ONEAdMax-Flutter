import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OAMBottomNavigation extends StatefulWidget {
  const OAMBottomNavigation({super.key});

  @override
  State<OAMBottomNavigation> createState() => _OAMBottomNavigationState();
}

class _OAMBottomNavigationState extends State<OAMBottomNavigation> {
  int selectedIndex = 0;

  void onDestinationSelected(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        context.replace('/');
        break;
      case 1:
        context.replace('/reward');
        break;
      case 2:
        context.replace('/interstitial');
        break;
      case 3:
        context.replace('/banner');
        break;
      case 4:
        context.replace('/native');
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onDestinationSelected,
      selectedIndex: selectedIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),

        NavigationDestination(
          icon: Icon(Icons.monetization_on),
          label: 'Reward',
        ),
        NavigationDestination(
          icon: Icon(Icons.interests_sharp),
          label: 'Interstitial',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_box),
          label: 'Banner',
        ),
        NavigationDestination(
          icon: Icon(Icons.ad_units_rounded),
          label: 'Native',
        ),
      ],
    );
  }
}
