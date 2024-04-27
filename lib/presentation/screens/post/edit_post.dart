import 'package:aura/bloc/edit_post/bloc/edit_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/commonData/common_data.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/Image_picker/functions/functions_and_widgets.dart';
import 'package:aura/presentation/screens/post/post_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../widgets/widgets.dart';

class EditPost extends StatefulWidget {
  final dynamic post;
  const EditPost({super.key, required this.post});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];
   String? postId;

  late TextEditingController descriptionController;
  late TextEditingController locationController;
  @override
  void initState() {
    
    descriptionController =
        TextEditingController(text: widget.post.description);
    locationController = TextEditingController(text: widget.post.location);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppbar(
          text: "Edit Post",
          context: context,
          onPressed: () async {
            editedList.add(widget.post.id);
            context.read<EditPostBloc>().add(PostEditEvent(
                description: descriptionController.text,
                location: locationController.text,
                postId: widget.post.id));
          },
          icon: const Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 3),
            child: Text(
              "Save",
              style: TextStyle(fontSize: 18, color: kblue),
            ),
          ),
        ),
        body: BlocConsumer<EditPostBloc, EditPostState>(
          listener: (context, state) {
            if (state is EditPostSuccessState) {
              navigatorPush(const PostDetailPage(), context);
              snackBar("Post edited", context);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 400,
                      child: Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.post.mediaURL.length,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                child: Image.network(
                                  widget.post.mediaURL[0],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    kheight20,
                    kheight20,
                    postTextfield(
                        widget.post.description, descriptionController),
                    kheight20,
                    kheight20,
                    postTextfield(widget.post.location, locationController),
                    kheight30,
                  ],
                ),
              ),
            );
          },
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
