import 'package:aura/core/colors/colors.dart';
import 'package:aura/domain/image_picker/photo_picker.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MediaPicker extends StatefulWidget {
  final int maxCount;
  final RequestType requestType;
  const MediaPicker(
      {super.key, required this.maxCount, required this.requestType});

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];

  @override
  void initState() {
    MediaServices().loadAlbums(widget.requestType).then((value) {
      setState(() {
        albumList = value;
        selectedAlbum = value[0];
      });
      MediaServices().loadAssets(selectedAlbum!).then((value) {
        setState(() {
          assetList = value;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        foregroundColor: Colors.white,
        elevation: 0,
        title: DropdownButton<AssetPathEntity>(
          dropdownColor: kWhite,
          value: selectedAlbum,
          onChanged: (AssetPathEntity? value) {
            setState(() {
              selectedAlbum = value;
            });
            MediaServices().loadAssets(selectedAlbum!).then((value) {
              setState(() {
                assetList = value;
              });
            });
          },
          items: albumList.map<DropdownMenuItem<AssetPathEntity>>(
            (AssetPathEntity album) {
              return DropdownMenuItem<AssetPathEntity>(
                value: album,
                child: FutureBuilder<int>(
                  future: album.assetCountAsync,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text(
                          'Loading...');
                    } else if (snapshot.hasError) {
                      return Text(
                          'Error: ${snapshot.error}');
                    } else {
                      return Text(
                        "${album.name} (${snapshot.data})",
                      );
                    }
                  },
                ),
              );
            },
          ).toList(),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context, selectedAssetList);
            },
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  "Ok",
                  style: TextStyle(color: kWhite),
                ),
              ),
            ),
          )
        ],
        backgroundColor: kBlack,
      ),
      body: assetList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: assetList
                  .length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 5),
              itemBuilder: (context, index) {
                AssetEntity assetEntity = assetList[
                    index]; 
                return Stack(
                  children: [
                    Positioned.fill(
                      child: AssetEntityImage(
                        assetEntity,
                        isOriginal: false,
                        thumbnailSize: const ThumbnailSize.square(1000),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(Icons.error),
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
                            child: Icon(
                              Icons.video_call,
                              color: kWhite,
                            ),
                          ),
                        ),
                      ),
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          selectAsset(assetEntity: assetEntity);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                                color:
                                    selectedAssetList.contains(assetEntity) ==
                                            true
                                        ? Colors.blue
                                        : kBlack,
                                shape: BoxShape.circle,
                                border: Border.all(color: kWhite, width: 1.5)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "${selectedAssetList.indexOf(assetEntity) + 1}",
                                style: TextStyle(
                                    color: selectedAssetList
                                                .contains(assetEntity) ==
                                            true
                                        ? kWhite
                                        : Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                );
              },
            ),
    );
  }

  void selectAsset({required AssetEntity assetEntity}) {
    if (selectedAssetList.contains(assetEntity)) {
      setState(() {
        selectedAssetList.remove(assetEntity);
      });
    } else if (selectedAssetList.length < widget.maxCount) {
      setState(() {
        selectedAssetList.add(assetEntity);
      });
    }
  }
}
