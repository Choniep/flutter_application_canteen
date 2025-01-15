import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/models/cart_item.dart';
import 'package:flutter_application_canteen/models/food.dart';
import 'package:intl/intl.dart';

class Restaurant extends ChangeNotifier {
  // list of food menu
  final List<Food> _menu = [
    // burgers
    Food(
      name: "Beef Burger",
      description: "Very fresh beef burger, halal burger",
      imagePath: "lib/images/burgers/chicken_burger.jpeg",
      price: 20000,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(
          name: "Extra Cheese",
          price: 5000,
        ),
      ],
    ),
    Food(
      name: "Cheese Burger",
      description: "whooper jr chicken cheese burger",
      imagePath: "lib/images/burgers/cheese_burger.webp",
      price: 20000,
      category: FoodCategory.burgers,
      availableAddons: [
        Addon(name: "extra cheese", price: 5000),
      ],
    ),

    // salads
    Food(
      name: "Beef Salad",
      description: "Salad dengan toping daging segar",
      imagePath: "lib/images/salads/beef_salad.jpeg",
      price: 15000,
      category: FoodCategory.salads,
      availableAddons: [
        Addon(name: "mayonaise", price: 5000),
      ],
    ),

    // sides
    Food(
      name: "Jasuke",
      description: "Jagung, susu, keju",
      imagePath: "lib/images/sides/corn_soup.jpeg",
      price: 10000,
      category: FoodCategory.sides,
      availableAddons: [
        Addon(name: "Extra jagung", price: 3000),
      ],
    ),

    // dessert
    Food(
      name: "Sour Sally",
      description: "Es krim cone sour sally",
      imagePath: "lib/images/dessert/sour_sally.jpeg",
      price: 20000,
      category: FoodCategory.desserts,
      availableAddons: [
        Addon(name: "extra strawberry", price: 10000),
      ],
    ),

    // drinks
    Food(
      name: "Cappucino",
      description: "Kopi cappucino",
      imagePath: "lib/images/drinks/cappucino_coffee.jpeg",
      price: 8000,
      category: FoodCategory.drinks,
      availableAddons: [
        Addon(name: "dual shot", price: 8000),
      ],
    ),
  ];

  // user cart
  final List<CartItem> _cart = [];

  // delivery address (which user can change/update)
  String _deliveryAddress = '99 Hollywood Blv';

  /* 
  
  GETTERS
  
  */

  List<Food> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  /* 
  
  OPERATIONS
  
  */

  // add to cart
  void addToCart(Food food, List<Addon> selectedAddons) {
    // see if there is a cart item already with the same food and selected addons
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      // check if the food items are the same
      bool isSameFood = item.food == food;

      // check if the list of selected addons are the same
      bool isSameAddons =
          ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameFood && isSameAddons;
    });

    // if item already exists, increase it's quantity
    if (cartItem != null) {
      cartItem.quantity++;
    }

    // otherwise, add a new cart item to the cart
    else {
      _cart.add(
        CartItem(
          food: food,
          selectedAddons: selectedAddons,
        ),
      );
    }
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }

    notifyListeners();
  }

  // get total price of cart
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;

      for (Addon addon in cartItem.selectedAddons) {
        itemTotal += addon.price;
      }

      total += itemTotal * cartItem.quantity;
    }

    return total;
  }

  // get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;

    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }

    return totalItemCount;
  }

  // clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  // update delivery address
  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }
  /* 
  
  HELPERS
  
  */

  // generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt.");
    receipt.writeln();

    // format the date to include up to seconds only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("-----------");

    for (final cartItem in _cart) {
      receipt.writeln(
          "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}");
      if (cartItem.selectedAddons.isNotEmpty) {
        receipt
            .writeln("   Add-ons: ${_foramtAddons(cartItem.selectedAddons)}");
      }
      receipt.writeln();
    }

    receipt.writeln("----------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivering to: $deliveryAddress");

    return receipt.toString();
  }

  // format double value into money
  // beda dari tutorial
  String _formatPrice(double price) {
    return "Rp" + price.toString();
  }

  // format list of addons into a string summary
  String _foramtAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }
}
