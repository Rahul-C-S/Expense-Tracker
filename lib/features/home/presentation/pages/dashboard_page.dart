import 'package:expense_tracker/core/constants/categories.dart';
import 'package:expense_tracker/core/dependencies/inject_dependencies.dart';
import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/core/utils/date.dart';
import 'package:expense_tracker/core/utils/loader.dart';
import 'package:expense_tracker/core/utils/show_snackbar.dart';
import 'package:expense_tracker/features/home/domain/entities/expense.dart';
import 'package:expense_tracker/features/home/presentation/blocs/balance/balance_bloc.dart';
import 'package:expense_tracker/features/home/presentation/blocs/expense/expense_bloc.dart';
import 'package:expense_tracker/features/home/presentation/pages/expenses_category_page.dart';
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

  DateTime _date = DateTime.now();
  double _spent = 0.00;

  void _fetchExpenses() {
    BlocProvider.of<ExpenseBloc>(context).add(
      FetchExpenseEvent(userId: _user!.uid),
    );
  }

  void _fetchBalance() {
    BlocProvider.of<BalanceBloc>(context).add(
      FetchBalanceEvent(userId: _user!.uid),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
    _fetchBalance();
  }

  void _leftButtonAction() {
    setState(() {
      _spent = 0;
      _date = Date.subtractMonths(_date, 1);
    });
  }

  void _rightButtonAction() {
    setState(() {
      _spent = 0;
      _date = Date.addMonths(_date, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: MultiBlocListener(
          listeners: [
            BlocListener<ExpenseBloc, ExpenseState>(
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
                  _fetchExpenses();
                }

                if (state is ExpenseAddSuccess) {
                  showSnackBar(
                    context: context,
                    message: 'Expense added successfully',
                  );
                  _fetchExpenses();
                }
                if (state is ExpenseDeleteSuccess) {
                  Navigator.pop(context);
                  showSnackBar(
                    context: context,
                    message: 'Expense deleted successfully',
                  );
                  _fetchExpenses();
                }
                if (state is ExpenseUpdateSuccess) {
                  Navigator.pop(context);
                  showSnackBar(
                    context: context,
                    message: 'Expense updated successfully',
                  );
                  _fetchExpenses();
                }
              },
            ),
            BlocListener<BalanceBloc, BalanceState>(
              listener: (context, state) {
                if (state is BalanceLoading) {
                  Loader.circular(context);
                } else {
                  Loader.hide(context);
                }

                if (state is BalanceFailure) {
                  showSnackBar(
                    context: context,
                    message: state.error,
                  );
                }
                if (state is BalanceUpdateSuccess) {
                  _fetchBalance();
                }
              },
            ),
          ],
          child: BlocBuilder<ExpenseBloc, ExpenseState>(
            builder: (context, state) {
              if (state is ExpensesFetchSuccess) {
                final Map<int, dynamic> groupedExpenses = {};

                final expensesList = state.expenses;
                _spent = 0;

                for (var expense in expensesList) {
                  if (Date.isInSameMonth(expense.date, _date)) {
                    _spent += expense.amount;

                    for (var category in Categories.getCategories()) {
                      if (expense.categoryId == category.id) {
                        if (!groupedExpenses.containsKey(category.id)) {
                          groupedExpenses[category.id] = {
                            'name': category.name,
                            'totalExpense': 0.00,
                            'icon': category.icon,
                            'expenses': <Expense>[]
                          };
                        }
                        groupedExpenses[category.id]['totalExpense'] +=
                            expense.amount;
                        groupedExpenses[category.id]['expenses'].add(expense);
                      }
                    }
                  }
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      UserDetails(),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<BalanceBloc, BalanceState>(
                        builder: (context, balanceState) {
                          return SummaryCard(
                            balance: (balanceState is BalanceFetchSuccess)
                                ? balanceState.balance
                                : null,
                            spent: _spent,
                            date: _date,
                            leftButtonAction: _leftButtonAction,
                            rightButtonAction: _rightButtonAction,
                          );
                        },
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
                          final categoryId =
                              groupedExpenses.keys.elementAt(index);
                          final categoryDetails = groupedExpenses[categoryId];
                          return GestureDetector(
                            onTap: () => ExpensesCategoryPage.route(
                              context: context,
                              expenses: groupedExpenses[categoryId]['expenses'],
                              icon: categoryDetails['icon'],
                              title: categoryDetails['name'],
                              index: index,
                            ),
                            child: ExpensesItem(
                              id: categoryId,
                              index: index,
                              total: categoryDetails['totalExpense'],
                              icon: categoryDetails['icon'],
                              name: categoryDetails['name'],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
