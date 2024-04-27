import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:aura/bloc/otpBloc/bloc/otp_bloc.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/auth/otp.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  //--------------------------controllers-----------------------

  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNoController = TextEditingController();
  final otpController = TextEditingController();
  final pageController = PageController();

  OtpBloc otpBloc = OtpBloc();

  bool isStreched = false;
  String? selectedValue;
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<OtpBloc, OtpState>(
        bloc: otpBloc,
        listener: (context, state) {
          switch (state.runtimeType) {
            case OtpLoadingState:
              const Center(child: CircularProgressIndicator());
            case OtpSuccessState:
              final username = usernameController.text;
              final fullname = fullNameController.text;
              final email = emailController.text;
              final password = passwordController.text;
              final accountType = selectedValue;
              final phoneNo = int.parse(phoneNoController.text);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => OtpScreen(
                      username: username,
                      fullname: fullname,
                      email: email,
                      password: password,
                      accountType: accountType!,
                      phoneNo: phoneNo),
                ),
              );
              break;
            case OtpErrorState:
              snackBar("Email address already taken", context);
              break;
          }
        },
        builder: (context, state) {
          if (state is OtpLoadingState) {
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
                    const TItleHeading(
                      text1: 'Welcome to ',
                      subText: 'Register your account',
                      text2: 'Auragram..!',
                    ),
                    kheight30,
                    Center(
                      child: Column(
                        children: [
                          TextformField(
                            valueText: 'Name',
                            labelText: "Full name",
                            controller: fullNameController,
                          ),
                          kheight20,
                          TextformField(
                            valueText: 'Username',
                            labelText: "Username",
                            controller: usernameController,
                          ),
                          kheight20,
                          TextformField(
                            valueText: "Phone Number",
                            labelText: "Phone Number",
                            controller: phoneNoController,
                          ),
                          kheight20,
                          TextformField(
                            valueText: 'Email Address',
                            labelText: "Email Address",
                            controller: emailController,
                          ),
                          kheight20,
                          TextformField(
                            valueText: 'Password',
                            labelText: "Password",
                            controller: passwordController,
                          ),
                          kheight20,
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            child: CustomDropdown(
                              decoration: CustomDropdownDecoration(
                                  closedBorder: Border.all(),
                                  closedBorderRadius:
                                      BorderRadius.circular(10)),
                              validateOnChange: true,
                              // Function to validate if the current selected item is valid or not
                              validator: (value) =>
                                  value == null ? "    Must not be null" : null,
                              canCloseOutsideBounds: true,
                              items: const ['public', 'private', 'bussiness'],
                              onChanged: (value) {
                                selectedValue = value;
                              },
                              hintText: 'Select Account type',
                            ),
                          ),
                          kheight20,
                          CustomButton(
                            text: "Sign up",
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                debugPrint(selectedValue);
                                final email = emailController.text;

                                otpBloc.add(SendOtpEvent(email: email));
                              }
                            },
                          ),
                        ],
                      ),
                      // child: ExpandablePageView(
                      //     controller: pageController,
                      //     children: [
                      //       page1(fullNameController, usernameController,
                      //           phoneNoController, pageController, key),
                      //       page2(
                      //           emailController,
                      //           passwordController,
                      //           context,
                      //           selectedValue,
                      //           key,
                      //           otpBloc,
                      //           pageController,
                      //           setState),
                      //     ]),
                    ),
                    kheight20,
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

page1(fullNameController, usernameController, phoneNoController,
    PageController pagecontroller, key) {
  return Column(
    children: [
      kheight20,
      TextformField(
        valueText: 'Name',
        labelText: "Full name",
        controller: fullNameController,
      ),
      kheight20,
      TextformField(
        valueText: 'Username',
        labelText: "Username",
        controller: usernameController,
      ),
      kheight20,
      TextformField(
        valueText: "Phone Number",
        labelText: "Phone Number",
        controller: phoneNoController,
      ),
      kheight20,
      CustomButton(
          onPressed: () {
            if (key.currentState.validate()) {
              pagecontroller.animateToPage(
                1,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            }
          },
          text: 'Continue')
    ],
  );
}

page2(emailController, passwordController, context, selectedValue, key, otpBloc,
    pageController, Function setStateCallback) {
  return Column(
    children: [
      kheight20,
      TextformField(
        valueText: 'Email Address',
        labelText: "Email Address",
        controller: emailController,
      ),
      kheight20,
      TextformField(
        valueText: 'Password',
        labelText: "Password",
        controller: passwordController,
      ),
      kheight20,
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.9,
        child: CustomDropdown(
          decoration: CustomDropdownDecoration(
              closedBorder: Border.all(),
              closedBorderRadius: BorderRadius.circular(20)),
          validateOnChange: true,
          // Function to validate if the current selected item is valid or not
          validator: (value) => value == null ? "    Must not be null" : null,
          canCloseOutsideBounds: true,
          items: const ['public', 'private', 'bussiness'],
          onChanged: (value) {
            setStateCallback(() {
              selectedValue = value;
            });
          },
          hintText: 'Select Account type',
        ),
      ),
      kheight20,
      CustomButton(
        text: "Sign up",
        onPressed: () {
          if (key.currentState!.validate()) {
            userLoggedIn(context);
            debugPrint(selectedValue);
            final email = emailController.text;

            otpBloc.add(SendOtpEvent(email: email));
          }
        },
      ),
    ],
  );
}
