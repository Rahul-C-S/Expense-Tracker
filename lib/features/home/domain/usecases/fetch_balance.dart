import 'package:expense_tracker/core/common/error/failures.dart';
import 'package:expense_tracker/core/common/usecase/usecase.dart';
import 'package:expense_tracker/features/home/domain/entities/balance.dart';
import 'package:expense_tracker/features/home/domain/repositories/home_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchBalance implements UseCase<Balance, FetchBalanceParams> {
  final HomeRepository homeRepository;

  FetchBalance(this.homeRepository);

  @override
  Future<Either<Failure, Balance>> call(FetchBalanceParams params) async {
    return await homeRepository.getBalance(
      userId: params.userId,
    );
  }
}

class FetchBalanceParams {
  final String userId;

  FetchBalanceParams({
    required this.userId,
  });
}
