import 'package:aura/domain/image_picker/photo_picker.dart';
import 'package:aura/presentation/screens/demo.dart';
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
        selectedAlbum =  value[0];
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
    final result = await Navigator.push(context, MaterialPageRoute(builder: (ctx){
  return MediaPickerDemo(maxCount: maxCount, requestType: requestType);
    }));
    if ( result != null) {
      setState(() {
       selectedAssetList = List<AssetEntity>.from(result);
      
        print("object:$selectedAssetList");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickAssets(maxCount: 10, requestType: RequestType.common);
        },
        child: const Icon(Icons.camera),
      ),
      body: GridView.builder(
        itemCount: selectedAssetList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          AssetEntity assetEntity = selectedAssetList[index];
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
                      child: Icon(Icons.video_call),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
