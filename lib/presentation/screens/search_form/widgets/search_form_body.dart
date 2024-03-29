import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/extensions/build_context.dart';
import 'package:github_app/extensions/number.dart';
import 'package:github_app/model/use_cases/search_repo/search_repo.dart';
import 'package:github_app/presentation/widgets/shimmer/shimmer_list_loading.dart';
import 'package:github_app/presentation/widgets/repository_tile.dart';
import 'package:go_router/go_router.dart';

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

    if (searchKeywordState.isEmpty) {
      return const SizedBox();
    }

    return searchResult.when(
      data: (data) {
        if (data.items.value.isEmpty) {
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

        return Stack(
          children: [
            CustomScrollView(
              controller: ref.watch(scrollController),
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index != data.items.value.length) {
                        final repository = data.items.value[index];

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (index != 0)
                              const Divider(
                                height: 1,
                                indent: 16,
                                endIndent: 16,
                              ),
                            RepositoryTile(
                              onTap: () {
                                context.go(
                                  '/search/${repository.id}',
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
                    childCount: data.items.value.length + 1,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.inverseSurface.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${sortKeyState.label}順 | ${data.items.totalCount.format()}件',
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: context.colorScheme.onInverseSurface,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      error: (error, stack) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'おっと!',
                    style: context.textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'リクエストしたデータが存在しない、またはリソースへのアクセス権限がないためエラーが発生しました。キーワードを変更してもう一度やり直してください。',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      loading: () {
        return const ShimmerListLoading();
      },
    );
  }
}
