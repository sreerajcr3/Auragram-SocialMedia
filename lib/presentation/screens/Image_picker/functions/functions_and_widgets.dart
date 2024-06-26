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

postTextfield(hintText, controller, {Widget? button}) {
  return SizedBox(
    child: TextFormField(
      style:const TextStyle(fontSize: 18),
      controller: controller,
      decoration: InputDecoration(
        
        hintText: hintText,
        suffixIcon: button,
        border: const UnderlineInputBorder(borderSide: BorderSide.none),
      ),
    ),
  );
}
