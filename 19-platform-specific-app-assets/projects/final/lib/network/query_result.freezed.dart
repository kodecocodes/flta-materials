// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

QueryResult _$QueryResultFromJson(Map<String, dynamic> json) {
  return _QueryResult.fromJson(json);
}

/// @nodoc
mixin _$QueryResult {
  int get offset => throw _privateConstructorUsedError;
  int get number => throw _privateConstructorUsedError;
  int get totalResults => throw _privateConstructorUsedError;
  List<Recipe> get recipes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $QueryResultCopyWith<QueryResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueryResultCopyWith<$Res> {
  factory $QueryResultCopyWith(
          QueryResult value, $Res Function(QueryResult) then) =
      _$QueryResultCopyWithImpl<$Res, QueryResult>;
  @useResult
  $Res call({int offset, int number, int totalResults, List<Recipe> recipes});
}

/// @nodoc
class _$QueryResultCopyWithImpl<$Res, $Val extends QueryResult>
    implements $QueryResultCopyWith<$Res> {
  _$QueryResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
    Object? number = null,
    Object? totalResults = null,
    Object? recipes = null,
  }) {
    return _then(_value.copyWith(
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      recipes: null == recipes
          ? _value.recipes
          : recipes // ignore: cast_nullable_to_non_nullable
              as List<Recipe>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QueryResultCopyWith<$Res>
    implements $QueryResultCopyWith<$Res> {
  factory _$$_QueryResultCopyWith(
          _$_QueryResult value, $Res Function(_$_QueryResult) then) =
      __$$_QueryResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int offset, int number, int totalResults, List<Recipe> recipes});
}

/// @nodoc
class __$$_QueryResultCopyWithImpl<$Res>
    extends _$QueryResultCopyWithImpl<$Res, _$_QueryResult>
    implements _$$_QueryResultCopyWith<$Res> {
  __$$_QueryResultCopyWithImpl(
      _$_QueryResult _value, $Res Function(_$_QueryResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offset = null,
    Object? number = null,
    Object? totalResults = null,
    Object? recipes = null,
  }) {
    return _then(_$_QueryResult(
      offset: null == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int,
      totalResults: null == totalResults
          ? _value.totalResults
          : totalResults // ignore: cast_nullable_to_non_nullable
              as int,
      recipes: null == recipes
          ? _value._recipes
          : recipes // ignore: cast_nullable_to_non_nullable
              as List<Recipe>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_QueryResult implements _QueryResult {
  const _$_QueryResult(
      {required this.offset,
      required this.number,
      required this.totalResults,
      required final List<Recipe> recipes})
      : _recipes = recipes;

  factory _$_QueryResult.fromJson(Map<String, dynamic> json) =>
      _$$_QueryResultFromJson(json);

  @override
  final int offset;
  @override
  final int number;
  @override
  final int totalResults;
  final List<Recipe> _recipes;
  @override
  List<Recipe> get recipes {
    if (_recipes is EqualUnmodifiableListView) return _recipes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipes);
  }

  @override
  String toString() {
    return 'QueryResult(offset: $offset, number: $number, totalResults: $totalResults, recipes: $recipes)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QueryResult &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.totalResults, totalResults) ||
                other.totalResults == totalResults) &&
            const DeepCollectionEquality().equals(other._recipes, _recipes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, offset, number, totalResults,
      const DeepCollectionEquality().hash(_recipes));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QueryResultCopyWith<_$_QueryResult> get copyWith =>
      __$$_QueryResultCopyWithImpl<_$_QueryResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_QueryResultToJson(
      this,
    );
  }
}

abstract class _QueryResult implements QueryResult {
  const factory _QueryResult(
      {required final int offset,
      required final int number,
      required final int totalResults,
      required final List<Recipe> recipes}) = _$_QueryResult;

  factory _QueryResult.fromJson(Map<String, dynamic> json) =
      _$_QueryResult.fromJson;

  @override
  int get offset;
  @override
  int get number;
  @override
  int get totalResults;
  @override
  List<Recipe> get recipes;
  @override
  @JsonKey(ignore: true)
  _$$_QueryResultCopyWith<_$_QueryResult> get copyWith =>
      throw _privateConstructorUsedError;
}
