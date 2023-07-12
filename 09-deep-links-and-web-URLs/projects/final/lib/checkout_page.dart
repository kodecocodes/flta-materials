import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text("Delivery"),
    1: Text("Self Pick-Up")
  };

  int sharedValue = 0;
  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  final DateTime _firstDate = DateTime(DateTime.now().year - 2);
  final DateTime _lastDate = DateTime(DateTime.now().year + 1);

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
            context: context,
            initialEntryMode: TimePickerEntryMode.input,
            initialTime: selectedTime ?? TimeOfDay.now(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  alwaysUse24HourFormat: true,
                ),
                child: child!,
              );
            },
          );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Handle delete action
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CupertinoSlidingSegmentedControl<int>(
              children: myTabs,
              onValueChanged: (newValue) {

              },
              groupValue: sharedValue,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Contact Name",
              ),
            ),
            Row(
              children: [
                TextButton(
                  child: Text('Select Date'),
                  onPressed: () => _selectDate(context),
                ),
                TextButton(
                  child: Text('Select Time'),
                  onPressed: () => _selectTime(context),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 20, // Number of items in the order summary
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          child: Image.asset('assets/categories/burger.png'),
                        ),
                    title: Text('Item description'),
                    subtitle: Text('Quantity: 1\nPrice: \$10'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle submit action
              },
              child: Text('Submit Order'),
            ),
          ],
        ),
      ),
    );
  }
}
