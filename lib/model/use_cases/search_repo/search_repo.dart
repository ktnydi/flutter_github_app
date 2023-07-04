import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/model/repositories/profile_repo_repository.dart';
import 'package:github_app/model/use_cases/search_repo/search_repo_state.dart';

final searchRepoQueryProvider = StateProvider.autoDispose((ref) => '');
final searchSortKeyProvider =
    StateProvider.autoDispose<SortKey>((ref) => SortKey.related);

enum SortKey {
  related(query: '', label: '関連度'),
  stars(query: 'stars', label: 'スター数'),
  ;

  const SortKey({
    required this.query,
    required this.label,
  });

  final String query;
  final String label;
}

final searchRepoProvider = StateNotifierProvider.autoDispose<SearchRepoNotifier,
    AsyncValue<SearchRepoState>>((ref) {
  return SearchRepoNotifier(
    ref,
    query: ref.watch(searchRepoQueryProvider),
    sortKey: ref.watch(searchSortKeyProvider),
  );
});

class SearchRepoNotifier extends StateNotifier<AsyncValue<SearchRepoState>> {
  SearchRepoNotifier(
    this.ref, {
    required this.query,
    required this.sortKey,
  }) : super(const AsyncValue.loading()) {
    () async {
      state = await AsyncValue.guard(() async {
        if (query.trim().isEmpty) {
          return const SearchRepoState();
        }

        final result = await repoRepository.searchRepositories(
          query: query,
          sort: sortKey.query,
        );
        return SearchRepoState(
          items: result,
          hasNext: result.value.length == perPage,
        );
      });
    }();
  }

  final Ref ref;
  final int perPage = 30;
  final String query;
  final SortKey sortKey;

  ProfileRepoRepository get repoRepository =>
      ref.read(profileRepoRepositoryProvider)!;

  Future<void> fetchNextItems() async {
    final value = state.value;

    if (value == null) return;

    if (!value.hasNext) return;

    state = await AsyncValue.guard(() async {
      final result = await repoRepository.searchRepositories(
        query: query,
        sort: sortKey.query,
        page: value.page + 1,
      );
      return SearchRepoState(
        items: value.items.copyWith(
          value: [...value.items.value, ...result.value],
        ),
        hasNext: result.value.length == perPage,
        page: value.page + 1,
      );
    });
  }
}
