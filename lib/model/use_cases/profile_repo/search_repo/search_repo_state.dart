import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_app/model/domains/github_repositories/github_repositories.dart';

part 'search_repo_state.freezed.dart';

@freezed
class SearchRepoState with _$SearchRepoState {
  const factory SearchRepoState({
    @Default(GithubRepositories()) GithubRepositories items,
    @Default(true) bool hasNext,
    @Default(1) int page,
  }) = _SearchRepoState;
}
