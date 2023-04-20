import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/extensions/build_context.dart';
import 'package:github_app/presentation/screens/repository/repository_screen.dart';
import 'package:github_app/presentation/widgets/repository_tile.dart';

import '../../../model/use_cases/profile_repo/search_repositories.dart';
import 'widgets/search_field.dart';

class SearchRepositoriesScreen extends ConsumerWidget {
  const SearchRepositoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResult = ref.watch(searchRepositories);
    final searchKeywordState = ref.watch(searchKeywordProvider);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const SearchField(),
      ),
      body: searchResult.when(
        data: (data) {
          if (searchKeywordState.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.search,
                    size: 80,
                    color: context.colorScheme.surfaceVariant,
                  ),
                  const Text('リポジトリを検索してください。'),
                ],
              ),
            );
          }

          if (data!.isEmpty) {
            return const Center(
              child: Text('一致する結果が見つかりませんでした。'),
            );
          }

          return ListView.separated(
            itemBuilder: (context, index) {
              final repository = data[index];

              return RepositoryTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RepositoryScreen(id: repository.id),
                    ),
                  );
                },
                repository: repository,
              );
            },
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
            ),
            itemCount: data.length,
          );
        },
        error: (error, stack) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.error_outline),
                SizedBox(height: 16),
                Text('エラーが発生しました。'),
              ],
            ),
          );
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
