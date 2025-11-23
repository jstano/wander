import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wander/app/router.dart';
import 'package:wander/app/theme.dart';

class WanderApp extends ConsumerWidget {
  const WanderApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'WanderBooks',
      routerConfig: router,
      theme: wanderBooksTheme(),
      // darkTheme: createTheme(Brightness.dark),
      // themeMode: ThemeMode.system,
    );
  }
}
