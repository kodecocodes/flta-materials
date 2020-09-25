import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropdownMenuItem<T> extends PopupMenuEntry<T> {
  const CustomDropdownMenuItem({
    Key key,
    this.value,
    @required this.text,
  })  : assert(text != null),
        super(key: key);

  final T value;

  final String text;

  @override
  _CustomDropdownMenuItemState<T> createState() => _CustomDropdownMenuItemState<T>();

  @override
  double get height => 32.0;

  @override
  bool represents(T value) => this.value == value;
}

class _CustomDropdownMenuItemState<T> extends State<CustomDropdownMenuItem<T>> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop<T>(widget.value),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading:
            SvgPicture.asset(
                'assets/images/history.svg',
                color: Colors.grey ,
                semanticsLabel: 'Back'
            ),
          title: Text(
              widget.text,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          trailing: SvgPicture.asset(
                'assets/images/dismiss.svg',
                color: Colors.grey ,
                semanticsLabel: 'Back'
            ),
        ),
      ),
    );
  }
}