import 'package:expense_tracker/core/common/error/failures.dart';
import 'package:expense_tracker/core/common/usecase/usecase.dart';
import 'package:expense_tracker/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteExpense implements UseCase<void, DeleteExpenseParams> {
  final HomeRepository homeRepository;

  DeleteExpense(this.homeRepository);

  @override
  Future<Either<Failure, void>> call(DeleteExpenseParams params) async {
    return await homeRepository.deleteExpense(expenseId: params.expenseId);
  }
}

class DeleteExpenseParams {
  final String expenseId;

  DeleteExpenseParams(this.expenseId);
}
