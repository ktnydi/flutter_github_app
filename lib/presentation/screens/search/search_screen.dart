import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/extensions/build_context.dart';
import 'package:github_app/presentation/screens/search/widgets/appbar.dart';
import 'package:github_app/presentation/screens/search_form/search_form_screen.dart';

class SearchRepositoriesScreen extends ConsumerWidget {
  const SearchRepositoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                minimumSize: const Size(280, 48),
              ),
              icon: const Icon(Icons.search),
              label: const Text('GitHub内のリポジトリを検索'),
            ),
          ],
        ),
      ),
    );
  }
}
