import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/extensions/build_context.dart';
import 'package:github_app/model/use_cases/authenticator/authenticator.dart';
import 'package:go_router/go_router.dart';

class SearchScreenBody extends ConsumerWidget {
  const SearchScreenBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(authenticatorProvider);
    final userNotifier = ref.watch(authenticatorProvider.notifier);
    final isDark = context.colorScheme.brightness == Brightness.dark;

    Future<void> signIn() async {
      try {
        await userNotifier.signIn();

        // ignore: use_build_context_synchronously
        if (!context.mounted) return;

        context.go('/');
      } on PlatformException catch (error, stack) {
        debugPrintStack(
          stackTrace: stack,
          label: error.toString(),
        );

        showOkAlertDialog(
          context: context,
          title: error.code,
          message: error.message,
        );
      }
    }

    return asyncUser.when(
      data: (user) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                isDark
                    ? 'assets/github-mark-white.png'
                    : 'assets/github-mark.png',
                width: 140,
              ),
              const SizedBox(height: 8),
              Text(
                'GitHuboo!', // GitHub + Yahoo!
                style: context.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'リポジトリ検索ツール',
                style: context.textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              if (user != null)
                FilledButton.tonalIcon(
                  onPressed: () {
                    context.go('/search');
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: context.colorScheme.surfaceVariant,
                    minimumSize: const Size(280, 56),
                  ),
                  icon: const Icon(Icons.search),
                  label: const Text('GitHub内のリポジトリを検索'),
                )
              else
                FilledButton.tonalIcon(
                  onPressed: signIn,
                  style: FilledButton.styleFrom(
                    backgroundColor: isDark ? Colors.white : Colors.black,
                    foregroundColor: isDark ? Colors.black : Colors.white,
                    minimumSize: const Size(280, 56),
                  ),
                  icon: Image.asset(
                    isDark
                        ? 'assets/github-mark.png'
                        : 'assets/github-mark-white.png',
                    width: 24,
                    filterQuality: FilterQuality.medium,
                  ),
                  label: const Text('GitHubでサインイン'),
                ),
            ],
          ),
        );
      },
      error: (error, stack) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'エラー',
                style: context.textTheme.titleMedium,
              ),
              Text(
                error.toString(),
                style: context.textTheme.titleSmall,
              ),
            ],
          ),
        );
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
