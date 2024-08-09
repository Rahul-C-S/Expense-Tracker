import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/common/error/exceptions.dart';
import 'package:expense_tracker/features/home/data/models/balance_model.dart';
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

  Future<Map<String, dynamic>> getExpense({
    required String expenseId,
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

  Future<BalanceModel> getBalance({
    required String userId,
  });

  Future<void> updateBalance({
    required String balanceId,
    required double balance,
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

  @override
  Future<BalanceModel> getBalance({
    required String userId,
  }) async {
    try {
      final balances = firebaseFirestore.collection('balances');

      final querySnapshot =
          await balances.where('userId', isEqualTo: userId).get();
      return BalanceModel(
        id: querySnapshot.docs.first.id,
        balance: querySnapshot.docs.first.data()['balance'],
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateBalance({
    required String balanceId,
    required double balance,
  }) async {
    try {
      final balances = firebaseFirestore.collection('balances');
      await balances.doc(balanceId).update({
        'balance': balance,
      });
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> getExpense({
    required String expenseId,
  }) async {
    try {
      final CollectionReference expenses =
          FirebaseFirestore.instance.collection('expenses');
      final DocumentSnapshot documentSnapshot =
          await expenses.doc(expenseId).get();

      if (documentSnapshot.exists) {
        final data = documentSnapshot.data() as Map<String, dynamic>;
        return {
          'userId': data['userId'] as String,
          'amount': data['amount'] as double,
        };
      } else {
        throw ServerException('Document does not exist');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
