import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../components/grocery_tile.dart';
import '../models/grocery_item.dart';

class GroceryItemScreen extends StatefulWidget {
  final Function(GroceryItem) onCreate;
  final Function(GroceryItem) onUpdate;
  final GroceryItem originalItem;
  final bool isUpdating;

  const GroceryItemScreen(
      {Key key, this.onCreate, this.onUpdate, this.originalItem})
      : isUpdating = (originalItem != null),
        super(key: key);

  @override
  _GroceryItemScreenState createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  int _currentSliderValue = 0;
  String _title = "Grocery Item";
  Importance _importance = Importance.low;
  Color _currentColor = Colors.green;
  TimeOfDay _timeOfDay = TimeOfDay.now();
  DateTime _dueDate = DateTime.now();

  GroceryItem updatedItem;

  @override
  void initState() {
    if (widget.originalItem != null) {
      _currentSliderValue = widget.originalItem.quantity;
      _title = widget.originalItem.title;
      _importance = widget.originalItem.importance;
      _currentColor = widget.originalItem.color;
      var date = widget.originalItem.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dueDate = date;
    }

    super.initState();
  }

  buildTitleField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("New Item", style: GoogleFonts.lato(fontSize: 28)),
      TextField(
          onChanged: (text) {
            setState(() => _title = text);
          },
          cursorColor: _currentColor,
          decoration: InputDecoration(
            hintText: "E.g. Apples, Banana, 1 Bag of salt",
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Importance", style: GoogleFonts.lato(fontSize: 28)),
      Wrap(spacing: 10, children: [
        InputChip(
            backgroundColor:
                _importance == Importance.low ? Colors.black : Colors.grey,
            label: Text("low", style: TextStyle(color: Colors.white)),
            onPressed: () {
              setState(() => _importance = Importance.low);
            }),
        InputChip(
            backgroundColor:
                _importance == Importance.medium ? Colors.black : Colors.grey,
            label: Text("medium", style: TextStyle(color: Colors.white)),
            onPressed: () {
              setState(() => _importance = Importance.medium);
            }),
        InputChip(
            backgroundColor:
                _importance == Importance.high ? Colors.black : Colors.grey,
            label: Text("high", style: TextStyle(color: Colors.white)),
            onPressed: () {
              setState(() => _importance = Importance.high);
            }),
      ])
    ]);
  }

  buildDateField(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Date", style: GoogleFonts.lato(fontSize: 28)),
        FlatButton(
          child: const Text('Select'),
          onPressed: () async {
            DateTime selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2025),
            );

            setState(() {
              _dueDate = selectedDate;
            });
          },
        ),
      ]),
      if (_dueDate != null)
        Text("${DateFormat('yyyy-MM-dd').format(_dueDate)}"),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text("Time of Day", style: GoogleFonts.lato(fontSize: 28)),
        FlatButton(
          child: const Text('Select'),
          onPressed: () async {
            TimeOfDay timeOfDay = await showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
            );

            setState(() {
              _timeOfDay = timeOfDay;
            });
          },
        ),
      ]),
      if (_timeOfDay != null)
        Text(
            "${_timeOfDay.hour}:${_timeOfDay.minute} ${_timeOfDay.period.index == 0 ? "AM" : "PM"}"),
    ]);
  }

  buildColorPicker(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("Color", style: GoogleFonts.lato(fontSize: 28)),
      FlatButton(
          child: Text("Select"),
          onPressed: () {
            showDialog(
                context: context,
                child: AlertDialog(
                  content: SingleChildScrollView(
                    child: BlockPicker(
                        pickerColor: Colors.white,
                        onColorChanged: (color) {
                          setState(() => _currentColor = color);
                        }),
                  ),
                  actions: [
                    FlatButton(
                      child: const Text('Got it'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
          })
    ]);
  }

  buildQuantityField() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Quantity", style: GoogleFonts.lato(fontSize: 28)),
      Slider(
        inactiveColor: _currentColor.withOpacity(0.5),
        activeColor: _currentColor,
        value: _currentSliderValue.toDouble(),
        min: 0,
        max: 100,
        divisions: 100,
        label: _currentSliderValue.toInt().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value.toInt();
          });
        },
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  var groceryItem = GroceryItem(
                      id: widget.originalItem?.id ?? Uuid().v1(),
                      title: _title,
                      importance: _importance,
                      color: _currentColor,
                      quantity: _currentSliderValue,
                      date: DateTime(_dueDate.year, _dueDate.month,
                          _dueDate.day, _timeOfDay.hour, _timeOfDay.minute));
                  if (widget.isUpdating) {
                    widget.onUpdate(groceryItem);
                  } else {
                    widget.onCreate(groceryItem);
                  }
                })
          ],
          elevation: 0.0,
          title: Text("Fooderlich",
              style: GoogleFonts.lato(fontWeight: FontWeight.w600))),
      body: Container(
          padding: EdgeInsets.all(16),
          child: ListView(children: [
            buildTitleField(),
            buildImportanceField(),
            buildDateField(context),
            buildColorPicker(context),
            buildQuantityField(),
            SizedBox(height: 16),
            GroceryTile(
                item: GroceryItem(
                    title: _title,
                    importance: _importance,
                    color: _currentColor,
                    quantity: _currentSliderValue,
                    date: DateTime(_dueDate.year, _dueDate.month, _dueDate.day,
                        _timeOfDay.hour, _timeOfDay.minute)))
          ])),
    );
  }
}
