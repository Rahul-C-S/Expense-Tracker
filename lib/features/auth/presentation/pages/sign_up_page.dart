import 'package:expense_tracker/core/common/widgets/input_field.dart';
import 'package:expense_tracker/core/common/widgets/submit_button.dart';
import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/core/utils/loader.dart';
import 'package:expense_tracker/core/utils/show_snackbar.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/pages/login_page.dart';
import 'package:expense_tracker/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  void route(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ));

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallette.primaryShade3,
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 34,
                    color: ColorPallette.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: ColorPallette.primary,
                        borderRadius: BorderRadius.circular(2),
                        boxShadow: const [
                          BoxShadow(
                            color: ColorPallette.semiTransparent,
                            spreadRadius: 4,
                            blurRadius: 7,
                            offset: Offset(1, 4),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const SizedBox(height: 60),
                            InputField(
                              controller: nameController,
                              hintText: 'Name',
                            ),
                            const SizedBox(height: 20),
                            InputField(
                              controller: emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: 20),
                            InputField(
                              controller: passwordController,
                              hintText: 'Password',
                              isObscureText: true,
                            ),
                            const SizedBox(height: 20),
                            InputField(
                              controller: confirmPasswordController,
                              hintText: 'Confirm password',
                              isObscureText: true,
                            ),
                            const SizedBox(height: 20),
                            BlocListener<AuthBloc, AuthState>(
                              listener: (context, state) {
                                if (state is AuthLoading) {
                                  Loader.circular(context);
                                } else {
                                  Loader.hide(context);
                                }

                                if (state is AuthFailure) {
                                  showSnackBar(
                                      context: context, message: state.error);
                                }

                                if (state is AuthSuccess) {
                                  showSnackBar(
                                    context: context,
                                    message: 'Account has been created!',
                                  );
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                    (route) => false,
                                  );
                                }
                              },
                              child: SubmitButton(
                                onTap: () {
                                  if (!(passwordController.text.trim() ==
                                      confirmPasswordController.text.trim())) {
                                    showSnackBar(
                                      context: context,
                                      message: 'Passwords does not match!',
                                    );
                                    return;
                                  }

                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthBloc>(context)
                                        .add(SignUpEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      name: nameController.text,
                                    ));
                                  }
                                },
                                buttonText: 'Sign up',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -40,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: ColorPallette.semiTransparent,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(1, 4),
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundColor: ColorPallette.primaryShade3,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: ColorPallette.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    const LoginPage().route(context);
                  },
                  child: const Text(
                    'Already have an account? Login.',
                    style: TextStyle(
                      color: ColorPallette.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
