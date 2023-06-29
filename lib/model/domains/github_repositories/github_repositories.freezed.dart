// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'github_repositories.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GithubRepositories {
  List<GithubRepo> get value => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GithubRepositoriesCopyWith<GithubRepositories> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GithubRepositoriesCopyWith<$Res> {
  factory $GithubRepositoriesCopyWith(
          GithubRepositories value, $Res Function(GithubRepositories) then) =
      _$GithubRepositoriesCopyWithImpl<$Res, GithubRepositories>;
  @useResult
  $Res call({List<GithubRepo> value, int totalCount});
}

/// @nodoc
class _$GithubRepositoriesCopyWithImpl<$Res, $Val extends GithubRepositories>
    implements $GithubRepositoriesCopyWith<$Res> {
  _$GithubRepositoriesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? totalCount = null,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as List<GithubRepo>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GithubRepositoriesCopyWith<$Res>
    implements $GithubRepositoriesCopyWith<$Res> {
  factory _$$_GithubRepositoriesCopyWith(_$_GithubRepositories value,
          $Res Function(_$_GithubRepositories) then) =
      __$$_GithubRepositoriesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GithubRepo> value, int totalCount});
}

/// @nodoc
class __$$_GithubRepositoriesCopyWithImpl<$Res>
    extends _$GithubRepositoriesCopyWithImpl<$Res, _$_GithubRepositories>
    implements _$$_GithubRepositoriesCopyWith<$Res> {
  __$$_GithubRepositoriesCopyWithImpl(
      _$_GithubRepositories _value, $Res Function(_$_GithubRepositories) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? totalCount = null,
  }) {
    return _then(_$_GithubRepositories(
      value: null == value
          ? _value._value
          : value // ignore: cast_nullable_to_non_nullable
              as List<GithubRepo>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_GithubRepositories implements _GithubRepositories {
  const _$_GithubRepositories(
      {final List<GithubRepo> value = const [], this.totalCount = 0})
      : _value = value;

  final List<GithubRepo> _value;
  @override
  @JsonKey()
  List<GithubRepo> get value {
    if (_value is EqualUnmodifiableListView) return _value;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_value);
  }

  @override
  @JsonKey()
  final int totalCount;

  @override
  String toString() {
    return 'GithubRepositories(value: $value, totalCount: $totalCount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GithubRepositories &&
            const DeepCollectionEquality().equals(other._value, _value) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_value), totalCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GithubRepositoriesCopyWith<_$_GithubRepositories> get copyWith =>
      __$$_GithubRepositoriesCopyWithImpl<_$_GithubRepositories>(
          this, _$identity);
}

abstract class _GithubRepositories implements GithubRepositories {
  const factory _GithubRepositories(
      {final List<GithubRepo> value,
      final int totalCount}) = _$_GithubRepositories;

  @override
  List<GithubRepo> get value;
  @override
  int get totalCount;
  @override
  @JsonKey(ignore: true)
  _$$_GithubRepositoriesCopyWith<_$_GithubRepositories> get copyWith =>
      throw _privateConstructorUsedError;
}
