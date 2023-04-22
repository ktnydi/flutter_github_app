// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_repo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SearchRepoState {
  List<GithubRepo> get items => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchRepoStateCopyWith<SearchRepoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchRepoStateCopyWith<$Res> {
  factory $SearchRepoStateCopyWith(
          SearchRepoState value, $Res Function(SearchRepoState) then) =
      _$SearchRepoStateCopyWithImpl<$Res, SearchRepoState>;
  @useResult
  $Res call({List<GithubRepo> items, bool hasNext, int page});
}

/// @nodoc
class _$SearchRepoStateCopyWithImpl<$Res, $Val extends SearchRepoState>
    implements $SearchRepoStateCopyWith<$Res> {
  _$SearchRepoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasNext = null,
    Object? page = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<GithubRepo>,
      hasNext: null == hasNext
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SearchRepoStateCopyWith<$Res>
    implements $SearchRepoStateCopyWith<$Res> {
  factory _$$_SearchRepoStateCopyWith(
          _$_SearchRepoState value, $Res Function(_$_SearchRepoState) then) =
      __$$_SearchRepoStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<GithubRepo> items, bool hasNext, int page});
}

/// @nodoc
class __$$_SearchRepoStateCopyWithImpl<$Res>
    extends _$SearchRepoStateCopyWithImpl<$Res, _$_SearchRepoState>
    implements _$$_SearchRepoStateCopyWith<$Res> {
  __$$_SearchRepoStateCopyWithImpl(
      _$_SearchRepoState _value, $Res Function(_$_SearchRepoState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? hasNext = null,
    Object? page = null,
  }) {
    return _then(_$_SearchRepoState(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<GithubRepo>,
      hasNext: null == hasNext
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SearchRepoState implements _SearchRepoState {
  const _$_SearchRepoState(
      {final List<GithubRepo> items = const [],
      this.hasNext = true,
      this.page = 1})
      : _items = items;

  final List<GithubRepo> _items;
  @override
  @JsonKey()
  List<GithubRepo> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final bool hasNext;
  @override
  @JsonKey()
  final int page;

  @override
  String toString() {
    return 'SearchRepoState(items: $items, hasNext: $hasNext, page: $page)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SearchRepoState &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.page, page) || other.page == page));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), hasNext, page);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SearchRepoStateCopyWith<_$_SearchRepoState> get copyWith =>
      __$$_SearchRepoStateCopyWithImpl<_$_SearchRepoState>(this, _$identity);
}

abstract class _SearchRepoState implements SearchRepoState {
  const factory _SearchRepoState(
      {final List<GithubRepo> items,
      final bool hasNext,
      final int page}) = _$_SearchRepoState;

  @override
  List<GithubRepo> get items;
  @override
  bool get hasNext;
  @override
  int get page;
  @override
  @JsonKey(ignore: true)
  _$$_SearchRepoStateCopyWith<_$_SearchRepoState> get copyWith =>
      throw _privateConstructorUsedError;
}
