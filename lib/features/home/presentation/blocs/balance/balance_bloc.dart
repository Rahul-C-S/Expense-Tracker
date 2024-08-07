import 'package:expense_tracker/features/home/domain/entities/balance.dart';
import 'package:expense_tracker/features/home/domain/usecases/fetch_balance.dart';
import 'package:expense_tracker/features/home/domain/usecases/update_balance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  final FetchBalance _fetchBalance;
  final UpdateBalance _updateBalance;

  BalanceBloc({
    required FetchBalance fetchBalance,
    required UpdateBalance updateBalance,
  })  : _fetchBalance = fetchBalance,
        _updateBalance = updateBalance,
        super(BalanceInitial()) {
    on<BalanceEvent>((event, emit) {
      emit(BalanceLoading());
    });
    on<FetchBalanceEvent>(_onFetchBalanceEvent);
    on<UpdateBalanceEvent>(_onUpdateBalanceEvent);
  }

  void _onFetchBalanceEvent(
    FetchBalanceEvent event,
    Emitter<BalanceState> emit,
  ) async {
    final res = await _fetchBalance(
      FetchBalanceParams(
        userId: event.userId,
      ),
    );
    res.fold(
      (l) => emit(BalanceFailure(l.message)),
      (r) => emit(BalanceFetchSuccess(r)),
    );
  }

  void _onUpdateBalanceEvent(
    UpdateBalanceEvent event,
    Emitter<BalanceState> emit,
  ) async {
    final res = await _updateBalance(
      UpdateBalanceParams(
        balanceId: event.balanceId,
        balance: event.balance,
      ),
    );

    res.fold(
      (l) => emit(BalanceFailure(l.message)),
      (r) => emit(BalanceUpdateSuccess()),
    );
  }
}
