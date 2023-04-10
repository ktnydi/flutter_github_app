import 'package:freezed_annotation/freezed_annotation.dart';

import '../json_converters/date_time_string_converter.dart';

part 'github_repo.freezed.dart';
part 'github_repo.g.dart';

@freezed
class GithubRepo with _$GithubRepo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GithubRepo({
    required int id,
    required String name,
    required String htmlUrl,
    String? description,
    String? language,
    required int forksCount,
    required int stargazersCount,
    required int watchersCount,
    required int openIssuesCount,
    @DateTimeStringConverter() DateTime? pushedAt,
    @DateTimeStringConverter() DateTime? createdAt,
    @DateTimeStringConverter() DateTime? updatedAt,
  }) = _GithubRepo;

  factory GithubRepo.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoFromJson(json);
}
