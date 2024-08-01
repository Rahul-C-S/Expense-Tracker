import 'package:expense_tracker/core/common/error/failures.dart';
import 'package:expense_tracker/core/common/usecase/usecase.dart';
import 'package:expense_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ForgotPassword implements UseCase<void, ForgotPasswordParams> {
  final AuthRepository authRepository;

  ForgotPassword(this.authRepository);
  @override
  Future<Either<Failure, void>> call(ForgotPasswordParams params) async {
    return await authRepository.forgotPassword(email: params.email);
  }
}

class ForgotPasswordParams {
  final String email;

  ForgotPasswordParams(this.email);
}
