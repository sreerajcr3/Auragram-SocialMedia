//   import 'package:aura/presentation/screens/Image_picker/demo.dart';
import 'package:flutter/material.dart';
// import 'package:wechat_assets_picker/wechat_assets_picker.dart';

// Future pickAssets(
//        int maxCount,  RequestType requestType,context,setSytate) async {
//     final result = await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (ctx) {
//           return MediaPicker(maxCount: maxCount, requestType: requestType);
//         },
//       ),
//     );
//     if (result != null) {
//       setState(() {
//         selectedAssetList = List<AssetEntity>.from(result);

//         print("object:$selectedAssetList");
//       });
//     }
//   }


postTextfield(hintText,controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }