import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:expense_tracker/core/common/widgets/input_field.dart';
import 'package:expense_tracker/core/common/widgets/submit_button.dart';
import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:expense_tracker/core/utils/loader.dart';
import 'package:expense_tracker/core/utils/show_snackbar.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:expense_tracker/features/auth/presentation/pages/sign_up_page.dart';
import 'package:expense_tracker/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  void route(BuildContext context) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
        (route) => false,
      );

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController registeredEmailController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    registeredEmailController.dispose();
    super.dispose();
  }

  void showResetPasswordDialog() {
    registeredEmailController.clear();

    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      body: Center(
        child: InputField(
          controller: registeredEmailController,
          hintText: 'Registered email',
        ),
      ),
      btnOkOnPress: () {
        if (registeredEmailController.text.isNotEmpty) {
          BlocProvider.of<AuthBloc>(context).add(
            ForgotPasswordEvent(
              registeredEmailController.text.trim(),
            ),
          );
        } else {

          showSnackBar(
            context: context,
            message: 'Please type your registered email.',
          );
          
        }
      },
      btnOkColor: ColorPallette.primary,
      dialogBackgroundColor: ColorPallette.greyShade4,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallette.primaryShade3,
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Center(
          child: SingleChildScrollView(
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  Loader.circular(context);
                } else {
                  Loader.hide(context);
                }

                if (state is AuthFailure) {
                  showSnackBar(context: context, message: state.error);
                }

                if (state is AuthSuccess) {
                  showSnackBar(
                    context: context,
                    message: 'Login successful',
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
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    'LOGIN',
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
                                controller: emailController,
                                hintText: 'Email',
                              ),
                              const SizedBox(height: 20),
                              InputField(
                                controller: passwordController,
                                hintText: 'Password',
                                isObscureText: true,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () => showResetPasswordDialog(),
                                    child: const Text(
                                      'Forgot password?',
                                      style: TextStyle(
                                        color: ColorPallette.primaryShade3,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              SubmitButton(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<AuthBloc>(context).add(
                                      LoginEvent(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                      ),
                                    );
                                  }
                                },
                                buttonText: 'Login',
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
                    onPressed: () => const SignUpPage().route(context),
                    child: const Text(
                      'Don\'t have an account? Sign up.',
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
      ),
    );
  }
}
