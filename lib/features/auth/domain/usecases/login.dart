import 'package:expense_tracker/core/common/error/failures.dart';
import 'package:expense_tracker/core/common/usecase/usecase.dart';
import 'package:expense_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class Login implements UseCase<void, LoginParams> {
  final AuthRepository authRepository;

  Login(this.authRepository);
  @override
  Future<Either<Failure, void>> call(LoginParams params) async {
    return await authRepository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email, password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
