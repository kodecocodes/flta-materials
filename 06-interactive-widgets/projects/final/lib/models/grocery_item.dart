import 'package:flutter/painting.dart';

// 1
enum Importance { low, medium, high }

class GroceryItem {
  // 2
  final String id;
  // 3
  final String name;
  final Importance importance;
  final Color color;
  final int quantity;
  final DateTime date;
  final bool isComplete;

  GroceryItem(
      {this.id,
      this.name,
      this.importance,
      this.color,
      this.quantity,
      this.date,
      this.isComplete = false});

  // 4
  GroceryItem copyWith(
      {String id,
      String name,
      Importance importance,
      Color color,
      int quantity,
      DateTime date,
      bool isComplete}) {
    return GroceryItem(
        id: id ?? this.id,
        name: name ?? this.name,
        importance: importance ?? this.importance,
        color: color ?? this.color,
        quantity: quantity ?? this.quantity,
        date: date ?? this.date,
        isComplete: isComplete ?? this.isComplete);
  }
}