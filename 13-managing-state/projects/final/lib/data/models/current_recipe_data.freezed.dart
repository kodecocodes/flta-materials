// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_recipe_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CurrentRecipeData {
  List<Recipe> get currentRecipes => throw _privateConstructorUsedError;
  List<Ingredient> get currentIngredients => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CurrentRecipeDataCopyWith<CurrentRecipeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrentRecipeDataCopyWith<$Res> {
  factory $CurrentRecipeDataCopyWith(
          CurrentRecipeData value, $Res Function(CurrentRecipeData) then) =
      _$CurrentRecipeDataCopyWithImpl<$Res, CurrentRecipeData>;
  @useResult
  $Res call({List<Recipe> currentRecipes, List<Ingredient> currentIngredients});
}

/// @nodoc
class _$CurrentRecipeDataCopyWithImpl<$Res, $Val extends CurrentRecipeData>
    implements $CurrentRecipeDataCopyWith<$Res> {
  _$CurrentRecipeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentRecipes = null,
    Object? currentIngredients = null,
  }) {
    return _then(_value.copyWith(
      currentRecipes: null == currentRecipes
          ? _value.currentRecipes
          : currentRecipes // ignore: cast_nullable_to_non_nullable
              as List<Recipe>,
      currentIngredients: null == currentIngredients
          ? _value.currentIngredients
          : currentIngredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CurrentRecipeDataCopyWith<$Res>
    implements $CurrentRecipeDataCopyWith<$Res> {
  factory _$$_CurrentRecipeDataCopyWith(_$_CurrentRecipeData value,
          $Res Function(_$_CurrentRecipeData) then) =
      __$$_CurrentRecipeDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Recipe> currentRecipes, List<Ingredient> currentIngredients});
}

/// @nodoc
class __$$_CurrentRecipeDataCopyWithImpl<$Res>
    extends _$CurrentRecipeDataCopyWithImpl<$Res, _$_CurrentRecipeData>
    implements _$$_CurrentRecipeDataCopyWith<$Res> {
  __$$_CurrentRecipeDataCopyWithImpl(
      _$_CurrentRecipeData _value, $Res Function(_$_CurrentRecipeData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentRecipes = null,
    Object? currentIngredients = null,
  }) {
    return _then(_$_CurrentRecipeData(
      currentRecipes: null == currentRecipes
          ? _value._currentRecipes
          : currentRecipes // ignore: cast_nullable_to_non_nullable
              as List<Recipe>,
      currentIngredients: null == currentIngredients
          ? _value._currentIngredients
          : currentIngredients // ignore: cast_nullable_to_non_nullable
              as List<Ingredient>,
    ));
  }
}

/// @nodoc

class _$_CurrentRecipeData implements _CurrentRecipeData {
  const _$_CurrentRecipeData(
      {final List<Recipe> currentRecipes = const <Recipe>[],
      final List<Ingredient> currentIngredients = const <Ingredient>[]})
      : _currentRecipes = currentRecipes,
        _currentIngredients = currentIngredients;

  final List<Recipe> _currentRecipes;
  @override
  @JsonKey()
  List<Recipe> get currentRecipes {
    if (_currentRecipes is EqualUnmodifiableListView) return _currentRecipes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentRecipes);
  }

  final List<Ingredient> _currentIngredients;
  @override
  @JsonKey()
  List<Ingredient> get currentIngredients {
    if (_currentIngredients is EqualUnmodifiableListView)
      return _currentIngredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentIngredients);
  }

  @override
  String toString() {
    return 'CurrentRecipeData(currentRecipes: $currentRecipes, currentIngredients: $currentIngredients)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CurrentRecipeData &&
            const DeepCollectionEquality()
                .equals(other._currentRecipes, _currentRecipes) &&
            const DeepCollectionEquality()
                .equals(other._currentIngredients, _currentIngredients));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_currentRecipes),
      const DeepCollectionEquality().hash(_currentIngredients));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CurrentRecipeDataCopyWith<_$_CurrentRecipeData> get copyWith =>
      __$$_CurrentRecipeDataCopyWithImpl<_$_CurrentRecipeData>(
          this, _$identity);
}

abstract class _CurrentRecipeData implements CurrentRecipeData {
  const factory _CurrentRecipeData(
      {final List<Recipe> currentRecipes,
      final List<Ingredient> currentIngredients}) = _$_CurrentRecipeData;

  @override
  List<Recipe> get currentRecipes;
  @override
  List<Ingredient> get currentIngredients;
  @override
  @JsonKey(ignore: true)
  _$$_CurrentRecipeDataCopyWith<_$_CurrentRecipeData> get copyWith =>
      throw _privateConstructorUsedError;
}
