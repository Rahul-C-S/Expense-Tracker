import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/core/common/error/exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDataSource {
  Future<void> login({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  });

  Future<void> logout();

  Future<void> forgotPassword({
    required String email,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl(
    this.firebaseAuth,
    this.firebaseFirestore,
  );

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Something went wrong!');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await user.user?.updateDisplayName(name);
      final balances = firebaseFirestore.collection('balances');
      balances.add({
        'userId': user.user?.uid,
        'balance': 0.00,
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Something went wrong!');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message ?? 'Something went wrong!');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
