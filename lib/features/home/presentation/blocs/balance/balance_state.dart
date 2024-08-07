part of 'balance_bloc.dart';

@immutable
sealed class BalanceState {}

final class BalanceInitial extends BalanceState {}
final class BalanceLoading extends BalanceState {}
final class BalanceFailure extends BalanceState {
  final String error;

  BalanceFailure(this.error);
}
final class BalanceFetchSuccess extends BalanceState {
  final Balance balance;

  BalanceFetchSuccess(this.balance);
}
final class BalanceUpdateSuccess extends BalanceState {}
