part of 'inject_dependencies.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> injectDependencies() async {
  _initAuth();

  final defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  Hive.defaultDirectory = defaultDirectory;

  // Utils
  serviceLocator.registerFactory(
    () => FirebaseAuth.instance,
  );
}

void _initAuth() {
  // Data sources
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
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
