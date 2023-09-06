import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
        id: 'p1',
        title: 'Red Shirt',
        description: 'A red shirt - it is pretty red!',
        price: 29.99,
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzOnIhvgPSRGEwOQt0Wzrb2-JFzzF-WRCWpBEB3m3rWA&s'),
    Product(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 59.99,
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXgc2kPmLSBIIcIEEe0by_l_T6K4hanily0g&usqp=CAU'),
    Product(
        id: 'p3',
        title: 'Yellow Scart',
        description: 'Warm and cozy - exactly what you need for Winter.',
        price: 19.99,
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxOL4CBP_vlgqGFNybhmbNDHTLvqdFOp6PsMY9JpYTK0isgeo955VE1vLQTyXvNQMLc_4&usqp=CAU'),
    Product(
        id: 'p4',
        title: 'A Pan',
        description: 'Prepare any meal you want.',
        price: 43.99,
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYaLJj4pz-5Z2lFyr4djEaXczcpEaRkOFCSVNseuVAl_q3sTWm0ykssK6HFQ6t0MiaGaw&usqp=CAU'),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  List<Product> get filterFavorites {
    return _items.where((product) => product.isFavorite).toList();
  }
}
