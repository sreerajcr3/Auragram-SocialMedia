import 'package:aura/bloc/logIn_bloc/bloc/log_in_bloc.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/auth/otp_forgotPassword.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LogInBloc, LogInState>(
        listener: (context, state) {
          if (state is ForgotPasswordOtpSuccessState) {
            navigatorReplacement(
                OtpForgotPasswordScreen(
                    email: emailController.text,
                    password: passwordController.text),
                context);
          } else if (state is ForgotPasswordOtpErrorState) {
            snackBar("User with email not found", context);
          }
        },
        builder: (context, state) {
          if (state is ForgotPasswordLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kheight30,
                    const TItleHeading(
                      text1: "Create your ",
                      subText:
                          'Enter your email address and we will send an otp',
                      text2: 'password',
                    ),
                    kheight20,
                    Center(
                      child: Container(
                        child: Column(
                          children: [
                            TextformField(
                                labelText: "Email address",
                                controller: emailController,
                                valueText: "Email address"),
                            kheight20,
                            TextformField(
                                labelText: " Password",
                                controller: passwordController,
                                valueText: "Password"),
                            kheight20,
                            TextformField(
                                labelText: "Confirm Password",
                                controller: confirmPasswordController,
                                valueText: " Password"),
                            kheight20,
                            kheight20,
                            CustomButton(
                              text: "Change Password",
                              onPressed: () {
                                if (key.currentState!.validate()) {
                                  if (passwordController.text ==
                                      confirmPasswordController.text) {
                                    context.read<LogInBloc>().add(
                                          ForgotPasswordOtpEvent(
                                            email: emailController.text,
                                          ),
                                        );
                                  } else {
                                    snackBar(
                                        "Passwords are not same....!", context);
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
