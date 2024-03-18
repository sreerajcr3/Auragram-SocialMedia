import 'package:aura/core/constants/measurements.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: TextButton.icon(
          onPressed: () {
            logOut(context);
          },
          icon: const Icon(Icons.logout),
          label: const Text('Log out'),
        ),
      ),
      appBar: AppBar(
        title: const AppName(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) => storyCircle()),
              ),
            ),
            Container(
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/564x/aa/0b/e5/aa0be59d128a0d0293187b0481b5514a.jpg'),
                        ),
                        kwidth10,
                        const Text(
                          "Sreeraj",
                          style: TextStyle(),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.more_vert),
                        )
                      ],
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(
                        minWidth: double.infinity,
                        maxHeight: 400,
                        minHeight: 300),
                    width: double.infinity,
                    // height: 400,
                    child: Image.network(
                      "https://i.pinimg.com/564x/a4/97/1d/a4971de40fb7774409d85d3d581cb5f4.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border_outlined)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(CupertinoIcons.chat_bubble)),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.share)),
                    ],
                  ),
                  // const Divider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sreeraj',
                          style: TextStyle(fontFamily: "kanit", fontSize: 18),
                        ),
                        Text('Lets get lost together'),
                        Text(
                          'View all 18 comments',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        Text(
                          '29 minutes ago',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            kheight20,
            Container(
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://i.pinimg.com/564x/aa/0b/e5/aa0be59d128a0d0293187b0481b5514a.jpg'),
                        ),
                        kwidth10,
                        const Text("Sreeraj"),
                        const Spacer(),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.more_vert))
                      ],
                    ),
                  ),
                  Container(
                    constraints: const BoxConstraints(
                        minWidth: double.infinity,
                        maxHeight: 400,
                        minHeight: 300),
                    width: double.infinity,
                    // height: 400,
                    child: Image.network(
                      "https://i.pinimg.com/564x/a7/47/0a/a7470aac68cecdb2914327a39a44df68.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.chat_bubble),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.share),
                      ),
                    ],
                  ),
                  // const Divider(),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sreeraj',
                          style: TextStyle(fontFamily: "kanit", fontSize: 18),
                        ),
                        Text('Lets get lost together'),
                        Text(
                          'View all 18 comments',
                          style: TextStyle(color: Colors.blueGrey),
                        ),
                        Text(
                          '29 minutes ago',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

storyCircle() {
  return const Padding(
    padding: EdgeInsets.all(5.0),
    child: CircleAvatar(
      radius: 35,
      backgroundImage: NetworkImage(
          "https://i.pinimg.com/564x/ab/5d/90/ab5d90b525e28f8f014bd76af8fb153d.jpg"),
    ),
  );
}
