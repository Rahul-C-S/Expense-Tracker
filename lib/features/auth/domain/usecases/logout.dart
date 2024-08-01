import 'package:expense_tracker/core/common/error/failures.dart';
import 'package:expense_tracker/core/common/usecase/usecase.dart';
import 'package:expense_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class Logout implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  Logout(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.logout();
  }
}
