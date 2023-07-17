import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/model/use_cases/show_material_grid.dart';
import 'package:github_app/model/use_cases/theme_mode.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:github_app/presentation/router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeState = ref.watch(themeModeNotifierProvider);
    final isOnMaterialGrid = ref.watch(isOnMaterialGridProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      themeMode: themeModeState,
      debugShowMaterialGrid: isOnMaterialGrid,
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      darkTheme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.blue,
        ),
      ),
      routerConfig: router,
    );
  }
}
