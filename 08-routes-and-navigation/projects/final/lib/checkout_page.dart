import 'package:flutter/material.dart';
import 'models/orders.dart';
import 'models/shopping_cart.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  final ShoppingCart shoppingCart;
  final Function() didUpdate;
  final Function(Order) onSubmit;

  const CheckoutPage(
      {super.key,
      required this.shoppingCart,
      required this.didUpdate,
      required this.onSubmit});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final Map<int, Widget> myTabs = const <int, Widget>{
    0: Text('Delivery'),
    1: Text('Self Pick-Up')
  };

  Set<int> selectedSegment = {0};
  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  final DateTime _firstDate = DateTime(DateTime.now().year - 2);
  final DateTime _lastDate = DateTime(DateTime.now().year + 1);
  final TextEditingController _nameController = TextEditingController();

  void _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
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

  String formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Select Date';
    }
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  void onSegmentSelected(Set<int> segmentIndex) {
    setState(() {
      selectedSegment = segmentIndex;
    });
  }

  Widget orderSegmentedType() {
    return SegmentedButton(
      showSelectedIcon: false,
      segments: const [
        ButtonSegment(
            value: 0, label: Text('Delivery'), icon: Icon(Icons.pedal_bike)),
        ButtonSegment(
            value: 1, label: Text('Pickup'), icon: Icon(Icons.local_mall)),
      ],
      selected: selectedSegment,
      onSelectionChanged: onSegmentSelected,
    );
  }

  void _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
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

  String formatTimeOfDay(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) {
      return 'Select Time';
    }
    final hour = timeOfDay.hour.toString().padLeft(2, '0');
    final minute = timeOfDay.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Widget orderSummary(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;

    return Expanded(
      child: ListView.builder(
        itemCount: widget
            .shoppingCart.items.length, // Number of items in the order summary
        itemBuilder: (context, index) {
          final item = widget.shoppingCart.itemAt(index);
          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(),
            secondaryBackground: const SizedBox(
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Icon(Icons.delete),
              ]),
            ),
            onDismissed: (direction) {
              setState(() {
                widget.shoppingCart.removeItem(item.id);
              });
              widget.didUpdate();
            },
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(
                    color: colorTheme.primary,
                    width: 2.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: Text('x${item.quantity}'),
                ),
              ),
              title: Text(item.name),
              subtitle: Text('Price: \$${item.price}'),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Order Details', style: textTheme.headlineSmall),
            const SizedBox(height: 16.0),
            orderSegmentedType(),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Contact Name',
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                TextButton(
                  child: Text(formatDate(selectedDate)),
                  onPressed: () => _selectDate(context),
                ),
                TextButton(
                  child: Text(formatTimeOfDay(selectedTime)),
                  onPressed: () => _selectTime(context),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Text('Order Summary', style: textTheme.bodyLarge),
            orderSummary(context),
            ElevatedButton(
              onPressed: widget.shoppingCart.isEmpty
                  ? null
                  : () {
                      final selectedSegment = this.selectedSegment;
                      final selectedTime = this.selectedTime;
                      final selectedDate = this.selectedDate;
                      final name = _nameController.text;
                      final items = widget.shoppingCart.items;

                      final order = Order(
                          selectedSegment: selectedSegment,
                          selectedTime: selectedTime,
                          selectedDate: selectedDate,
                          name: name,
                          items: items);

                      widget.shoppingCart.resetCart();
                      widget.onSubmit(order);
                    },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    '''Submit Order - \$${widget.shoppingCart.totalCost.toStringAsFixed(2)}'''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
