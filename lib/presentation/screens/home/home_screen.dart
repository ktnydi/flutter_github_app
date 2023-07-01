import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/model/use_cases/authenticator/authenticator.dart';
import 'package:github_app/presentation/screens/search/search_screen.dart';
import 'package:github_app/presentation/screens/user_repository_list/user_repository_list_screen.dart';
import 'widgets/user_profile.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authenticatorProvider).value;
    final userNotifier = ref.watch(authenticatorProvider.notifier);

    Future<void> logout() async {
      final result = await showOkCancelAlertDialog(
        context: context,
        title: 'サインアウトしますか？',
      );

      if (result == OkCancelResult.cancel) return;

      await userNotifier.signOut();

      // ignore: use_build_context_synchronously
      if (!context.mounted) return;

      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SearchRepositoriesScreen(),
        ),
        (route) => false,
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              if (user != null)
                ProviderScope(
                  overrides: [
                    userProfileProvider.overrideWithValue(user),
                  ],
                  child: const UserProfile(),
                ),
              const Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
              ),
              const SizedBox(height: 12),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserRepositoryListScreen(
                        repositoryType: SegmentAction.public,
                      ),
                    ),
                  );
                },
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.book_outlined,
                    color: Colors.white,
                  ),
                ),
                title: const Text('リポジトリ'),
                trailing: const Icon(Icons.navigate_next),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserRepositoryListScreen(
                        repositoryType: SegmentAction.star,
                      ),
                    ),
                  );
                },
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.star_outline,
                    color: Colors.white,
                  ),
                ),
                title: const Text('スター'),
                trailing: const Icon(Icons.navigate_next),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
