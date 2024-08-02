import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/domain/usecases/add_expense.dart';
import 'package:expense_tracker/features/home/domain/usecases/delete_expense.dart';
import 'package:expense_tracker/features/home/domain/usecases/fetch_expenses.dart';
import 'package:expense_tracker/features/home/domain/usecases/update_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final AddExpense _addExpense;
  final DeleteExpense _deleteExpense;
  final FetchExpenses _fetchExpenses;
  final UpdateExpense _updateExpense;

  ExpenseBloc({
    required AddExpense addExpense,
    required DeleteExpense deleteExpense,
    required FetchExpenses fetchExpenses,
    required UpdateExpense updateExpense,
  })  : _addExpense = addExpense,
        _deleteExpense = deleteExpense,
        _fetchExpenses = fetchExpenses,
        _updateExpense = updateExpense,
        super(ExpenseInitial()) {
    on<ExpenseEvent>((event, emit) {
      emit(ExpenseLoading());
    });
    on<AddExpenseEvent>(_onAddExpenseEvent);
    on<UpdateExpenseEvent>(_onUpdateExpenseEvent);
    on<DeleteExpenseEvent>(_onDeleteExpenseEvent);
    on<FetchExpenseEvent>(_onFetchExpenseEvent);
  }

  void _onAddExpenseEvent(
    AddExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final res = await _addExpense(
      AddExpenseParams(
        userId: event.userId,
        amount: event.amount,
        categoryId: event.categoryId,
        description: event.description,
        date: event.date,
      ),
    );

    res.fold(
      (l) => emit(ExpenseFailure(l.message)),
      (r) => emit(ExpenseAddSuccess()),
    );
  }

  void _onUpdateExpenseEvent(
    UpdateExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final res = await _updateExpense(
      UpdateExpenseParams(
        expenseId: event.expenseId,
        amount: event.amount,
        categoryId: event.categoryId,
        description: event.description,
        date: event.date,
      ),
    );
    res.fold(
      (l) => emit(ExpenseFailure(l.message)),
      (r) => emit(ExpenseUpdateSuccess()),
    );
  }

  void _onDeleteExpenseEvent(
    DeleteExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final res = await _deleteExpense(
      DeleteExpenseParams(
        event.expenseId,
      ),
    );
    res.fold(
      (l) => emit(ExpenseFailure(l.message)),
      (r) => emit(ExpenseDeleteSuccess()),
    );
  }

  void _onFetchExpenseEvent(
    FetchExpenseEvent event,
    Emitter<ExpenseState> emit,
  ) async {
    final res = await _fetchExpenses(
      FetchExpensesParams(
        userId: event.userId,
      ),
    );
    res.fold(
      (l) => emit(ExpenseFailure(l.message)),
      (r) => emit(ExpensesFetchSuccess(r)),
    );
  }
}
