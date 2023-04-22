import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domains/github_repo/github_repo.dart';

part 'search_repo_state.freezed.dart';

@freezed
class SearchRepoState with _$SearchRepoState {
  const factory SearchRepoState({
    @Default([]) List<GithubRepo> items,
    @Default(true) bool hasNext,
    @Default(1) int page,
  }) = _SearchRepoState;
}
