import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_screen.dart';
import '../home/home_screen.dart';
import '../../../proverder/shared_preferences_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accessToken =
        ref.watch(sharedPreferencesProvider).getString('accessToken');

    if (accessToken != null) {
      return const HomeScreen();
    } else {
      return const AuthScreen();
    }
  }
}