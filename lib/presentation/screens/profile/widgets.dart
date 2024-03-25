//-----------------------profile following text----------------
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

profileCardText2(text) => Text(text,style: TextStyle(fontSize: 16),);

profileText1(text) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15),
    child: Text(
      text,
      style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontFamily: "kanit",color: Colors.black54),
    ),
  );
}

class UserProfileButton extends StatelessWidget {
  const UserProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.blueAccent),
            foregroundColor: const MaterialStatePropertyAll(kBlack),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () {},
          child: const Text(
            'Follow',
            style: TextStyle(
              color: kWhite,
            ),
          ),
        ),
        kwidth20,
        ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () {},
          child: const Icon(CupertinoIcons.envelope),
        ),
      ],
    );
  }
}