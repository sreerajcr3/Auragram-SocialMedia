import 'dart:developer';

import 'package:aura/core/urls/url.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:http/http.dart' as http;
class ApiServiceEditProfile {
   static var client = http.Client();

   static editprofile(String username, String fullname , String? bio , String? profilePic , String? coverpic)async{


    const url = ApiEndPoints.editProfile;
    final body = {"username":username,"fullname": fullname, "bio": bio,"profile_picture":profilePic,"cover_photo":coverpic};
    final token = getToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      try {
    final response=await client.patch(Uri.parse(url),body:body,headers: headers );
    if (response.statusCode== 200) {
      return true;
    }
        
      } catch (e) {
        log(e.toString());
       return false; 
      }
    
   }

  
}