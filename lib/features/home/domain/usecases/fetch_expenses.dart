import 'package:expense_tracker/core/common/error/failures.dart';
import 'package:expense_tracker/core/common/usecase/usecase.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';


class FetchExpenses implements UseCase<List<Expense>,FetchExpensesParams>{
  final HomeRepository homeRepository;

  FetchExpenses(this.homeRepository);

  @override
  Future<Either<Failure, List<Expense>>> call(FetchExpensesParams params)async {
    return await homeRepository.getExpenses(userId: params.userId,);
  }
}

class FetchExpensesParams{
  final String userId;

  FetchExpensesParams({required this.userId});
}