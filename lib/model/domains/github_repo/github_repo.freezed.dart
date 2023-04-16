// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'github_repo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GithubRepo _$GithubRepoFromJson(Map<String, dynamic> json) {
  return _GithubRepo.fromJson(json);
}

/// @nodoc
mixin _$GithubRepo {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get htmlUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  int get forksCount => throw _privateConstructorUsedError;
  int get stargazersCount => throw _privateConstructorUsedError;
  int get watchersCount => throw _privateConstructorUsedError;
  int get openIssuesCount => throw _privateConstructorUsedError;
  Owner get owner => throw _privateConstructorUsedError;
  @DateTimeStringConverter()
  DateTime? get pushedAt => throw _privateConstructorUsedError;
  @DateTimeStringConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @DateTimeStringConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GithubRepoCopyWith<GithubRepo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GithubRepoCopyWith<$Res> {
  factory $GithubRepoCopyWith(
          GithubRepo value, $Res Function(GithubRepo) then) =
      _$GithubRepoCopyWithImpl<$Res, GithubRepo>;
  @useResult
  $Res call(
      {int id,
      String name,
      String htmlUrl,
      String? description,
      String? language,
      int forksCount,
      int stargazersCount,
      int watchersCount,
      int openIssuesCount,
      Owner owner,
      @DateTimeStringConverter() DateTime? pushedAt,
      @DateTimeStringConverter() DateTime? createdAt,
      @DateTimeStringConverter() DateTime? updatedAt});

  $OwnerCopyWith<$Res> get owner;
}

/// @nodoc
class _$GithubRepoCopyWithImpl<$Res, $Val extends GithubRepo>
    implements $GithubRepoCopyWith<$Res> {
  _$GithubRepoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? htmlUrl = null,
    Object? description = freezed,
    Object? language = freezed,
    Object? forksCount = null,
    Object? stargazersCount = null,
    Object? watchersCount = null,
    Object? openIssuesCount = null,
    Object? owner = null,
    Object? pushedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      htmlUrl: null == htmlUrl
          ? _value.htmlUrl
          : htmlUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      forksCount: null == forksCount
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as int,
      stargazersCount: null == stargazersCount
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as int,
      watchersCount: null == watchersCount
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as int,
      openIssuesCount: null == openIssuesCount
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as int,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Owner,
      pushedAt: freezed == pushedAt
          ? _value.pushedAt
          : pushedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OwnerCopyWith<$Res> get owner {
    return $OwnerCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_GithubRepoCopyWith<$Res>
    implements $GithubRepoCopyWith<$Res> {
  factory _$$_GithubRepoCopyWith(
          _$_GithubRepo value, $Res Function(_$_GithubRepo) then) =
      __$$_GithubRepoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String htmlUrl,
      String? description,
      String? language,
      int forksCount,
      int stargazersCount,
      int watchersCount,
      int openIssuesCount,
      Owner owner,
      @DateTimeStringConverter() DateTime? pushedAt,
      @DateTimeStringConverter() DateTime? createdAt,
      @DateTimeStringConverter() DateTime? updatedAt});

  @override
  $OwnerCopyWith<$Res> get owner;
}

/// @nodoc
class __$$_GithubRepoCopyWithImpl<$Res>
    extends _$GithubRepoCopyWithImpl<$Res, _$_GithubRepo>
    implements _$$_GithubRepoCopyWith<$Res> {
  __$$_GithubRepoCopyWithImpl(
      _$_GithubRepo _value, $Res Function(_$_GithubRepo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? htmlUrl = null,
    Object? description = freezed,
    Object? language = freezed,
    Object? forksCount = null,
    Object? stargazersCount = null,
    Object? watchersCount = null,
    Object? openIssuesCount = null,
    Object? owner = null,
    Object? pushedAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_GithubRepo(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      htmlUrl: null == htmlUrl
          ? _value.htmlUrl
          : htmlUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      forksCount: null == forksCount
          ? _value.forksCount
          : forksCount // ignore: cast_nullable_to_non_nullable
              as int,
      stargazersCount: null == stargazersCount
          ? _value.stargazersCount
          : stargazersCount // ignore: cast_nullable_to_non_nullable
              as int,
      watchersCount: null == watchersCount
          ? _value.watchersCount
          : watchersCount // ignore: cast_nullable_to_non_nullable
              as int,
      openIssuesCount: null == openIssuesCount
          ? _value.openIssuesCount
          : openIssuesCount // ignore: cast_nullable_to_non_nullable
              as int,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as Owner,
      pushedAt: freezed == pushedAt
          ? _value.pushedAt
          : pushedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_GithubRepo implements _GithubRepo {
  const _$_GithubRepo(
      {required this.id,
      required this.name,
      required this.htmlUrl,
      this.description,
      this.language,
      required this.forksCount,
      required this.stargazersCount,
      required this.watchersCount,
      required this.openIssuesCount,
      required this.owner,
      @DateTimeStringConverter() this.pushedAt,
      @DateTimeStringConverter() this.createdAt,
      @DateTimeStringConverter() this.updatedAt});

  factory _$_GithubRepo.fromJson(Map<String, dynamic> json) =>
      _$$_GithubRepoFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String htmlUrl;
  @override
  final String? description;
  @override
  final String? language;
  @override
  final int forksCount;
  @override
  final int stargazersCount;
  @override
  final int watchersCount;
  @override
  final int openIssuesCount;
  @override
  final Owner owner;
  @override
  @DateTimeStringConverter()
  final DateTime? pushedAt;
  @override
  @DateTimeStringConverter()
  final DateTime? createdAt;
  @override
  @DateTimeStringConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'GithubRepo(id: $id, name: $name, htmlUrl: $htmlUrl, description: $description, language: $language, forksCount: $forksCount, stargazersCount: $stargazersCount, watchersCount: $watchersCount, openIssuesCount: $openIssuesCount, owner: $owner, pushedAt: $pushedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GithubRepo &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.forksCount, forksCount) ||
                other.forksCount == forksCount) &&
            (identical(other.stargazersCount, stargazersCount) ||
                other.stargazersCount == stargazersCount) &&
            (identical(other.watchersCount, watchersCount) ||
                other.watchersCount == watchersCount) &&
            (identical(other.openIssuesCount, openIssuesCount) ||
                other.openIssuesCount == openIssuesCount) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.pushedAt, pushedAt) ||
                other.pushedAt == pushedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      htmlUrl,
      description,
      language,
      forksCount,
      stargazersCount,
      watchersCount,
      openIssuesCount,
      owner,
      pushedAt,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GithubRepoCopyWith<_$_GithubRepo> get copyWith =>
      __$$_GithubRepoCopyWithImpl<_$_GithubRepo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GithubRepoToJson(
      this,
    );
  }
}

abstract class _GithubRepo implements GithubRepo {
  const factory _GithubRepo(
      {required final int id,
      required final String name,
      required final String htmlUrl,
      final String? description,
      final String? language,
      required final int forksCount,
      required final int stargazersCount,
      required final int watchersCount,
      required final int openIssuesCount,
      required final Owner owner,
      @DateTimeStringConverter() final DateTime? pushedAt,
      @DateTimeStringConverter() final DateTime? createdAt,
      @DateTimeStringConverter() final DateTime? updatedAt}) = _$_GithubRepo;

  factory _GithubRepo.fromJson(Map<String, dynamic> json) =
      _$_GithubRepo.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get htmlUrl;
  @override
  String? get description;
  @override
  String? get language;
  @override
  int get forksCount;
  @override
  int get stargazersCount;
  @override
  int get watchersCount;
  @override
  int get openIssuesCount;
  @override
  Owner get owner;
  @override
  @DateTimeStringConverter()
  DateTime? get pushedAt;
  @override
  @DateTimeStringConverter()
  DateTime? get createdAt;
  @override
  @DateTimeStringConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_GithubRepoCopyWith<_$_GithubRepo> get copyWith =>
      throw _privateConstructorUsedError;
}
