import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'widgets/repository_list.dart';
import 'widgets/segment_actions.dart';
import 'widgets/user_profile.dart';
import '../../../model/repositories/user_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        actions: [
          if (user.value != null)
            IconButton(
              onPressed: () async {
                final url = user.value!.htmlUrl;
                if (await canLaunchUrlString(url)) {
                  launchUrlString(url);
                }
              },
              icon: const Icon(Icons.launch_outlined),
            ),
        ],
      ),
      body: user.when(
        data: (data) {
          return CustomScrollView(
            slivers: [
              ProviderScope(
                overrides: [
                  userProfileProvider.overrideWithValue(data!),
                ],
                child: const UserProfile(),
              ),
              const SliverToBoxAdapter(
                child: Divider(height: 1),
              ),
              const FilterAction(),
              const RepositoryList(),
            ],
          );
        },
        error: (error, stack) {
          return const SizedBox();
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
