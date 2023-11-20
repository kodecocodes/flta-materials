class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  double get totalCost => price * quantity;
}

enum DeliveryMode { delivery, pickup }

class CartManager {
  final List<CartItem> _items = [];
  DeliveryMode _mode = DeliveryMode.pickup;
  DateTime? _timeOfPickupOrDelivery;

  // Add a new item to the cart
  void addItem(CartItem item) {
    _items.add(item);
  }

  // Remove an item from the cart by its id
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  // Reset the shopping cart
  void resetCart() {
    _items.clear();
    _mode = DeliveryMode.pickup;
    _timeOfPickupOrDelivery = null;
  }

  // Retrieve the item for a specific index.
  CartItem itemAt(int index) {
    if (index >= 0 && index < _items.length) {
      return _items[index];
    } else {
      throw IndexError.withLength(index, _items.length);
    }
  }

  // Calculate the total cost of the cart
  double get totalCost {
    return _items.fold(0.0, (sum, item) => sum + item.totalCost);
  }

  // Get list of items in the cart
  List<CartItem> get items => List.unmodifiable(_items);

  // Check if the cart is empty.
  bool get isEmpty => _items.isEmpty;

  // Set delivery or pickup mode
  void setMode(DeliveryMode mode) {
    _mode = mode;
  }

  // Get current mode (Delivery or Pickup)
  DeliveryMode get mode => _mode;

  // Set time for pickup or delivery
  void setTime(DateTime time) {
    _timeOfPickupOrDelivery = time;
  }

  // Get time of pickup or delivery
  DateTime? get time => _timeOfPickupOrDelivery;
}
