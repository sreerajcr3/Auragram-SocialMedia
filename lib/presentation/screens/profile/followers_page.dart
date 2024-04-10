import 'package:flutter/material.dart';

class Followers extends StatefulWidget {
  const Followers({super.key});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(),
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(
                      text: "followers",
                    ),
                    Tab(
                      text: "following",
                    )
                  ],
                ),
                // TabBarView(children: [
                //   Column(
                //     children: [
                //       Expanded(
                //           child: ListView.builder(itemBuilder: (context, index) {
                //         return Container();
                //       })),
                //     ],
                //   )
                // ])
              ],
            ),
          ),
        ));
  }
}
