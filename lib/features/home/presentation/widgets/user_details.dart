import 'package:expense_tracker/core/dependencies/inject_dependencies.dart';
import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/core/utils/alert.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetails extends StatelessWidget {
  UserDetails({super.key});

  final FirebaseAuth _firebaseAuth = serviceLocator<FirebaseAuth>();

  @override
  Widget build(BuildContext context) {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundColor: ColorPallette.primary,
              child: Icon(Icons.person),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName ?? 'No Name',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: ColorPallette.primaryShade1,
                  ),
                ),
                Text(
                  user.email ?? 'No Email',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: ColorPallette.greyShade3,
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Alert.showAlertDialog(
                  context,
                  title: 'Logout',
                  message: 'Are you sure you want to logout?',
                  cancelButtonText: 'Cancel',
                  confirmButtonText: 'Confirm',
                  onConfirm: () =>
                      BlocProvider.of<AuthBloc>(context).add(LogoutEvent()),
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
      ],
    );
  }
}
