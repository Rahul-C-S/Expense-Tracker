import 'package:expense_tracker/features/home/domain/entities/expense.dart';

class ExpenseModel extends Expense {
  ExpenseModel({
    required super.expenseId,
    required super.amount,
    required super.categoryId,
    required super.description,
    required super.date,
  });


  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      expenseId: map['expenseId'] as String,
      amount: map['amount'] as double,
      categoryId: map['categoryId'] as int,
      description: map['description'] as String,
      date: map['date'] as String,
    );
  }

}
