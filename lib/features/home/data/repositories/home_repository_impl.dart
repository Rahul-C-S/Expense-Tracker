import 'package:expense_tracker/core/common/error/exceptions.dart';
import 'package:expense_tracker/core/common/error/failures.dart';
import 'package:expense_tracker/features/home/data/datasources/home_remote_data_source.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl(this.homeRemoteDataSource);
  @override
  Future<Either<Failure, void>> addExpense({
    required String userId,
    required double amount,
    required int categoryId,
    required String description,
    required DateTime date,
  }) async {
    try {
      await homeRemoteDataSource.addExpense(
        userId: userId,
        amount: amount,
        categoryId: categoryId,
        description: description,
        date: date,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense(
      {required String expenseId}) async {
    try {
      await homeRemoteDataSource.deleteExpense(expenseId: expenseId);
      return right(null);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Expense>>> getExpenses(
      {required String userId}) async {
    try {
      final res = await homeRemoteDataSource.getExpenses(userId: userId);
      return right(res);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updateExpense(
      {required String expenseId,
      required double amount,
      required int categoryId,
      required String description,
      required DateTime date}) async {
    try {
      await homeRemoteDataSource.updateExpense(
        expenseId: expenseId,
        amount: amount,
        categoryId: categoryId,
        description: description,
        date: date,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(
        Failure(
          e.message,
        ),
      );
    }
  }
}
