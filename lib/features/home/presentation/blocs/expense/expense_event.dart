part of 'expense_bloc.dart';

@immutable
sealed class ExpenseEvent {}

final class AddExpenseEvent extends ExpenseEvent {
  final String userId;
  final double amount;
  final int categoryId;
  final String description;
  final DateTime date;

  AddExpenseEvent({
    required this.userId,
    required this.amount,
    required this.categoryId,
    required this.description,
    required this.date,
  });
}

final class UpdateExpenseEvent extends ExpenseEvent {
  final String expenseId;
  final double amount;
  final int categoryId;
  final String description;
  final DateTime date;

  UpdateExpenseEvent({
    required this.expenseId,
    required this.amount,
    required this.categoryId,
    required this.description,
    required this.date,
  });
}

final class DeleteExpenseEvent extends ExpenseEvent {
  final String expenseId;

  DeleteExpenseEvent({
    required this.expenseId,
  });
}

final class FetchExpenseEvent extends ExpenseEvent {
  final String userId;

  FetchExpenseEvent({
    required this.userId,
  });
}
