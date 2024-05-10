import 'package:flutter/material.dart';

const kWhite = Colors.white;
const kblue = Colors.blue;
const kBlack = Colors.black;
final kGrey = Colors.grey.shade300;
const kred = Colors.red;
const kgreen = Colors.green;
const kGreyDark = Colors.grey;
final themeGrey = Colors.grey.shade900;
final themeGreyPrimary = Colors.grey.shade700;
final themeGreyPrimaryLightDark = Colors.grey.shade600;
final themeGreyPrimaryLight = Colors.grey.shade300;
final themeGreySecondary = Colors.grey.shade500;



ThemeData lightMode = ThemeData(
  
  primaryColor: kWhite,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(primary: kWhite)
  
);

ThemeData darkMode = ThemeData(
  fontFamily: "JosefinSans",
  brightness: Brightness.dark,
  primaryColorLight:themeGreyPrimaryLightDark ,
  colorScheme: ColorScheme.dark(
    background: themeGrey,
    primary: themeGreyPrimary,
    secondary: themeGreySecondary,
    tertiary: kBlack
    
    
  )
);