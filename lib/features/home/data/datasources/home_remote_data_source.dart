import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/common/error/exceptions.dart';
import 'package:expense_tracker/features/home/data/models/expense_model.dart';

abstract interface class HomeRemoteDataSource {
  Future<void> addExpense({
    required String userId,
    required double amount,
    required int categoryId,
    required String description,
    required DateTime date,
  });

  Future<List<ExpenseModel>> getExpenses({
    required String userId,
  });

  Future<void> updateExpense({
    required String expenseId,
    required double amount,
    required int categoryId,
    required String description,
    required DateTime date,
  });

  Future<void> deleteExpense({
    required String expenseId,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  HomeRemoteDataSourceImpl(this.firebaseFirestore);

  @override
  Future<void> addExpense({
    required String userId,
    required double amount,
    required int categoryId,
    required String description,
    required DateTime date,
  }) async {
    try {
      final expenses = firebaseFirestore.collection('expenses');
      final Map<String, dynamic> data = {
        'userId': userId,
        'amount': amount,
        'categoryId': categoryId,
        'description': description,
        'date': Timestamp.fromDate(date),
        'created_at': Timestamp.now(),
      };
      expenses.add(data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteExpense({
    required String expenseId,
  }) async {
    try {
      final expenses = firebaseFirestore.collection('expenses');
      await expenses.doc(expenseId).delete();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ExpenseModel>> getExpenses({
    required String userId,
  }) async {
    try {
      final expenses = firebaseFirestore.collection('expenses');
      final QuerySnapshot querySnapshot =
          await expenses.where('userId', isEqualTo: userId).get();
      return querySnapshot.docs
          .map(
            (doc) => ExpenseModel(
              amount: doc['amount'],
              categoryId: doc['categoryId'],
              description: doc['description'],
              date: (doc['date'] as Timestamp).toDate(),
              expenseId: doc.id,
            ),
          )
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateExpense({
    required String expenseId,
    required double amount,
    required int categoryId,
    required String description,
    required DateTime date,
  }) async {
    try {
      final expenses = firebaseFirestore.collection('expenses');
      final Map<String, dynamic> data = {
        'amount': amount,
        'categoryId': categoryId,
        'description': description,
        'date': Timestamp.fromDate(date),
        'created_at': Timestamp.now(),
      };
      await expenses.doc(expenseId).update(data);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
