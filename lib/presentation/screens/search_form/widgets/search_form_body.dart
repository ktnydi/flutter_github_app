import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/extensions/build_context.dart';
import 'package:github_app/model/use_cases/profile_repo/search_repo/search_repo.dart';
import 'package:github_app/presentation/screens/repository/repository_screen.dart';
import 'package:github_app/presentation/widgets/repository_tile.dart';

final scrollController = Provider((ref) {
  final controller = ScrollController();

  controller.addListener(() {
    if (controller.position.maxScrollExtent == controller.offset) {
      ref.read(searchRepoProvider.notifier).fetchNextItems();
    }
  });

  return controller;
});

class SearchFormBody extends ConsumerWidget {
  const SearchFormBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResult = ref.watch(searchRepoProvider);
    final searchKeywordState = ref.watch(searchRepoQueryProvider);
    final sortKeyState = ref.watch(searchSortKeyProvider);
    final sortKeyNotifier = ref.watch(searchSortKeyProvider.notifier);

    if (searchKeywordState.isEmpty) {
      return const SizedBox();
    }

    return searchResult.when(
      data: (data) {
        if (data.items.isEmpty) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '結果なし',
                      style: context.textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '入力したキーワードに関連するリポジトリは見つかりませんでした。',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: SortKey.values.map((e) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      showCheckmark: false,
                      label: Text(e.label),
                      selected: sortKeyState == e,
                      onSelected: (bool value) {
                        HapticFeedback.lightImpact();
                        sortKeyNotifier.state = e;
                      },
                      side: BorderSide(
                        color: sortKeyState == e
                            ? Colors.transparent
                            : context.colorScheme.surfaceVariant,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: CustomScrollView(
                controller: ref.watch(scrollController),
                slivers: [
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
                                      builder: (context) => RepositoryScreen(
                                        id: repository.id,
                                      ),
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
    );
  }
}
