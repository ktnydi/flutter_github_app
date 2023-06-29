import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:github_app/model/domains/github_repo/github_repo.dart';

part 'github_repositories.freezed.dart';
part 'github_repositories.g.dart';

@freezed
class GithubRepositories with _$GithubRepositories {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GithubRepositories({
    @Default([]) List<GithubRepo> value,
    @Default(0) int totalCount,
  }) = _GithubRepositories;
}
