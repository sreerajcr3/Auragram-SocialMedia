import 'package:aura/bloc/logIn_bloc/bloc/log_in_bloc.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/home/home.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpForgotPasswordScreen extends StatelessWidget {
  final String email;
  final String password;

  OtpForgotPasswordScreen({
    super.key,
    required this.email,
    required this.password,
  });
  final otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<LogInBloc, LogInState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccessState) {
            navigatorReplacement(const HomeScreen(), context);
          } else if (state is ForgotPasswordErrorState) {
            snackBar("Otp is not valid", context);
          } else {}
        },
        builder: (context, state) {
          if (state is ForgotPasswordLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TItleHeading(text1: 'Verify', subText: '', text2: '',),
                    kheight30,
                    Text(
                      'We have sent an otp on your email address - $email',
                      style: const TextStyle(fontSize: 20),
                    ),
                    kheight30,
                    TextFormField(
                      controller: otpcontroller,
                    ),
                    // OtpTextField(

                    //     handleControllers: (controllers) {
                    //       // Store the controllers in a list
                    //     List<TextEditingController?> otpControllers = controllers;
                    //     // Use the controllers to access the values entered by the user
                    //     List<String> otpValues = otpControllers.map((controller) => controller.text).toList();
                    //     print(otpValues); // Print the values for debugging purposes
                    //     },
                    //     numberOfFields: 6,
                    //     borderColor: Colors.black,
                    //     showFieldAsBox: true,
                    //     fieldWidth: 50,
                    //     cursorColor: Colors.blue,
                    //     borderRadius: BorderRadius.circular(10)),
                    kheight30,
                    CustomButton(
                      text: "Verify",
                      onPressed: () {
                        context.read<LogInBloc>().add(ForgotPasswordEvent(
                            email: email,
                            password: password,
                            otp: otpcontroller.text));
                      },
                    )
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
