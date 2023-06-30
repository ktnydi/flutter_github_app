import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/extensions/build_context.dart';
import 'package:github_app/model/use_cases/authenticator/authenticator.dart';
import 'package:github_app/presentation/screens/search/widgets/appbar.dart';
import 'package:github_app/presentation/screens/search_form/search_form_screen.dart';

class SearchRepositoriesScreen extends ConsumerWidget {
  const SearchRepositoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authenticatorProvider);
    final userNotifier = ref.watch(authenticatorProvider.notifier);

    Future<void> signIn() async {
      try {
        await userNotifier.signIn();

        // ignore: use_build_context_synchronously
        if (!context.mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchRepositoriesScreen(),
          ),
        );
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

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: const SearchAppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/github-mark.png',
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
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const SearchFormScreen();
                      },
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  );
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
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(280, 56),
                ),
                icon: Image.asset(
                  'assets/github-mark-white.png',
                  width: 24,
                  filterQuality: FilterQuality.medium,
                ),
                label: const Text('GitHubでサインイン'),
              ),
          ],
        ),
      ),
    );
  }
}
