import 'package:expense_tracker/core/common/error/failures.dart';
import 'package:expense_tracker/features/home/domain/entities/balance.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, void>> addExpense({
    required String userId,
    required double amount,
    required int categoryId,
    required String description,
    required DateTime date,
  });

  Future<Either<Failure, List<Expense>>> getExpenses({
    required String userId,
  });

  Future<Either<Failure, void>> updateExpense({
    required String expenseId,
    required double amount,
    required int categoryId,
    required String description,
    required DateTime date,
  });

  Future<Either<Failure, void>> deleteExpense({
    required String expenseId,
  });

  Future<Either<Failure, void>> updateBalance({
    required String balanceId,
    required double balance,
  });

  Future<Either<Failure, Balance>> getBalance({
    required String userId,
  });
}
