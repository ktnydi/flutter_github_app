import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/extensions/build_context.dart';
import 'package:github_app/model/repositories/user_repository.dart';
import 'package:github_app/model/use_cases/profile_repo/search_repo/search_repo.dart';
import 'package:github_app/presentation/screens/home/home_screen.dart';
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
    final sortKeyState = ref.watch(searchSortKeyProvider);
    final sortKeyNotifier = ref.watch(searchSortKeyProvider.notifier);
    final user = ref.watch(userProvider).value;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const SearchField(),
        actions: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                child: Material(
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl: user.avatarUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
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

          return CustomScrollView(
            controller: ref.watch(scrollController),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Row(
                    children: SortKey.values.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: FilterChip(
                          label: Text(e.label),
                          selected: sortKeyState == e,
                          onSelected: (bool value) {
                            sortKeyNotifier.state = e;
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 16),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index != data.items.length) {
                      final repository = data.items[index];

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (index != 0 && index != data.items.length - 1)
                            const Divider(
                              height: 1,
                              indent: 16,
                              endIndent: 16,
                            ),
                          RepositoryTile(
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
                          ),
                        ],
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
                  childCount: data.items.length + 1,
                ),
              ),
            ],
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
