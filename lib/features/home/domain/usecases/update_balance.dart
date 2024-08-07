import 'package:expense_tracker/core/common/error/failures.dart';
import 'package:expense_tracker/core/common/usecase/usecase.dart';
import 'package:expense_tracker/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateBalance implements UseCase<void, UpdateBalanceParams> {
  final HomeRepository homeRepository;

  UpdateBalance(this.homeRepository);

  @override
  Future<Either<Failure, void>> call(UpdateBalanceParams params) async {
    return await homeRepository.updateBalance(
      balanceId: params.balanceId,
      balance: params.balance,
    );
  }
}

class UpdateBalanceParams {
  final String balanceId;
  final double balance;

  UpdateBalanceParams({
    required this.balanceId,
    required this.balance,
  });
}
