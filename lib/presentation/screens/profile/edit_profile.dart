import 'dart:io';

import 'package:aura/bloc/image_picker/bloc/image_picker_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/domain/model/user_model.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
          onPressed: () {},
          icon: const Text(
            'Save',
            style: TextStyle(fontSize: 18),
          )),
      body: BlocConsumer<ImagePickerBloc, ImagePickerState>(
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
                        child: coverImage == null
                            ? Image.network(
                                widget.user.coverPic!,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                coverImage!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left: MediaQuery.sizeOf(context).width * 0.31,
                      //  right: MediaQuery.sizeOf(context).width/2,
                      child: Stack(
                        children: [
                          CircleAvatar(
                              radius: 70,
                              backgroundImage: profileImage == null
                                  ? NetworkImage(widget.user.profilePic!)
                                  : Image.file(profileImage!).image),
                        ],
                      ),
                    ),
                  ],
                ),
                kheight20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    containerButton("Edit Profile pic", () async {
                      final image = await pickProfilePic();
                      // ignore: use_build_context_synchronously
                      context.read<ImagePickerBloc>().add(
                            AddProfilePicEvent(image: image!),
                          );
                    }, kWhite),
                    containerButton("Edit Cover pic", () async {
                      final image = await pickCoverPic();
                      context
                          .read<ImagePickerBloc>()
                          .add(AddCoverPicEvent(image: image));
                    }, kWhite),
                  ],
                ),
                kheight30,
                TextformField(
                    labelText: "Full name", controller: fullnameeController),
                kheight20,
                TextformField(
                    labelText: "Username", controller: usernameController),
                kheight20,
                TextformField(labelText: "About", controller: bioController),
              ],
            ),
          );
        },
      ),
    );
  }

  pickProfilePic() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(pickedImage!.path);
  }

  pickCoverPic() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(pickedImage!.path);
  }
}
