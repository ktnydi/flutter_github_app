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
      pushedAt:
          const DateTimeStringConverter().fromJson(json['pushed_at'] as String),
      createdAt: const DateTimeStringConverter()
          .fromJson(json['created_at'] as String),
      updatedAt: const DateTimeStringConverter()
          .fromJson(json['updated_at'] as String),
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
      'pushed_at': const DateTimeStringConverter().toJson(instance.pushedAt),
      'created_at': const DateTimeStringConverter().toJson(instance.createdAt),
      'updated_at': const DateTimeStringConverter().toJson(instance.updatedAt),
    };
