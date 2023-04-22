import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/model/repositories/profile_repo_repository.dart';
import 'package:github_app/model/use_cases/profile_repo/search_repo/search_repo_state.dart';

final searchRepoQueryProvider = StateProvider((ref) => '');

final searchRepoProvider = StateNotifierProvider.autoDispose<SearchRepoNotifier,
    AsyncValue<SearchRepoState>>((ref) {
  return SearchRepoNotifier(
    ref,
    query: ref.watch(searchRepoQueryProvider),
  );
});

class SearchRepoNotifier extends StateNotifier<AsyncValue<SearchRepoState>> {
  SearchRepoNotifier(
    this.ref, {
    required this.query,
  }) : super(const AsyncValue.loading()) {
    () async {
      state = await AsyncValue.guard(() async {
        if (query.trim().isEmpty) {
          return const SearchRepoState();
        }

        final result = await repoRepository.searchRepositories(query: query);
        return SearchRepoState(
          items: result,
          hasNext: result.length == perPage,
        );
      });
    }();
  }

  final Ref ref;
  final int perPage = 30;
  final String query;

  ProfileRepoRepository get repoRepository =>
      ref.read(profileRepoRepositoryProvider)!;

  Future<void> fetchNextItems() async {
    final value = state.value;

    if (value == null) return;

    if (!value.hasNext) return;

    state = await AsyncValue.guard(() async {
      final result = await repoRepository.searchRepositories(
        query: query,
        page: value.page + 1,
      );
      return SearchRepoState(
        items: [...value.items, ...result],
        hasNext: result.length == perPage,
        page: value.page + 1,
      );
    });
  }
}
