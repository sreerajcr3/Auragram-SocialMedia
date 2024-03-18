import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:flutter/material.dart';

class TextformField extends StatelessWidget {
  final String labelText;
  final String valueText;
  final TextEditingController controller;
  const TextformField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return '$valueText is required*';
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide()),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide:
                    const BorderSide()), // border: const OutlineInputBorder(),
            labelText: labelText),
      ),
    );
  }
}

class TItleHeading extends StatelessWidget {
  final String text1;
  final String? text2;
  final String subText;
  const TItleHeading({
    super.key,
    required this.subText,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: const TextStyle(
                fontSize: 45, fontWeight: FontWeight.w600, fontFamily: 'kanit'),
          ),
          //   AnimatedTextKit(
          //  isRepeatingAnimation: false,
          //  pause: Duration(seconds: 0),
          //     animatedTexts: [
          //     FadeAnimatedText(text1, textStyle: TextStyle()),
          //   ]),

          Text(
            text2!,
            style: const TextStyle(
                fontSize: 35, fontWeight: FontWeight.w900, fontFamily: 'kanit'),
          ),
          kheight20,
          Text(
            subText,
            style: const TextStyle(fontFamily: "kanit", fontSize: 18),
          )
        ],
      ),
    );
  }
}

//-------------------------------button--------------------------

class CustomButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(
            kBlack,
          ),
          foregroundColor: const MaterialStatePropertyAll(kWhite),
          fixedSize: MaterialStatePropertyAll(
              Size.fromWidth(MediaQuery.sizeOf(context).width * 0.9))),
      child: Text(
        text,
        style: const TextStyle(fontFamily: "kanit", fontSize: 18),
      ),
    );
  }
}
class AppName extends StatelessWidget {
  const AppName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Auragram",
      style: TextStyle(
          fontFamily: "DancingScript",
          fontSize: 40,
          fontWeight: FontWeight.bold),
    );
  }
}
