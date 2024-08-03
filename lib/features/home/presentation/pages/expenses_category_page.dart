import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/core/utils/alert.dart';
import 'package:expense_tracker/core/utils/date.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:flutter/material.dart';

class ExpensesCategoryPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Expense> expenses;
  final int index;
  const ExpensesCategoryPage({
    super.key,
    required this.title,
    required this.icon,
    required this.expenses,
    required this.index,
  });

  static void route({
    required String title,
    required IconData icon,
    required List<Expense> expenses,
    required int index,
    required BuildContext context,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExpensesCategoryPage(
            title: title,
            icon: icon,
            expenses: expenses,
            index: index,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: ((index + 1) % 2 == 0)
                    ? ColorPallette.warning
                    : ((index + 1) % 3 == 0)
                        ? ColorPallette.danger
                        : ColorPallette.success,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: ColorPallette.primaryShade1,
            thickness: 0.5,
          ),
          itemCount: expenses.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    Date.convertDate(
                      expenses[index].date,
                      'dd/MM/yyyy',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final textSpan = TextSpan(
                          text: expenses[index].description,
                          style: DefaultTextStyle.of(context).style,
                        );
                        final textPainter = TextPainter(
                          maxLines: 1,
                          textAlign: TextAlign.left,
                          textDirection: TextDirection.ltr,
                          text: textSpan,
                        )..layout(maxWidth: constraints.maxWidth);

                        final isOverflowing = textPainter.didExceedMaxLines;

                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                expenses[index].description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isOverflowing)
                              IconButton(
                                icon: const Icon(Icons.expand_more),
                                onPressed: () {
                                  Alert.showAlertDialog(
                                    context,
                                    title: 'Description',
                                    message: expenses[index].description,
                                    confirmButtonText: 'Close'
                                  );
                                },
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    '₹${expenses[index].amount}',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
