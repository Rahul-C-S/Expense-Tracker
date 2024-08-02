import 'package:expense_tracker/core/common/models/category_model.dart';
import 'package:flutter/material.dart';

class Categories {
  static const List<Map<String, dynamic>> _list = [
    {
      'id': 0,
      'name': 'Shopping',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'id': 1,
      'name': 'Travel',
      'icon': Icons.directions_bus,
    },
    {
      'id': 2,
      'name': 'Fuel',
      'icon': Icons.local_gas_station_outlined,
    },
    {
      'id': 3,
      'name': 'Food',
      'icon': Icons.restaurant_outlined,
    },
    {
      'id': 4,
      'name': 'Installments',
      'icon': Icons.account_balance_outlined,
    },
    {
      'id': 5,
      'name': 'Health',
      'icon': Icons.health_and_safety_outlined,
    },
    {
      'id': 6,
      'name': 'Rent',
      'icon': Icons.location_city,
    },
    {
      'id': 7,
      'name': 'Bills',
      'icon': Icons.receipt_outlined,
    },
    {
      'id': 8,
      'name': 'Movie',
      'icon': Icons.movie_outlined,
    },
    {
      'id': 9,
      'name': 'Investment',
      'icon': Icons.currency_rupee_outlined,
    },
    {
      'id': 10,
      'name': 'Education',
      'icon': Icons.school_outlined,
    },
    {
      'id': 11,
      'name': 'Others',
      'icon': Icons.list_alt_outlined,
    },
  ];

  static List<CategoryModel> getCategories() {
    return _list
        .map((category) => CategoryModel(
              id: category['id'],
              name: category['name'],
              icon: category['icon'],
            ))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }
}
