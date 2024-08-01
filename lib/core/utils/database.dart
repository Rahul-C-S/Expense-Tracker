import 'package:cloud_firestore/cloud_firestore.dart';


class Database {

  final _expenses = FirebaseFirestore.instance.collection('expenses');

  
  // Create Expense
  Future<void> addExpense({
    required String userId,
    required double amount,
    required String category,
    required String description,
    required DateTime date,
  }) async {
    await _expenses.add({
      'userId': userId,
      'amount': amount,
      'category': category,
      'description': description,
      'date': Timestamp.fromDate(date),
      'created_at': Timestamp.now(),
    });
  }

  // Read Expense
  Future<List<Map<String, dynamic>>> getExpenses({
    required String userId,
  }) async {
    // Fetch the expense documents for the given user from Firestore
    final QuerySnapshot querySnapshot = await _expenses.where('userId', isEqualTo: userId).get();

    // Convert each document data to a Map<String, dynamic> and return the list
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  // Update Expense
  Future<void> updateExpense({
    required String expenseId,
    required Map<String, dynamic> updatedData,
  }) async {
    await _expenses.doc(expenseId).update(updatedData);
  }

  // Delete Expense
  Future<void> deleteExpense({
    required String expenseId,
  }) async {
    await _expenses.doc(expenseId).delete();
  }
}
