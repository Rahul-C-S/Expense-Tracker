import 'package:expense_tracker/core/utils/loader.dart';
import 'package:expense_tracker/features/home/presentation/blocs/expense/expense_bloc.dart';
import 'package:expense_tracker/features/home/presentation/widgets/user_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: BlocConsumer<ExpenseBloc, ExpenseState>(
          listener: (context, state) {
            if(state is ExpenseLoading){
              Loader.circular(context);
            }else{
              Loader.hide(context);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                UserDetails(),
              ],
            );
          },
        ),
      ),
    );
  }
}
