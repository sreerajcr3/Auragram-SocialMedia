import 'package:aura/bloc/signUpbloc/bloc/sign_up_bloc.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/bottom_navigation/bottom_navigation.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatelessWidget {
  final String username;
  final String fullname;
  final String email;
  final String password;
  final String accountType;
  final int phoneNo;

  OtpScreen(
      {super.key,
      required this.username,
      required this.fullname,
      required this.email,
      required this.password,
      required this.accountType,
      required this.phoneNo});
  final otpcontroller = TextEditingController();
  List<TextEditingController?> _otpControllers =
      List.generate(6, (index) => TextEditingController());

  List otpList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccessState) {
            snackBar("Account created..!", context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (_) => const CustomBottomNavigationBar()));
          } else if (state is SignUpEmailExistState) {
            snackBar("Email exists", context);
          } else if (state is SignUpPhoneNoExistState) {
            snackBar("PhoneNumber exists", context);
          } else if (state is SignUpAllFieldsRequiredState) {
            snackBar("All feilds are required", context);
          } else if (state is SignUpUsernameExistState) {
            snackBar('Username already taken', context);
          } else {
            snackBar("Oops..! Invalid Otp", context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TItleHeading(
                  text1: 'Verify',
                  subText: '',
                  text2: '',
                ),
                kheight30,
                Text(
                  'We have sent an otp on your email address - $email',
                  style: const TextStyle(fontSize: 20),
                ),
                kheight30,
                // TextFormField(
                //   controller: otpcontroller,
                // ),
                OtpTextField(
                  handleControllers: (controllers) {
                    _otpControllers = controllers;
                  },
                  onCodeChanged: (value) {
                    // Handle OTP value change
                  },
                  numberOfFields: 6,
                  borderColor: Colors.black,
                  showFieldAsBox: true,
                  fieldWidth: 50,
                  cursorColor: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),

                kheight30,
                ElevatedButton(
                  onPressed: () {

                    String otp = '';
                    for (var controller in _otpControllers) {
                      otp += controller?.text ?? '';
                    }

                    final user = User(
                        username: username,
                        email: email,
                        password: password,
                        fullname: fullname,
                        accountType: accountType,
                        phoneNo: phoneNo,
                        otp: otp);
                   
                    // BlocProvider.of<SignUpBloc>(context).add(UserSignUp( user: user));
                    userLoggedIn(context);
                    context.read<SignUpBloc>().add(UserSignUp(user: user));
                  },
                  child: const Text('Verify'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
