import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/presentation/screens/search/search_screen.dart';

import '../auth/auth_screen.dart';
import '../../../provider/shared_preferences_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accessToken =
        ref.watch(sharedPreferencesProvider).getString('accessToken');

    if (accessToken != null) {
      return const SearchRepositoriesScreen();
    } else {
      return const AuthScreen();
    }
  }
}
