import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sakeena/features/guest_portion/cart/model/cart_item_model.dart';

class CartProvider with ChangeNotifier {
  // Mock login tracking variable configuration setup
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  // Mock static item tracking container list matches image_4fb742.png exactly
  final List<CartItem> _items = [
   
  ];

void addItem(CartItem item){
  _items.add(item);
  notifyListeners();
}

  List<CartItem> get items => [..._items];

  // Logic to calculate exact subtotal pricing matrices
  double get subtotal => _items.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  double get totalAmount => subtotal; // Expandable if you implement dynamic taxes/shipping late

  // Toggle state helper for testing authentication environments
  void toggleLoginStatus() {
    _isLoggedIn = !_isLoggedIn;
    notifyListeners();
  }

  // Handle dynamic checkout actions safely
  void handleCheckoutAction(BuildContext context) {
    if (_isLoggedIn) {
      // Proceed down to shipping/payment routes
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Navigating cleanly to checkout pipeline...")),
      );
    } else {
      // Trigger modal sheet or authentication route redirect structures
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Authentication needed. Redirecting to login...")),
      );
    }
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}