import 'package:expense_tracker/core/common/error/failures.dart';
import 'package:expense_tracker/core/common/usecase/usecase.dart';
import 'package:expense_tracker/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';


class AddExpense implements UseCase<void, AddExpenseParams> {
  final HomeRepository homeRepository;

  AddExpense(this.homeRepository);
  @override
  Future<Either<Failure, void>> call(AddExpenseParams params) async {
    return await homeRepository.addExpense(
      userId: params.userId,
      amount: params.amount,
      categoryId: params.categoryId,
      description: params.description,
      date: params.date,
    );
  }
}

class AddExpenseParams {
  final String userId;
  final double amount;
  final int categoryId;
  final String description;
  final DateTime date;

  AddExpenseParams({
    required this.userId,
    required this.amount,
    required this.categoryId,
    required this.description,
    required this.date,
  });
}
