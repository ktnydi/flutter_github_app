// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      login: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
      htmlUrl: json['html_url'] as String,
      name: json['name'] as String?,
      bio: json['bio'] as String?,
      followers: json['followers'] as int,
      following: json['following'] as int,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
      'html_url': instance.htmlUrl,
      'name': instance.name,
      'bio': instance.bio,
      'followers': instance.followers,
      'following': instance.following,
    };
