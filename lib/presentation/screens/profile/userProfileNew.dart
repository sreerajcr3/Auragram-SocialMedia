import 'package:aura/bloc/currentUser_profile/bloc/current_user_bloc.dart';
import 'package:aura/bloc/follow_unfollow/bloc/follow_unfollow_bloc.dart';
import 'package:aura/bloc/get_user/get_user_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/domain/model/get_user_model.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/profile/userProfile.dart';
import 'package:aura/presentation/screens/profile/widgets.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_consumer.dart';

class UserProfileSccreen extends StatefulWidget {
  final User user;
  const UserProfileSccreen({super.key, required this.user});

  @override
  State<UserProfileSccreen> createState() => _UserProfileSccreenState();
}

class _UserProfileSccreenState extends State<UserProfileSccreen> {
  bool? follow;
  @override
  void initState() {
    context.read<GetUserBloc>().add(GetuserFetchEvent(userId: widget.user.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    // var width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: customAppbar(text: "My Profile", context: context,onPressed: (){},icon: Container()),
      body: MultiBlocConsumer(
        buildWhen: null,
        listenWhen: null,
        listener: (context, state) {
          if (state[2] is FollowUpdatedState) {
            // context
            //     .read<GetUserBloc>()
            //     .add(GetuserFetchEvent(userId: widget.user.id!));
            // context.read<CurrentUserBloc>().add(CurrentUserFetchEvent());
          }
        },
        blocs: [
          context.watch<CurrentUserBloc>(),
          context.watch<GetUserBloc>(),
          context.watch<FollowUnfollowBloc>(),
        ],
        builder: (context, state) {
          if (state[1] is GetUsersuccessState) {
            final GetUserModel fetchedUser = state[1].getUserModel;

            if (state[0] is CurrentUserSuccessState) {
              follow =
                  state[0].currentUser.followingIdsList.contains(widget.user.id)
                      ? true
                      : false;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        if (state[1] is GetUsersuccessState)
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            height: height / 2.6,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  height: height / 5,
                                  // color: Colors.green,
                                  child: fetchedUser.user.coverPic == ""
                                      ? Image.asset(
                                          "assets/images/AURAGRAM Cover phot.jpg",
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          fetchedUser.user.coverPic!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        Positioned(
                            top: 150,
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: height,
                              decoration: BoxDecoration(
                                gradient:
                                    LinearGradient(colors: [kGrey, kWhite]),
                                // color: Colors.yellow,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            )),
                        if (state[1] is GetUsersuccessState)
                          Positioned(
                              top: height / 8,
                              left: 30,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    state[1].getUserModel.user.profilePic ??
                                        demoProPic),
                                radius: 50,
                              )),
                        Positioned(
                          top: height / 3.7,
                          left: 20,
                          child: Text(
                            state[1].getUserModel.user.fullname!,
                            style: const TextStyle(
                              fontFamily: "JosefinSans",
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Positioned(
                          top: height / 3.2,
                          left: 20,
                          child: Text(
                            state[1].getUserModel.user.bio!,
                            style: const TextStyle(
                              fontFamily: "kanit",
                              fontSize: 17,
                            ),
                          ),
                        ),
                        if (state[2] is FollowUpdatedState)
                          Positioned(
                            top: height / 4.5,
                            right: MediaQuery.sizeOf(context).width * .03,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                  
                                    follow!
                                        ? context
                                            .read<FollowUnfollowBloc>()
                                            .add(ToUnfollowEvent(
                                                userId: widget.user.id!))
                                        : context
                                            .read<FollowUnfollowBloc>()
                                            .add(TofollowEvent(
                                                userId: widget.user.id!));
                                    // follow!?false:true;
                                  },
                                  child: follow!
                                      ? followUnfollowButton(
                                          "Following", color: kgreen, follow)
                                      : followUnfollowButton("Follow", follow),
                                ),
                                kwidth20,
                                Container(
                                  alignment: Alignment.topCenter,
                                 
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    // color: kBlack,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: containerButton("Message", () => null,Colors.transparent)
                                )
                              ],
                            ),
                          )
                      ],
                    ),
                    profileCountCard(
                      state[1],
                    ),
                    IconButton(onPressed: (){navigatorPush(UserProfile(user: widget.user,), context);}, icon: Icon(Icons.ac_unit_outlined)),
                    state[1].getUserModel.posts.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state[1].getUserModel.posts.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 1,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 20,
                                  color:
                                      Colors.grey, // Adjust the color as needed
                                  alignment: Alignment.center,
                                  child: Image.network(
                                    state[1]
                                        .getUserModel
                                        .posts[index]
                                        .mediaURL![0],
                                    fit: BoxFit.fitWidth,
                                  ),
                                );
                              },
                            ),
                          )
                        : emptyMessage()
                  ],
                ),
              );
            } else {
              return loading();
            }
          } else {
            return loading();
          }
        },
      ),
    );
  }
}

class SteppedSlopeClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height / 2.5);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
