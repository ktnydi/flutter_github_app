import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/model/repositories/profile_repo_repository.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/domains/github_repo/github_repo.dart';
import '../../widgets/repository_tile.dart';

enum SegmentAction {
  public(label: 'リポジトリ'),
  star(label: 'スター'),
  ;

  const SegmentAction({required this.label});

  final String label;
}

final userRepoPagingController = Provider.autoDispose((ref) {
  final controller = PagingController<int, GithubRepo>(firstPageKey: 1);
  controller.addPageRequestListener((pageKey) async {
    try {
      final repository = ref.read(profileRepoRepositoryProvider);
      final items = await repository!.fetchProfileRepositories(
        page: pageKey,
        perPage: 30,
      );
      final isLastPage = items.length < 30;
      if (isLastPage) {
        controller.appendLastPage(items);
      } else {
        controller.appendPage(items, pageKey + 1);
      }
    } on Exception catch (error, stack) {
      controller.error = error;

      debugPrintStack(
        label: error.toString(),
        stackTrace: stack,
      );
    }
  });

  ref.onDispose(() => controller.dispose());

  return controller;
});

final starRepoPagingController = Provider.autoDispose((ref) {
  final controller = PagingController<int, GithubRepo>(firstPageKey: 1);
  controller.addPageRequestListener((pageKey) async {
    final repository = ref.read(profileRepoRepositoryProvider);
    final items = await repository!.fetchStarredRepositories(
      page: pageKey,
      perPage: 30,
    );
    final isLastPage = items.length < 30;
    if (isLastPage) {
      controller.appendLastPage(items);
    } else {
      controller.appendPage(items, pageKey + 1);
    }
  });

  ref.onDispose(() => controller.dispose());

  return controller;
});

final pagingControllerProvider = Provider.autoDispose
    .family<PagingController<int, GithubRepo>, SegmentAction>(
  (ref, action) {
    if (action == SegmentAction.star) {
      return ref.watch(starRepoPagingController);
    } else {
      return ref.watch(userRepoPagingController);
    }
  },
);

class UserRepositoryListScreen extends ConsumerWidget {
  const UserRepositoryListScreen({
    super.key,
    required this.repositoryType,
  });

  final SegmentAction repositoryType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagingController =
        ref.watch(pagingControllerProvider(repositoryType));

    return Scaffold(
      appBar: AppBar(
        title: Text(repositoryType.label),
      ),
      body: PagedListView<int, GithubRepo>.separated(
        pagingController: pagingController,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
        builderDelegate: PagedChildBuilderDelegate<GithubRepo>(
          itemBuilder: (context, item, index) {
            final repository = item;

            return RepositoryTile(
              onTap: () {
                launchUrl(Uri.parse(repository.htmlUrl));
              },
              repository: repository,
            );
          },
          noItemsFoundIndicatorBuilder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: const Text(
                'リポジトリが見つかりませんでした。',
                textAlign: TextAlign.center,
              ),
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: const Text(
                'エラーが発生しました。しばらくしてから再度お試しください。',
                textAlign: TextAlign.center,
              ),
            );
          },
          newPageErrorIndicatorBuilder: (context) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'エラーが発生したため、リポジトリを取得できませんでした。',
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
    );
  }
}
