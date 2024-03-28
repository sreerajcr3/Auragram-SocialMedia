import 'package:aura/core/urls/url.dart';
import 'package:aura/presentation/functions/functions.dart';
import 'package:http/http.dart' as http;

class ApiServiceLikeUnlike {
  static var client = http.Client();

  static Future<void> like(id) async {
    final url = "${ApiEndPoints.baseUrl}${ApiEndPoints.like}$id";

    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await client.patch(Uri.parse(url), headers: headers);
    print("likeSUccess State = ${response.statusCode}");
    print("like body:${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      
    }
  }



  static Future<void> unlike(id) async {
    final url = "${ApiEndPoints.baseUrl}${ApiEndPoints.unlike}$id";

    final token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await client.patch(Uri.parse(url), headers: headers);
    print("unlike State = ${response.statusCode}");
    print("unlike body:${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      
    }
  }
}
