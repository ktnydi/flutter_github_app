import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/extensions/build_context.dart';
import 'package:github_app/model/use_cases/profile_repo/search_repo/search_repo.dart';
import 'package:github_app/presentation/screens/repository/repository_screen.dart';
import 'package:github_app/presentation/widgets/repository_tile.dart';

import 'widgets/search_field.dart';

final scrollController = Provider((ref) {
  final controller = ScrollController();

  controller.addListener(() {
    if (controller.position.maxScrollExtent == controller.offset) {
      ref.read(searchRepoProvider.notifier).fetchNextItems();
    }
  });

  return controller;
});

class SearchRepositoriesScreen extends ConsumerWidget {
  const SearchRepositoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResult = ref.watch(searchRepoProvider);
    final searchKeywordState = ref.watch(searchRepoQueryProvider);

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

          if (data.items.isEmpty) {
            return const Center(
              child: Text('一致する結果が見つかりませんでした。'),
            );
          }

          return ListView.separated(
            controller: ref.watch(scrollController),
            itemBuilder: (context, index) {
              if (index != data.items.length) {
                final repository = data.items[index];

                return RepositoryTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RepositoryScreen(id: repository.id),
                      ),
                    );
                  },
                  repository: repository,
                );
              }

              return Container(
                height: 100,
                alignment: Alignment.center,
                child: data.hasNext
                    ? const CircularProgressIndicator()
                    : const SizedBox(),
              );
            },
            separatorBuilder: (_, __) => const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
            ),
            itemCount: data.items.length + 1,
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
