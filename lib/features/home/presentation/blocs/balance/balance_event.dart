part of 'balance_bloc.dart';

@immutable
sealed class BalanceEvent {}

final class FetchBalanceEvent extends BalanceEvent {
  final String userId;

  FetchBalanceEvent({required this.userId});
}

final class UpdateBalanceEvent extends BalanceEvent {
  final String balanceId;
  final double balance;

  UpdateBalanceEvent({
    required this.balanceId,
    required this.balance,
  });
}
