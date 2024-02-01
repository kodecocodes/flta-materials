// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spoonacular_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpoonacularResults _$SpoonacularResultsFromJson(Map<String, dynamic> json) =>
    SpoonacularResults(
      results: (json['results'] as List<dynamic>)
          .map((e) => SpoonacularResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      offset: json['offset'] as int,
      number: json['number'] as int,
      totalResults: json['totalResults'] as int,
    );

Map<String, dynamic> _$SpoonacularResultsToJson(SpoonacularResults instance) =>
    <String, dynamic>{
      'results': instance.results,
      'offset': instance.offset,
      'number': instance.number,
      'totalResults': instance.totalResults,
    };

SpoonacularResult _$SpoonacularResultFromJson(Map<String, dynamic> json) =>
    SpoonacularResult(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      imageType: json['imageType'] as String,
    );

Map<String, dynamic> _$SpoonacularResultToJson(SpoonacularResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'imageType': instance.imageType,
    };

SpoonacularRecipe _$SpoonacularRecipeFromJson(Map<String, dynamic> json) =>
    SpoonacularRecipe(
      preparationMinutes: json['preparationMinutes'] as int,
      cookingMinutes: json['cookingMinutes'] as int,
      sourceName: json['sourceName'] as String,
      extendedIngredients: (json['extendedIngredients'] as List<dynamic>)
          .map((e) => ExtendedIngredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int,
      title: json['title'] as String,
      readyInMinutes: json['readyInMinutes'] as int,
      servings: json['servings'] as int,
      sourceUrl: json['sourceUrl'] as String,
      image: json['image'] as String,
      imageType: json['imageType'] as String,
      summary: json['summary'] as String,
      instructions: json['instructions'] as String?,
    );

Map<String, dynamic> _$SpoonacularRecipeToJson(SpoonacularRecipe instance) =>
    <String, dynamic>{
      'preparationMinutes': instance.preparationMinutes,
      'cookingMinutes': instance.cookingMinutes,
      'sourceName': instance.sourceName,
      'extendedIngredients': instance.extendedIngredients,
      'id': instance.id,
      'title': instance.title,
      'readyInMinutes': instance.readyInMinutes,
      'servings': instance.servings,
      'sourceUrl': instance.sourceUrl,
      'image': instance.image,
      'imageType': instance.imageType,
      'summary': instance.summary,
      'instructions': instance.instructions,
    };

ExtendedIngredient _$ExtendedIngredientFromJson(Map<String, dynamic> json) =>
    ExtendedIngredient(
      id: json['id'] as int,
      aisle: json['aisle'] as String?,
      image: json['image'] as String?,
      name: json['name'] as String,
      nameClean: json['nameClean'] as String?,
      original: json['original'] as String,
      originalName: json['originalName'] as String?,
      amount: (json['amount'] as num).toDouble(),
      unit: json['unit'] as String,
    );

Map<String, dynamic> _$ExtendedIngredientToJson(ExtendedIngredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'aisle': instance.aisle,
      'image': instance.image,
      'name': instance.name,
      'nameClean': instance.nameClean,
      'original': instance.original,
      'originalName': instance.originalName,
      'amount': instance.amount,
      'unit': instance.unit,
    };
