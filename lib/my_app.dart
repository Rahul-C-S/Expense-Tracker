import 'package:expense_tracker/core/dependencies/inject_dependencies.dart';
import 'package:expense_tracker/core/theme/theme.dart';
import 'package:expense_tracker/features/auth/presentation/pages/login_page.dart';
import 'package:expense_tracker/features/home/presentation/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});
  
  final FirebaseAuth _firebaseAuth = serviceLocator<FirebaseAuth>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: AppTheme.lightMode,
      home: StreamBuilder(
          stream: _firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Authenticated
              return const HomePage();
            }
            // Not authenticated
            return const LoginPage();
          }),
    );
  }
}
