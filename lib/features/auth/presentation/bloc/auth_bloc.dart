import 'package:expense_tracker/core/common/usecase/usecase.dart';
import 'package:expense_tracker/features/auth/domain/usecases/login.dart';
import 'package:expense_tracker/features/auth/domain/usecases/logout.dart';
import 'package:expense_tracker/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login _login;
  final Logout _logout;
  final SignUp _signUp;

  AuthBloc({
    required Login login,
    required Logout logout,
    required SignUp signUp,
  })  : _login = login,
        _logout = logout,
        _signUp = signUp,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthLoading());
    });
    on<LoginEvent>(_onLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<SignUpEvent>(_onSignUpEvent);
  }

  void _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    final res = await _login(
      LoginParams(email: event.email, password: event.password),
    );

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSuccess()),
    );
  }

  void _onLogoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    final res = await _logout(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSuccess()),
    );
  }

  void _onSignUpEvent(SignUpEvent event, Emitter<AuthState> emit) async {
    final res = await _signUp(
      SignUpParams(
        email: event.email,
        password: event.password,
      ),
    );
    
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSuccess()),
    );
  }
}
