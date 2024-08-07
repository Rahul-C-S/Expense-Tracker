part of 'inject_dependencies.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> injectDependencies() async {
  _injectAuth();
  _injectHome();


  serviceLocator.registerLazySingleton(
    () => FirebaseFirestore.instance,
  );

  // Utils
  serviceLocator.registerFactory(
    () => FirebaseAuth.instance,
  );
}

void _injectAuth() {
  // Data sources
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )

    // Repository

    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )

    // Use cases

    ..registerFactory(
      () => Login(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => Logout(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ForgotPassword(
        serviceLocator(),
      ),
    )

    // Blocs
    ..registerLazySingleton(
      () => AuthBloc(
        login: serviceLocator(),
        logout: serviceLocator(),
        signUp: serviceLocator(),
        forgotPassword: serviceLocator(),
      ),
    );
}

void _injectHome() {
  // Data sources
  serviceLocator
    ..registerFactory<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(serviceLocator()),
    )

    // Repositories
    ..registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(
        serviceLocator(),
      ),
    )

    // Use cases

    ..registerFactory(
      () => AddExpense(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UpdateExpense(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => DeleteExpense(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => FetchExpenses(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => FetchBalance(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UpdateBalance(
        serviceLocator(),
      ),
    )

    // Blocs
    ..registerLazySingleton(
      () => BalanceBloc(
        fetchBalance: serviceLocator(),
        updateBalance: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ExpenseBloc(
        addExpense: serviceLocator(),
        deleteExpense: serviceLocator(),
        fetchExpenses: serviceLocator(),
        updateExpense: serviceLocator(),
      ),
    );
}
