// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      id: json['id'] as int?,
      recipeId: json['recipeId'] as int?,
      name: json['name'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipeId': instance.recipeId,
      'name': instance.name,
      'amount': instance.amount,
      'weight': instance.weight,
    };
