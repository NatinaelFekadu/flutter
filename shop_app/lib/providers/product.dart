import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavoriteStatus() async {
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.https(
        'flutter-5275a-default-rtdb.firebaseio.com', '/products/$id.json');
    try {
      final response = await http.patch(
        url,
        body: json.encode(
          {'isFavorite': isFavorite},
        ),
      );
      if (response.statusCode >= 400) {
        throw HttpException('Couldn\'t toggle the fav state');
      }
    } catch (error) {
      isFavorite = !isFavorite;
      notifyListeners();
      rethrow;
    }
  }
}
