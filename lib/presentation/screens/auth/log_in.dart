import 'package:aura/bloc/logIn_bloc/bloc/log_in_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/bottom_navigation/bottom_navigation.dart';
import 'package:aura/presentation/screens/auth/forgot_password.dart';
import 'package:aura/presentation/screens/auth/sign_up.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: BlocConsumer<LogInBloc, LogInState>(listener: (context, state) {
        if (state is LoginSuccessState) {
          navigatorReplacement(const CustomBottomNavigationBar(), context);
        } else if (state is LoginInvalidPasswordState) {
          snackBar("Incorrect password", context);
        } else if (state is LoginLoadingState) {
          const Center(child: CircularProgressIndicator());
        } else if (state is LoginInvalidUsernameState) {
          snackBar("Incorrect email address", context);
        } else if (state is LoginParameterMissingState) {
          snackBar("Username and password are empty", context);
        } else if (state is LoginErrorState) {
          snackBar("Server unreachable", context);
        } else {}
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kheight30,
                kheight30,
                kheight30,
                const TItleHeading(
                  text1: 'Welcome ',
                  subText: 'Continue with your Account',
                  text2: 'Back..!',
                ),
                kheight30,
                Center(
                  child: Column(
                    children: [
                      TextformField(
                          prefixIcon: CupertinoIcons.person_fill,
                          labelText: 'Username',
                          controller: usernameController,
                          valueText: "Username"),
                      kheight30,
                      PasswordTextFormFeild(
                        prefixIcon: Icons.lock,
                        labelText: 'Password',
                        controller: passwordController,
                        valueText: "Password",
                        suffixIcon: Ionicons.eye_off,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  navigatorPush(
                                      const ForgotPassword(), context);
                                },
                                child: Text(
                                  'Forgot Password ?',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                )),
                          ],
                        ),
                      ),
                      kheight20,
                      if (state is LoginLoadingState)
                        // CustomButton(text: "loading.....", onPressed: () {})
                        demoButton(context)
                      else
                        CustomButton(
                          text: "Log In",
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              context.read<LogInBloc>().add(UserLogin(
                                  username: usernameController.text,
                                  password: passwordController.text));
                              userLoggedIn(context);
                            }
                          },
                        ),
                      kheight30,
                      TextButton(
                          onPressed: () {
                            navigatorPush(const SignUpScreen(), context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              Text(
                                "Sign Up ",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                              ),
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
