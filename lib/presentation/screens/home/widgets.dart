import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';

class Date extends StatelessWidget {
  final String date;
  const Date({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(date);

    DateFormat formattedDate = DateFormat.yMMMd();
    String finaldate = formattedDate.format(dateTime);

    return Text(
      finaldate,
      style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
    );
  }
}

class SkeletonCard extends StatelessWidget {
  const SkeletonCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const CircleAvatar(),
                kwidth10,
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 220, 217, 217),
                      borderRadius: BorderRadius.circular(20)),
                  width: 100,
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 220, 217, 217),
                borderRadius: BorderRadius.circular(30)),
          ),
          kheight15,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 150,
              height: 30,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 217, 217),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 150,
              height: 12,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 217, 217),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 250,
              height: 12,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 220, 217, 217),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          kheight15
        ],
      ),
    );
  }
}

// Widget buildVideoPlayer(mediaUrl) {
//   final videoPlayerController = VideoPlayerController.networkUrl(
//     Uri.parse(mediaUrl),
//     httpHeaders: {"Authorization": "334583943739261"},
//   );

//   return FlickVideoPlayer(
//     flickManager: FlickManager(
//       videoPlayerController: videoPlayerController,
//     ),
//   );
// }

class VideoPlayerWIdget extends StatefulWidget {
  final String mediaUrl;
  const VideoPlayerWIdget({super.key, required this.mediaUrl});

  @override
  State<VideoPlayerWIdget> createState() => _VideoPlayerWIdgetState();
}

class _VideoPlayerWIdgetState extends State<VideoPlayerWIdget> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    //demo check video = https://www.youtube.com/watch?v=W6-O00alJUo
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.mediaUrl),
      httpHeaders: {"Authorization": "334583943739261"},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlickVideoPlayer(
      flickManager: FlickManager(
        autoPlay: false,
        videoPlayerController: videoPlayerController,
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
            "https://i.pinimg.com/564x/20/c0/0f/20c00f0f135c950096a54b7b465e45cc.jpg"),
      ));
}

skeltonStory() {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ltr,
    enabled: true,
    baseColor: kGrey,
    highlightColor: Colors.white,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            10,
            (index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    backgroundColor: kGrey,
                    radius: 35,
                  ),
                )),
      ),
    ),
  );
}

Shimmer shimmer() {
  return Shimmer.fromColors(
    direction: ShimmerDirection.ttb,
    enabled: true,
    baseColor: kGrey,
    highlightColor: Colors.white,
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (ctx, index) {
        return const SkeletonCard();
      },
    ),
  );
}

bool pressed = false;
IconButton postIconButton(IconData icon1,map) {
  return IconButton(
    onPressed: () {
     print("chap icon map:$map");
    },
    icon:  Icon(icon1) ,
  );
}

class CustomAlertDialogue extends StatelessWidget {
  final Text title;
  final Text content;
  final void Function() onPressed;

  const CustomAlertDialogue(
      {super.key,
      required this.title,
      required this.content,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  title,
      content: content,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Text("cancel")),
        IconButton(onPressed: onPressed, icon: const Text("ok")),
      ],
    );
  }
}
