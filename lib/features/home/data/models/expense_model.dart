import 'package:expense_tracker/features/home/domain/entities/expense.dart';

class ExpenseModel extends Expense {
  ExpenseModel({
    required super.expenseId,
    required super.amount,
    required super.categoryId,
    required super.description,
    required super.date,
  });


}
