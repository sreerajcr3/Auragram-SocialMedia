import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/presentation/screens/profile/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                  // color: Colors.green,
                  height: 300,
                ),
                SizedBox(
                  // color: Colors.blue,
                  child: Image.network(
                    "https://i.pinimg.com/564x/22/9d/fa/229dfa40e713d2475153542fead56547.jpg",
                    fit: BoxFit.cover,
                  ),
                  height: 200,
                  width: double.infinity,
                ),
                const Positioned(
                  bottom: 20,
                  left: 10,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                      "https://i.pinimg.com/236x/e4/08/de/e408dedf20f4fbc5bb96bc0f257e239c.jpg",
                    ),
                  ),
                ),
                Positioned(
                  bottom: 35,
                  right: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.blueAccent),
                          foregroundColor:
                              const MaterialStatePropertyAll(kBlack),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Follow',
                          style: TextStyle(color: kWhite),
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
                  ),
                ),
                const Positioned(
                  top: 20,
                  left: 15,
                  child: Icon(
                    CupertinoIcons.back,
                    size: 25,
                  ),
                ),
                const Positioned(
                    top: 20,
                    left: 60,
                    child: Text(
                      'sreeraj_cr',
                      style: TextStyle(fontSize: 18),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // kheight20,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sreeraj CR",
                              style:
                                  TextStyle(fontFamily: "kanit", fontSize: 20),
                            ),
                            // Text(
                            //   "Personal blog",
                            //   style: TextStyle(fontSize: 16),
                            // )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('Personal Blog'),
                  ),
                  kheight20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          profileText1('20'),
                          profileCardText2('Post')
                        ],
                      ),
                      Column(
                        children: [
                          profileText1('204k'),
                          profileCardText2('Followers')
                        ],
                      ),
                      Column(
                        children: [
                          profileText1('5k'),
                          profileCardText2('Following')
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                ],
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
              ),
              itemBuilder: (context, index) {
                return Container(
                  width: 20,
                  color: Colors.grey, // Adjust the color as needed
                  alignment: Alignment.center,
                  child: Text('Item $index'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
