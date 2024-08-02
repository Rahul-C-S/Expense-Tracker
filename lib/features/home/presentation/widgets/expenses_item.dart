import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  final int id;
  final int index;
  final double total;
  final IconData icon;
  final String name;
  const ExpensesItem({
    super.key,
    required this.id,
    required this.index,
    required this.total,
    required this.icon,
    required this.name,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Icon(
            icon,
            color: ((index+1) % 2 == 0)
                ? ColorPallette.warning
                : ((index+1) % 3 == 0)
                    ? ColorPallette.danger
                    : ColorPallette.success,
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(name),
        ),
        Expanded(
          flex: 3,
          child: Text('₹${total.toString()}'),
        ),
      ],
    );
  }
}
