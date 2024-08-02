class Expense {
  final String expenseId;
  final double amount;
  final int categoryId;
  final String description;
  final DateTime date;

  Expense({
    required this.expenseId,
    required this.amount,
    required this.categoryId,
    required this.description,
    required this.date,
  });
}
