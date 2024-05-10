import 'package:aura/core/commonData/common_data.dart';
import 'package:aura/domain/socket/socket.dart';
import 'package:aura/presentation/screens/bottom_navigation/bottom_navigation.dart';
import 'package:aura/presentation/screens/auth/log_in.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';



//-------------------------------snackbar--------------------------

snackBar(String text, context) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(text),
    backgroundColor: Colors.blue,
    elevation: 10,
    margin: const EdgeInsets.all(10),
  ));
}

//------------------------------navigator-------------------------

navigatorReplacement(page, context) {
  Navigator.of(context).pushReplacement(PageTransition(
      child: page,
      type: PageTransitionType.fade,
      duration: const Duration(seconds: 1)));
}

navigatorPush(page, context) {
  Navigator.of(context).push(PageTransition(
      child: page,
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 1000)));
}

//-----------------------shared preference---------------------

userLoggedIn(context) async {
  final sharedprefs = await SharedPreferences.getInstance();
  await sharedprefs.setBool(savedkey, true);
}

saveToken(token) async {
  final sharedprefs = await SharedPreferences.getInstance();
  await sharedprefs.setString('token', token);
}

saveUsername(username) async {
  final sharedprefs = await SharedPreferences.getInstance();
  await sharedprefs.setString('username', username);
}

Future<String?> getToken() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  return sharedPrefs.getString('token');
}

Future<String?> getUsername() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  return sharedPrefs.getString('username');
}

Future<void> checkLoggedIn(context) async {
  final sharedprefs = await SharedPreferences.getInstance();
  final result = sharedprefs.getBool(savedkey);
  if (result == null || result == false) {
    navigatorReplacement(const LogIn(), context);
  } else {
    navigatorReplacement(const CustomBottomNavigationBar(), context);
  }
}

Future<void> logOut(context) async {
  indexChangeNotifier.value = 0;
  savedPostSet = {};
  SocketService().disconnectSocket();
  final sharedprefs = await SharedPreferences.getInstance();
  sharedprefs.setBool(savedkey, false);
  navigatorReplacement(const LogIn(), context);
  snackBar("Log out succefully", context);
}

Future<void> like() async {
  final sharedprefs = await SharedPreferences.getInstance();
  sharedprefs.setBool('liked', true);
}

Future<void> unlike() async {
  final sharedprefs = await SharedPreferences.getInstance();
  sharedprefs.setBool('liked', false);
}

// Future<void> checkLike() async {
//   final sharedprefs = await SharedPreferences.getInstance();
//   sharedprefs.getBool('liked');
// }
