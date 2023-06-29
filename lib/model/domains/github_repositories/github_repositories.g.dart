// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repositories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GithubRepositories _$$_GithubRepositoriesFromJson(
        Map<String, dynamic> json) =>
    _$_GithubRepositories(
      value: (json['value'] as List<dynamic>?)
              ?.map((e) => GithubRepo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalCount: json['total_count'] as int? ?? 0,
    );

Map<String, dynamic> _$$_GithubRepositoriesToJson(
        _$_GithubRepositories instance) =>
    <String, dynamic>{
      'value': instance.value,
      'total_count': instance.totalCount,
    };
