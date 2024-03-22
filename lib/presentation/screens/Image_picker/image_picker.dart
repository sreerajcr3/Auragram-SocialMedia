import 'package:aura/bloc/create_post/bloc/create_post_bloc.dart';
import 'package:aura/core/colors/colors.dart';
import 'package:aura/core/constants/measurements.dart';
import 'package:aura/domain/api_repository/repository.dart';
import 'package:aura/domain/image_picker/photo_picker.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:aura/presentation/screens/Image_picker/demo.dart';
import 'package:aura/presentation/screens/Image_picker/functions/functions_and_widgets.dart';
import 'package:aura/presentation/screens/bottom_navigation.dart';
import 'package:aura/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];

  final descriptionController = TextEditingController();
  final locationController = TextEditingController();

  @override
  void initState() {
    MediaServices().loadAlbums(RequestType.common).then((value) {
      setState(() {
        albumList = value;
        selectedAlbum = value[0];
        print("selected albums:${albumList}");
      });
      MediaServices().loadAssets(selectedAlbum!).then((value) {
        setState(() {
          assetList = value;
        });
      });
    });
    super.initState();
  }

  Future pickAssets(
      {required int maxCount, required RequestType requestType}) async {
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return MediaPicker(maxCount: maxCount, requestType: requestType);
    }));
    if (result != null) {
      setState(() {
        selectedAssetList = List<AssetEntity>.from(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New post",
          style: TextStyle(fontFamily: "kanit"),
        ),
      ),
      body: BlocConsumer<CreatePostBloc, CreatePostState>(
        listener: (context, state) {
          if (state is CreatePostSuccessState) {
            navigatorReplacement(const CustomBottomNavigationBar(), context);
          } else if (state is CreatePostOopsState) {
            snackBar("Oops..! Please try again", context);
          } else if (state is CreatePostErrorState) {
            snackBar("Oops..! Server unreachable", context);
          } else if (state is CreatePostLoadingState) {
            Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: kBlack, size: 10),
            );
          } else {}
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      pickAssets(maxCount: 10, requestType: RequestType.common);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 400,
                      child: Column(
                        children: [
                          Expanded(
                            child: selectedAssetList.isNotEmpty
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: selectedAssetList.length,
                                    itemBuilder: (ctx, index) {
                                      AssetEntity assetEntity =
                                          selectedAssetList[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          child: Stack(
                                            children: [
                                              Positioned.fill(
                                                child: AssetEntityImage(
                                                  assetEntity,
                                                  isOriginal: false,
                                                  thumbnailSize:
                                                      const ThumbnailSize
                                                          .square(1000),
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Center(
                                                      child: Icon(Icons.error),
                                                    );
                                                  },
                                                ),
                                              ),
                                              if (assetEntity.type ==
                                                  AssetType.video)
                                                const Positioned.fill(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Icon(
                                                          Icons.video_call),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                : Card(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                            child: IconButton(
                                                onPressed: () {
                                                  pickAssets(
                                                      maxCount: 10,
                                                      requestType:
                                                          RequestType.common);
                                                },
                                                icon: const Icon(
                                                    Icons.camera_alt))),
                                        const Text("Select image"),
                                      ],
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  kheight20,
                  postTextfield("Write a caption....", descriptionController),
                  kheight20,
                  postTextfield("Select location.....", locationController),
                  kheight30,
                  CustomButton(
                    text: "Post",
                    onPressed: () async {
                      final images =
                          await ApiService.uploadImage(selectedAssetList);
                      context.read<CreatePostBloc>().add(
                            Createpost(
                                images: images,
                                description: descriptionController.text,
                                location: locationController.text),
                          );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
