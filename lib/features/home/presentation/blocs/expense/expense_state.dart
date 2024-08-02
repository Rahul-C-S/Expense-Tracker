part of 'expense_bloc.dart';

@immutable
sealed class ExpenseState {}

final class ExpenseInitial extends ExpenseState {}

final class ExpenseLoading extends ExpenseState {}

final class ExpenseAddSuccess extends ExpenseState {}

final class ExpenseDeleteSuccess extends ExpenseState {}

final class ExpenseUpdateSuccess extends ExpenseState {}

final class ExpensesFetchSuccess extends ExpenseState {
  final List<Expense> expenses;

  ExpensesFetchSuccess(this.expenses);
}

final class ExpenseFailure extends ExpenseState {
  final String error;

  ExpenseFailure(this.error);
}
