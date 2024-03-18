import 'package:aura/core/colors/colors.dart';
import 'package:aura/domain/image_picker/photo_picker.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class ImagePIcker extends StatefulWidget {
  const ImagePIcker({super.key});

  @override
  State<ImagePIcker> createState() => _ImagePIckerState();
}

class _ImagePIckerState extends State<ImagePIcker> {
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];

  @override
  void initState() {
    MediaServices().loadAlbums(RequestType.common).then((value) {
      setState(() {
        albumList = value;
         selectedAlbum = value.isNotEmpty ? value[0] : null; 
      });
    });
    MediaServices().loadAssets(selectedAlbum!).then((value) {
      setState(() {
        assetList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Flexible(
              child: Column(
            children: [
              SizedBox(
                height: height * 0.5,
              ),
              Row(
                children: [
                  if (selectedAlbum != null)
                    GestureDetector(
                      onTap: () {
                        albums(height);
                      },
                    ),
                  Text(
                    selectedAlbum!.name == "Recent"
                        ? "Gallery"
                        : selectedAlbum!.name,
                    style: const TextStyle(
                        color: kWhite,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  const Icon(Icons.arrow_downward)
                ],
              ),
              Flexible(
                  child: assetList.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4),
                          itemBuilder: (ctx, index) {
                            AssetEntity assetEntity = assetList[index];
                            return assetWidget(assetEntity);
                          }))
            ],
          ))
        ],
      ),
    );
  }

  void albums(height) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return ListView.builder(
              itemCount: albumList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (ctx, index) {
                return ListTile(
                  onTap: () {
                    setState(() {
                      selectedAlbum = albumList[index];
                    });
                    MediaServices().loadAssets(selectedAlbum!).then((value) {
                      setState(() {
                        assetList = value;
                      });
                    });
                  },
                  title: Text(albumList[index].name == "Recent"
                      ? "Gallery"
                      : albumList[index].name),
                );
              });
        });
  }

  Widget assetWidget(AssetEntity assetEntity) => Stack(children: [
        Positioned.fill(
          child: AssetEntityImage(
            assetEntity,
            isOriginal: false,
            thumbnailSize: ThumbnailSize.square(250),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              );
            },
          ),
        ),
        if (assetEntity.type == AssetType.video)
          const Positioned.fill(
              child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.video_camera_back),
            ),
          ))
      ]);
}
