import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/core/utils/date.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  final double balance;
  final double spent;
  final DateTime date;

  final VoidCallback leftButtonAction;
  final VoidCallback rightButtonAction;

  const SummaryCard({
    super.key,
    required this.balance,
    required this.spent,
    required this.date,
    required this.leftButtonAction,
    required this.rightButtonAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            ColorPallette.primary,
            ColorPallette.primaryShade1,
          ],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(
              Icons.arrow_circle_left_outlined,
              size: 34,
              color: ColorPallette.primaryShade3,
            ),
            onPressed: leftButtonAction,
          ),
          Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.account_balance_outlined,
                    size: 24,
                    color: ColorPallette.greyShade4,
                  ),
                  const Icon(
                    Icons.currency_rupee_sharp,
                    size: 24,
                    color: ColorPallette.primaryShade3,
                  ),
                  Text(
                    balance.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ColorPallette.primaryShade3,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add_rounded,
                      size: 30,
                      color: ColorPallette.greyShade4,
                    ),
                  )
                ],
              ),
              const Text(
                'Balance',
                style: TextStyle(
                  color: ColorPallette.primaryShade3,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                Date.convertDate(date, 'MMMM yyyy'),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: ColorPallette.primaryShade3,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.currency_rupee_sharp,
                    size: 22,
                    color: ColorPallette.primaryShade3,
                  ),
                  Text(
                    spent.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: ColorPallette.primaryShade3,
                    ),
                  ),
                ],
              ),
              const Text(
                'Spent',
                style: TextStyle(
                  color: ColorPallette.primaryShade3,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_circle_right_outlined,
              size: 34,
              color: (Date.isInSameMonth(DateTime.now(), date))
                  ? ColorPallette.greyShade2
                  : ColorPallette.primaryShade3,
            ),
            onPressed: (Date.isInSameMonth(DateTime.now(), date))
                ? null
                : rightButtonAction,
          ),
        ],
      ),
    );
  }
}
