import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:expense_tracker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:expense_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:expense_tracker/features/auth/domain/usecases/forgot_password.dart';
import 'package:expense_tracker/features/auth/domain/usecases/login.dart';
import 'package:expense_tracker/features/auth/domain/usecases/logout.dart';
import 'package:expense_tracker/features/auth/domain/usecases/sign_up.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:expense_tracker/features/home/data/datasources/home_remote_data_source.dart';
import 'package:expense_tracker/features/home/data/repositories/home_repository_impl.dart';
import 'package:expense_tracker/features/home/domain/repositories/home_repository.dart';
import 'package:expense_tracker/features/home/domain/usecases/add_expense.dart';
import 'package:expense_tracker/features/home/domain/usecases/delete_expense.dart';
import 'package:expense_tracker/features/home/domain/usecases/fetch_balance.dart';
import 'package:expense_tracker/features/home/domain/usecases/fetch_expenses.dart';
import 'package:expense_tracker/features/home/domain/usecases/update_balance.dart';
import 'package:expense_tracker/features/home/domain/usecases/update_expense.dart';
import 'package:expense_tracker/features/home/presentation/blocs/balance/balance_bloc.dart';
import 'package:expense_tracker/features/home/presentation/blocs/expense/expense_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';


part 'inject_dependencies_main.dart';
