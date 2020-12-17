import 'package:flutter/painting.dart';

enum Importance { low, medium, high }

class GroceryItem {
  final String id;
  final String title;
  final Importance importance;
  final Color color;
  final int quantity;
  final DateTime date;
  final bool isComplete;

  GroceryItem(
      {this.id,
      this.title,
      this.importance,
      this.color,
      this.quantity,
      this.date,
      this.isComplete = false});

  GroceryItem copyWith(
      {String id,
      String title,
      Importance importance,
      Color color,
      int quantity,
      DateTime date,
      bool isComplete}) {
    return GroceryItem(
        id: id ?? this.id,
        title: title ?? this.title,
        importance: importance ?? this.importance,
        color: color ?? this.color,
        quantity: quantity ?? this.quantity,
        date: date ?? this.date,
        isComplete: isComplete ?? this.isComplete);
  }
}
