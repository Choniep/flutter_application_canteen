// Model for menu

import 'package:flutter_application_canteen/models/add_on.dart';

class MenuItem {
  final String id;
  final String standId;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final List<AddOn> addOns;

  MenuItem({
    required this.id,
    required this.standId,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.addOns,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stanId': standId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'addOns': addOns.map((addon) => addon.toMap()).toList(),
    };
  }
}
