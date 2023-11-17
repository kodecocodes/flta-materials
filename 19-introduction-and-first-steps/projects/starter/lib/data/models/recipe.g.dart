// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeImpl _$$RecipeImplFromJson(Map<String, dynamic> json) => _$RecipeImpl(
      id: json['id'] as int?,
      label: json['label'] as String?,
      image: json['image'] as String?,
      description: json['description'] as String?,
      bookmarked: json['bookmarked'] as bool? ?? false,
      ingredients: (json['ingredients'] as List<dynamic>?)
              ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Ingredient>[],
    );

Map<String, dynamic> _$$RecipeImplToJson(_$RecipeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'image': instance.image,
      'description': instance.description,
      'bookmarked': instance.bookmarked,
      'ingredients': instance.ingredients,
    };
