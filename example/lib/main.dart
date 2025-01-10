import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:one_admax_flutter_example/router/oam_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: admaxRouter,
    );
  }
}
