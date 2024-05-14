// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:aura/bloc/edit_profile/bloc/edit_profile_bloc.dart';
import 'package:aura/bloc/image_picker/bloc/image_picker_bloc.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/core/constants/user_demo_pic.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/bottom_navigation/bottom_navigation.dart';
import 'package:aura/presentation/screens/profile/widgets/widgets.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class EditProfile extends StatefulWidget {
  final User user;
  const EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController usernameController;
  late TextEditingController fullnameeController;
  late TextEditingController bioController;
  File? profileImage;
  File? coverImage;

  @override
  void initState() {
    usernameController = TextEditingController(text: widget.user.username!);
    fullnameeController = TextEditingController(text: widget.user.fullname!);
    bioController = TextEditingController(text: widget.user.bio!);
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          text: "Edit Profile",
          context: context,
          onPressed: () {
            context.read<EditProfileBloc>().add(AddDetailsEditProfileEvent(
                username: usernameController.text,
                fullname: fullnameeController.text,
                profilePic: profileImage ?? widget.user.profilePic,
                coverPic:coverImage ?? widget.user.coverPic,
                bio: bioController.text));
          },
          icon: const Text(
            'Save',
            style: TextStyle(fontSize: 18),
          )),
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state is EditProfileSuccessState) {
          indexChangeNotifier.value = 4;
            snackBar("Profile Edited", context);
            navigatorPush(const CustomBottomNavigationBar(), context);
          }
          else if(state is EditProfileLoadingState){
              loading();
          }
        },
        builder: (context, state) {
          return BlocConsumer<ImagePickerBloc, ImagePickerState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ProfilePicImagePickerSuccessState) {
                profileImage = state.image;
              }
              if (state is CoverPicImagePickerSuccessState) {
                coverImage = state.image;
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 250,
                          // color: Colors.green,
                          // width: 100,
                        ),
                        Positioned(
                          // top: 120,

                          child: Container(
                              height: 150,
                              width: MediaQuery.sizeOf(context).width,
                              color: Colors.grey.shade200,
                              child:widget.user.coverPic!=""? coverImage == null
                                  ? Image.network(
                                      widget.user.coverPic!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      coverImage!,fit: BoxFit.cover,
                                    ):const Icon(Ionicons.camera))
                        ),
                        Positioned(
                          top: 100,
                          left: MediaQuery.sizeOf(context).width * 0.31,
                          //  right: MediaQuery.sizeOf(context).width/2,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                  radius: 70,
                                  backgroundImage:widget.user.profilePic !=""? profileImage == null
                                      ? NetworkImage(widget.user.profilePic!)
                                      : Image.file(profileImage!).image:const NetworkImage(demoProPic)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    kheight20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        containerTextButton("Edit Profile pic", () async {
                          final image = await pickProfilePic();
                          context.read<ImagePickerBloc>().add(
                                AddProfilePicEvent(image: image!),
                              );
                        },  Theme.of(context).colorScheme.secondary,context),
                        containerTextButton("Edit Cover pic", () async {
                          final image = await pickCoverPic();
                          context
                              .read<ImagePickerBloc>()
                              .add(AddCoverPicEvent(image: image));
                        },  Theme.of(context).colorScheme.secondary,context),
                      ],
                    ),
                    kheight30,
                    TextformField(
                        labelText: "Full name",
                        controller: fullnameeController),
                    kheight20,
                    TextformField(
                        labelText: "Username", controller: usernameController),
                    kheight20,
                    TextformField(
                        labelText: "About", controller: bioController),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }


}
