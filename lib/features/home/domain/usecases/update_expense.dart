import 'package:expense_tracker/core/common/error/failures.dart';
import 'package:expense_tracker/core/common/usecase/usecase.dart';
import 'package:expense_tracker/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateExpense implements UseCase<void, UpdateExpenseParams> {
  final HomeRepository homeRepository;

  UpdateExpense(this.homeRepository);

  @override
  Future<Either<Failure, void>> call(UpdateExpenseParams params) async {
    return await homeRepository.updateExpense(
      expenseId: params.expenseId,
      amount: params.amount,
      categoryId: params.categoryId,
      description: params.description,
      date: params.date,
    );
  }
}

class UpdateExpenseParams {
  final String expenseId;
  final double amount;
  final int categoryId;
  final String description;
  final DateTime date;

  UpdateExpenseParams({
    required this.expenseId,
    required this.amount,
    required this.categoryId,
    required this.description,
    required this.date,
  });
}
