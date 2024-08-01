import 'package:expense_tracker/core/common/error/exceptions.dart';
import 'package:expense_tracker/core/common/error/failures.dart';
import 'package:expense_tracker/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:expense_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await authRemoteDataSource.login(
        email: email,
        password: password,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authRemoteDataSource.logout();
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await authRemoteDataSource.signUp(
        email: email,
        password: password,
      );
      return right(null);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
