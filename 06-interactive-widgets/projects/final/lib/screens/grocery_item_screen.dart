/*
 * Copyright (c) 2020 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../models/models.dart';
import '../components/grocery_tile.dart';

class GroceryItemScreen extends StatefulWidget {
  // 1
  final Function(GroceryItem) onCreate;
  // 2
  final Function(GroceryItem) onUpdate;
  // 3
  final GroceryItem originalItem;
  // 4
  final bool isUpdating;

  const GroceryItemScreen(
      {Key key, this.onCreate, this.onUpdate, this.originalItem})
      : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
 
  var _nameController = TextEditingController();
  String _name = "";
  Importance _importance = Importance.low;
  DateTime _dueDate = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Color _currentColor = Colors.green;
  int _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    // 1
    return Scaffold(
      // 2
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                // 1
                var groceryItem = GroceryItem(
                    id: widget.originalItem?.id ?? Uuid().v1(),
                    name: _nameController.text,
                    importance: _importance,
                    color: _currentColor,
                    quantity: _currentSliderValue,
                    date: DateTime(_dueDate.year, _dueDate.month,
                        _dueDate.day, _timeOfDay.hour, _timeOfDay.minute));
                      
                if (widget.isUpdating) {
                  // 2
                  widget.onUpdate(groceryItem);
                } else {
                  // 3
                  widget.onCreate(groceryItem);
                }
              })
        ],
        // 3
        elevation: 0.0,
        // 4
        title: Text("Grocery Item",
            style: GoogleFonts.lato(fontWeight: FontWeight.w600))),
      // 5
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDateField(context),
            buildTimeField(context),
            SizedBox(height: 10),
            buildColorPicker(context),
            SizedBox(height: 10),
            buildQuantityField(),
            SizedBox(height: 16),
            GroceryTile(
              item: GroceryItem(
                name: _name,
                importance: _importance,
                color: _currentColor,
                quantity: _currentSliderValue,
                date: DateTime(_dueDate.year, _dueDate.month, _dueDate.day,
                    _timeOfDay.hour, _timeOfDay.minute)))
          ])),
      );
  }

  buildNameField() {
    // 1
    return Column(
      // 2
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        // 3
        Text("Item Name", style: GoogleFonts.lato(fontSize: 28)),
        // 4
        TextField(
          // 5
          controller: _nameController,
          // 6
          cursorColor: _currentColor,
          // 7
          decoration: InputDecoration(
            // 8
            hintText: "E.g. Apples, Banana, 1 Bag of salt",
            // 9
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _currentColor)),
            border: UnderlineInputBorder(
                borderSide: BorderSide(color: _currentColor)),
          ))
    ]);
  }

  buildImportanceField() {
    // 1
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        // 2
        Text("Importance", style: GoogleFonts.lato(fontSize: 28)),
        // 3
        Wrap(
          spacing: 10, 
          children: [
            // 4
            ChoiceChip(
              // 5
              selectedColor: Colors.black,
              // 6
              selected: _importance == Importance.low,
              label: Text("low", style: TextStyle(color: Colors.white)),
              // 7
              onSelected: (selected) {
                setState(() => _importance = Importance.low);
              }),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.medium,
              label: Text("medium", style: TextStyle(color: Colors.white)),
              onSelected: (selected) {
                setState(() => _importance = Importance.medium);
              }),
            ChoiceChip(
              selectedColor: Colors.black,
              selected: _importance == Importance.high,
              label: Text("high", style: TextStyle(color: Colors.white)),
              onSelected: (selected) {
                setState(() => _importance = Importance.high);
              }),
          ])
      ]);
  }

  buildDateField(BuildContext context) {
    // 1
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        // 2
        Row(
          // 3
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
            // 4
            Text("Date", style: GoogleFonts.lato(fontSize: 28)),
            // 5
            FlatButton(
              child: const Text('Select'),
              // 6
              onPressed: () async {
                DateTime currentDate = DateTime.now();
                // 7
                DateTime selectedDate = await showDatePicker(
                  context: context,
                  initialDate: currentDate,
                  firstDate: currentDate,
                  lastDate: DateTime(currentDate.year + 5),
                );

                // 8
                setState(() {
                  if (selectedDate != null) {
                    _dueDate = selectedDate;
                  }
                });
            }),
          ]),
        // 9
        if (_dueDate != null)
        Text("${DateFormat('yyyy-MM-dd').format(_dueDate)}")
    ]);
  }

  buildTimeField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
          Text("Time of Day", style: GoogleFonts.lato(fontSize: 28)),
          FlatButton(
            child: const Text('Select'),
            onPressed: () async {
              // 1
              TimeOfDay timeOfDay = await showTimePicker(
                // 2
                initialTime: TimeOfDay.now(),
                context: context,
              );

              // 3
              setState(() {
                if (timeOfDay != null) {
                  _timeOfDay = timeOfDay;
                }
              });
            }),
        ]),
      if (_timeOfDay != null)
      Text("${_timeOfDay.format(context)}")
    ]);
  }

  buildColorPicker(BuildContext context) {
    // 1
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, 
      children: [
        // 2
        Row(
          children: [
            Container(height: 50, width: 10, color: _currentColor),
            SizedBox(width: 8),
            Text("Color", style: GoogleFonts.lato(fontSize: 28)),
          ],
        ),
        // 3
        FlatButton(
            child: Text("Select"),
            onPressed: () {
              // 4
              showDialog(
                context: context,
                builder: (context) {
                  // 5
                  return AlertDialog(
                    content: BlockPicker(
                        pickerColor: Colors.white,
                        // 6
                        onColorChanged: (color) {
                          setState(() => _currentColor = color);
                        }),
                    actions: [
                      // 7
                      FlatButton(
                        child: const Text('Got it'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
              });
            })
    ]);
  }

  buildQuantityField() {
    // 1
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, 
      children: [
        // 2
        Text("Quantity", style: GoogleFonts.lato(fontSize: 28)),
        // 3
        Slider(
          // 4
          inactiveColor: _currentColor.withOpacity(0.5),
          activeColor: _currentColor,
          // 5
          value: _currentSliderValue.toDouble(),
          // 6
          min: 0,
          max: 100,
          // 7
          divisions: 100,
          // 8
          label: _currentSliderValue.toInt().toString(),
          // 9
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value.toInt();
            });
          },
        )
      ]);
  }

  @override
  void initState() {
    // 1
    if (widget.originalItem != null) {
      _nameController.text = widget.originalItem.name;
      _currentSliderValue = widget.originalItem.quantity;
      _importance = widget.originalItem.importance;
      _currentColor = widget.originalItem.color;
      var date = widget.originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    // 2
    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text; 
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

}