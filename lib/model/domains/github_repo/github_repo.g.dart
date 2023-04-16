// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GithubRepo _$$_GithubRepoFromJson(Map<String, dynamic> json) =>
    _$_GithubRepo(
      id: json['id'] as int,
      name: json['name'] as String,
      htmlUrl: json['html_url'] as String,
      description: json['description'] as String?,
      language: json['language'] as String?,
      forksCount: json['forks_count'] as int,
      stargazersCount: json['stargazers_count'] as int,
      watchersCount: json['watchers_count'] as int,
      openIssuesCount: json['open_issues_count'] as int,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      pushedAt: _$JsonConverterFromJson<String, DateTime>(
          json['pushed_at'], const DateTimeStringConverter().fromJson),
      createdAt: _$JsonConverterFromJson<String, DateTime>(
          json['created_at'], const DateTimeStringConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<String, DateTime>(
          json['updated_at'], const DateTimeStringConverter().fromJson),
    );

Map<String, dynamic> _$$_GithubRepoToJson(_$_GithubRepo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'html_url': instance.htmlUrl,
      'description': instance.description,
      'language': instance.language,
      'forks_count': instance.forksCount,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'open_issues_count': instance.openIssuesCount,
      'owner': instance.owner,
      'pushed_at': _$JsonConverterToJson<String, DateTime>(
          instance.pushedAt, const DateTimeStringConverter().toJson),
      'created_at': _$JsonConverterToJson<String, DateTime>(
          instance.createdAt, const DateTimeStringConverter().toJson),
      'updated_at': _$JsonConverterToJson<String, DateTime>(
          instance.updatedAt, const DateTimeStringConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
