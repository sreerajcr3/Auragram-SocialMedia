import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/presentation/screens/chat/message_list.dart';
import 'package:aura/presentation/screens/post/create_post.dart';
import 'package:aura/presentation/screens/explore/explore.dart';
import 'package:aura/presentation/screens/home/home.dart';
import 'package:aura/presentation/screens/profile/current_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class CustomBottomNavigationBar extends StatefulWidget {
 const  CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  var selectedIndex = 0;

  final pageController = NotchBottomBarController();

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const ExplorePage(),
      const CreatePost(),
      const MessageList(),
      const MyProfile()
    ];
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, value, child) {
          return IndexedStack(index: value,children: pages,);
        },
      ),
      // bottomNavigationBar: ValueListenableBuilder(
      //   valueListenable: indexChangeNotifier,
      //   builder: (context, value, child) {
      //     return Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //         decoration:
      //             BoxDecoration(borderRadius: BorderRadius.circular(20)),
      //         child: BottomNavigationBar(
      //           type: BottomNavigationBarType.shifting,
      //           selectedItemColor: Colors.cyan,
      //           unselectedItemColor: kBlack,
      //           // margin: const EdgeInsets.all(20),
      //           // marginR: EdgeInsets.all(20),
      //           // curve: Curves.bounceIn,
      //           // itemPadding: const EdgeInsets.all(10),
      //           // enableFloatingNavBar: true,
      //           currentIndex: indexChangeNotifier.value,
      //           onTap: (value) {
      //             indexChangeNotifier.value = value;
      //           },
      //           items: const [
      //             BottomNavigationBarItem(
      //               icon: Icon(Icons.home),
      //               label: "Home",
      //             ),
      //             BottomNavigationBarItem(
      //               icon: Icon(CupertinoIcons.search),
      //               label: "Search",
      //             ),
      //             BottomNavigationBarItem(
      //               icon: Icon(Ionicons.add),
      //               label: "NEW Post",
      //             ),
      //             BottomNavigationBarItem(
      //               icon: Icon(Ionicons.person_outline),
      //               label: "Profile",
      //             )
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        showBlurBottomBar: true,
        blurOpacity: 0.2,
        blurFilterX: 5.0,
        blurFilterY: 10.0,
        durationInMilliSeconds: 0,
        notchBottomBarController: pageController,
        onTap: (value) => indexChangeNotifier.value = value,
        kIconSize: 20,
        kBottomRadius: 10,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: kBlack,
            ),
            // itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.search,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.search,
              color: kBlack,
            ),
            // itemLabel: 'Search',
          ),
          BottomBarItem(
            inActiveItem: Icon(Ionicons.add, color: Colors.blueGrey,),
            activeItem: Icon(
              Ionicons.add,
              color: kBlack,
            ),
            //  itemLabel: 'New Post ',
          ),
          BottomBarItem(
            inActiveItem: Icon(Ionicons.chatbox_ellipses_outline, color: Colors.blueGrey,),
            activeItem: Icon(
              Ionicons.add,
              color: kBlack,
            ),
            //  itemLabel: 'New Post ',
          ),
          BottomBarItem(
            inActiveItem: Icon(Ionicons.person_outline, color: Colors.blueGrey,),
            activeItem: Icon(
              Ionicons.person,
              color: kBlack,
            ),
            //  itemLabel: "Profile",
          ),
        ],
      ),
    );
  }
}
