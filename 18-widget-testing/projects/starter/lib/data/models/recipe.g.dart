// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Recipe _$$_RecipeFromJson(Map<String, dynamic> json) => _$_Recipe(
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

Map<String, dynamic> _$$_RecipeToJson(_$_Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'image': instance.image,
      'description': instance.description,
      'bookmarked': instance.bookmarked,
      'ingredients': instance.ingredients,
    };
