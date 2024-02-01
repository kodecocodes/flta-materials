// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_QueryResult _$$_QueryResultFromJson(Map<String, dynamic> json) =>
    _$_QueryResult(
      offset: json['offset'] as int,
      number: json['number'] as int,
      totalResults: json['totalResults'] as int,
      recipes: (json['recipes'] as List<dynamic>)
          .map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_QueryResultToJson(_$_QueryResult instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'number': instance.number,
      'totalResults': instance.totalResults,
      'recipes': instance.recipes,
    };
