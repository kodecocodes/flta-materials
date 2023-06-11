import 'package:json_annotation/json_annotation.dart';
import '../data/models/models.dart';

part 'query_result.g.dart';

@JsonSerializable()
class QueryResult {
  factory QueryResult.fromJson(Map<String, dynamic> json) =>
      _$QueryResultFromJson(json);

  Map<String, dynamic> toJson() => _$QueryResultToJson(this);
  int offset;
  int number;
  int totalResults;
  List<Recipe> recipes;

  QueryResult({
    required this.offset,
    required this.number,
    required this.totalResults,
    required this.recipes,
  });
}
