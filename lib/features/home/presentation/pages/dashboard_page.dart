import 'package:expense_tracker/core/constants/categories.dart';
import 'package:expense_tracker/core/dependencies/inject_dependencies.dart';
import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/core/utils/date.dart';
import 'package:expense_tracker/core/utils/loader.dart';
import 'package:expense_tracker/core/utils/show_snackbar.dart';
import 'package:expense_tracker/features/home/presentation/blocs/expense/expense_bloc.dart';
import 'package:expense_tracker/features/home/presentation/widgets/expenses_item.dart';
import 'package:expense_tracker/features/home/presentation/widgets/summary_card.dart';
import 'package:expense_tracker/features/home/presentation/widgets/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _user = serviceLocator<FirebaseAuth>().currentUser;

  DateTime date = DateTime.now();

  void _fetchExpenses() {
    BlocProvider.of<ExpenseBloc>(context).add(
      FetchExpenseEvent(userId: _user!.uid),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  void leftButtonAction() {
    setState(() {
      date = Date.subtractMonths(date, 1);
    });
  }

  void rightButtonAction() {
    setState(() {
      date = Date.addMonths(date, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: BlocConsumer<ExpenseBloc, ExpenseState>(
          listener: (context, state) {
            if (state is ExpenseLoading) {
              Loader.circular(context);
            } else {
              Loader.hide(context);
            }
            if (state is ExpenseFailure) {
              showSnackBar(
                context: context,
                message: state.error,
              );
            }

            if (state is ExpenseAddSuccess) {
              showSnackBar(
                context: context,
                message: 'Expense added successfully',
              );
              _fetchExpenses();
            }
            if (state is ExpenseDeleteSuccess) {
              showSnackBar(
                context: context,
                message: 'Expense deleted successfully',
              );
              _fetchExpenses();
            }
            if (state is ExpenseUpdateSuccess) {
              showSnackBar(
                context: context,
                message: 'Expense updated successfully',
              );
              _fetchExpenses();
            }
          },
          builder: (context, state) {
            final Map<String, dynamic> groupedExpenses = {};
            if (state is ExpensesFetchSuccess) {
              final expensesList = state.expenses;

              for (var expense in expensesList) {
                if (Date.isInSameMonth(expense.date,date)) {
                  for (var category in Categories.getCategories()) {
                    if (expense.categoryId == category.id) {
                      if (!groupedExpenses.containsKey(category.name)) {
                        groupedExpenses[category.name] = {
                          'id': category.id,
                          'totalExpense': 0.0,
                          'icon': category.icon,
                          'expenses': []
                        };
                      }
                      groupedExpenses[category.name]['totalExpense'] +=
                          expense.amount;
                      groupedExpenses[category.name]['expenses'].add(expense);
                    }
                  }
                }
              }
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  UserDetails(),
                  if (state is ExpensesFetchSuccess) ...[
                    const SizedBox(
                      height: 30,
                    ),
                    SummaryCard(
                      balance: 0.00,
                      spent: 0.00,
                      date: date,
                      leftButtonAction: leftButtonAction,
                      rightButtonAction: rightButtonAction,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Expenses',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: groupedExpenses.length,
                      separatorBuilder: (context, index) => const Divider(
                        color: ColorPallette.primaryShade1,
                        thickness: 0.5,
                      ),
                      itemBuilder: (context, index) {
                        final categoryName =
                            groupedExpenses.keys.elementAt(index);
                        final categoryDetails = groupedExpenses[categoryName];
                        return ExpensesItem(
                          id: categoryDetails['id'],
                          index: index,
                          total: categoryDetails['totalExpense'],
                          icon: categoryDetails['icon'],
                          name: categoryName,
                        );
                      },
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
