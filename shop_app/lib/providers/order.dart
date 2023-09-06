import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime dateTime;
  final List<CartItem> cartProducts;

  OrderItem({
    required this.id,
    required this.amount,
    required this.dateTime,
    required this.cartProducts,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  addOrder(List<CartItem> cartProducts, double amount) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: amount,
        dateTime: DateTime.now(),
        cartProducts: cartProducts,
      ),
    );
  }
}
