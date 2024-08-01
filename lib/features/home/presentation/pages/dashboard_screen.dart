import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/core/utils/loader.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPallette.warning,
                  ),
                ),
                const SizedBox(
                  width: 14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome!'),
                    Text('User'),
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthLoading) {
                          Loader.circular(context);
                        }else{
                          Loader.hide(context);
                        }
                        if (state is AuthSuccess) {
                          const LoginPage().route(context);
                        }
                      },
                      child: TextButton.icon(
                        label: Text('Logout'),
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                        },
                        icon: Icon(
                          Icons.person,
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
