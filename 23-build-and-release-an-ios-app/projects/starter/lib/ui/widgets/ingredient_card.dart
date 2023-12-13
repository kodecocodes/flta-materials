import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/colors.dart';

typedef OnChecked = void Function(bool);

class IngredientCard extends ConsumerStatefulWidget {
  final String name;
  final bool initiallyChecked;
  final bool evenRow;
  final bool showCheckbox;
  final OnChecked onChecked;

  const IngredientCard({
    Key? key,
    required this.name,
    required this.initiallyChecked,
    required this.evenRow,
    this.showCheckbox = true,
    required this.onChecked,
  }) : super(key: key);

  @override
  ConsumerState<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends ConsumerState<IngredientCard> {
  bool checked = false;

  @override
  void initState() {
    super.initState();
    checked = widget.initiallyChecked;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final evenSelectedColor =
        isDarkMode ? darkBackgroundColor : smallCardBackgroundColor;
    final oddSelectedColor = isDarkMode ? darkBackgroundColor : Colors.white;
    final side = !widget.evenRow
        ? const BorderSide(
            color: Colors.black,
            width: 1.0,
          )
        : BorderSide.none;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: side,
      ),
      color: widget.evenRow ? evenSelectedColor : oddSelectedColor,
      child: _buildTile(),
    );
  }

  Widget _buildTile() {
    if (widget.showCheckbox) {
      return CheckboxListTile(
        value: checked,
        title: Text(
          widget.name,
          style: TextStyle(
              decoration:
                  checked ? TextDecoration.lineThrough : TextDecoration.none),
        ),
        onChanged: (newValue) {
          if (newValue != null) {
            setState(() {
              checked = newValue;
              widget.onChecked(newValue);
            });
          }
        },
      );
    } else {
      return ListTile(
        title: Text(
          widget.name,
          style: TextStyle(
              decoration:
                  checked ? TextDecoration.lineThrough : TextDecoration.none),
        ),
      );
    }
  }
}
