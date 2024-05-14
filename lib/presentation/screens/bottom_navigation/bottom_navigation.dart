import 'package:aura/core/colors/colors.dart';
import 'package:aura/presentation/screens/chat/message_list.dart';
import 'package:aura/presentation/screens/post/create_post.dart';
import 'package:aura/presentation/screens/explore/explore.dart';
import 'package:aura/presentation/screens/home/home.dart';
import 'package:aura/presentation/screens/profile/current_user_profile.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:bottom_bar/bottom_bar.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  var selectedIndex = 0;

  // final pageController = NotchBottomBarController();

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
            return IndexedStack(
              index: value,
              children: pages,
            );
          },
        ),
        bottomNavigationBar: BottomBar(
            selectedIndex: indexChangeNotifier.value,
            items: [
              BottomBarItem(
                  icon: Icon(Icons.home),
                  activeColor: Theme.of(context).colorScheme.secondary,
                  title: Text("Home"),
                  activeIconColor: Theme.of(context).colorScheme.secondary,
                  inactiveColor: Theme.of(context).colorScheme.secondary,),
              BottomBarItem(
                  icon: Icon(Icons.search),
                  activeColor: Theme.of(context).colorScheme.secondary,
                  activeIconColor: Theme.of(context).colorScheme.secondary,
                  title: Text("Search"),
                  inactiveColor: Theme.of(context).colorScheme.secondary,),
              BottomBarItem(
                  icon: Icon(Icons.add),
                  activeColor: Theme.of(context).colorScheme.secondary,
                  activeIconColor: Theme.of(context).colorScheme.secondary,
                  title: Text("Create"),
                  inactiveColor: Theme.of(context).colorScheme.secondary,),
              BottomBarItem(
                  icon: Icon(Ionicons.chatbox_ellipses),
                  activeColor: Theme.of(context).colorScheme.secondary,
                  activeIconColor: Theme.of(context).colorScheme.secondary,
                    title: Text("Chat"),
                  inactiveColor: Theme.of(context).colorScheme.secondary,),
              BottomBarItem(
                  icon: Icon(Ionicons.person),
                  activeColor: Theme.of(context).colorScheme.secondary,
                  activeIconColor: Theme.of(context).colorScheme.secondary,
                    title: Text("Profile"),
                  inactiveColor: Theme.of(context).colorScheme.secondary,),
            ],
            onTap: (value) {
              setState(() {
              indexChangeNotifier.value = value;
                
              });
            })
        // AnimatedNotchBottomBar(
        //   showBlurBottomBar: true,
        //   blurOpacity: 0.2,
        //   blurFilterX: 5.0,
        //   blurFilterY: 10.0,
        //   durationInMilliSeconds: 0,
        //   notchBottomBarController: pageController,
        //   onTap: (value) => indexChangeNotifier.value = value,
        //   kIconSize: 20,
        //   kBottomRadius: 10,
        //   bottomBarItems: const [
        //     BottomBarItem(
        //       inActiveItem: Icon(
        //         Icons.home,
        //         color: Colors.blueGrey,
        //       ),
        //       activeItem: Icon(
        //         Icons.home_filled,
        //         color: kBlack,
        //       ),
        //       // itemLabel: 'Home',
        //     ),
        //     BottomBarItem(
        //       inActiveItem: Icon(
        //         Icons.search,
        //         color: Colors.blueGrey,
        //       ),
        //       activeItem: Icon(
        //         Icons.search,
        //         color: kBlack,
        //       ),
        //       // itemLabel: 'Search',
        //     ),
        //     BottomBarItem(
        //       inActiveItem: Icon(Ionicons.add, color: Colors.blueGrey,),
        //       activeItem: Icon(
        //         Ionicons.add,
        //         color: kBlack,
        //       ),
        //       //  itemLabel: 'New Post ',
        //     ),
        //     BottomBarItem(
        //       inActiveItem: Icon(Ionicons.chatbox_ellipses_outline, color: Colors.blueGrey,),
        //       activeItem: Icon(
        //         Ionicons.chatbox_ellipses,
        //         color: kBlack,
        //       ),
        //       //  itemLabel: 'New Post ',
        //     ),
        //     BottomBarItem(
        //       inActiveItem: Icon(Ionicons.person_outline, color: Colors.blueGrey,),
        //       activeItem: Icon(
        //         Ionicons.person,
        //         color: kBlack,
        //       ),
        //       //  itemLabel: "Profile",
        //     ),
        //   ],
        // ),
        );
  }
}
