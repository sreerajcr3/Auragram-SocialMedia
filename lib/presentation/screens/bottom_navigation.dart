import 'package:aura/core/colors/colors.dart';
import 'package:aura/presentation/screens/image_picker.dart';
import 'package:aura/presentation/screens/home.dart';
import 'package:aura/presentation/screens/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [const HomeScreen(),ImagePIcker(), const Profile()];
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            selectedItemColor: Colors.cyan,
            unselectedItemColor: kBlack,
            // margin: const EdgeInsets.all(20),
            // marginR: EdgeInsets.all(20),
            // curve: Curves.bounceIn,
            // itemPadding: const EdgeInsets.all(10),
            // enableFloatingNavBar: true,
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
            items: const [
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.login),
              //   label: "Login",
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.add),
                label: "NEW Post",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person),
                label: "Profile",
              )
            ],
          ),
        ),
      ),
    );
  }
}
