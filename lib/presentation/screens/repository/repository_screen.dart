import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/header.dart';
import 'widgets/metadata_list.dart';
import '../../../model/domains/github_repo/github_repo.dart';
import '../../../model/use_cases/profile_repo/search_repositories.dart';

class RepositoryScreen extends ConsumerWidget {
  const RepositoryScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(
      searchRepositories.select((value) {
        return value.whenData(
          (value) => value!.firstWhere((element) => element.id == id),
        );
      }),
    ).value!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('リポジトリ詳細'),
        actions: [
          IconButton(
            onPressed: () async {
              await launchUrl(Uri.parse(repository.htmlUrl));
            },
            icon: const Icon(Icons.launch_outlined),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ProviderScope(
              overrides: [
                repositoryProvider.overrideWithValue(repository),
              ],
              child: const Header(),
            ),
          ),
          const SliverToBoxAdapter(
            child: Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
            ),
          ),
          ProviderScope(
            overrides: [
              repositoryProvider.overrideWithValue(repository),
            ],
            child: const MetadataList(),
          ),
        ],
      ),
    );
  }
}

final repositoryProvider = Provider<GithubRepo>(
  (ref) => throw UnimplementedError(),
);
