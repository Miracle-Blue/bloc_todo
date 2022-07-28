import 'dart:convert';
import 'package:http/http.dart';

class ApiProvider {
  static const url = '6209f31f92946600171c5604.mockapi.io';

  /* ! -> Headers --- */
  static Map<String, String> getHeaders() {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    return headers;
  }

  /* ! -> Http Request --- */
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(url, api, params);
    Response response = await get(uri, headers: getHeaders());

    print(response.body);

    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(url, api);
    Response response =
        await put(uri, headers: getHeaders(), body: jsonEncode(params));

    print(response.body);

    if (response.statusCode == 201) return response.body;
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(url, api);
    Response response =
        await post(uri, headers: getHeaders(), body: jsonEncode(params));

    print(response.body);

    if (response.statusCode == 201) return response.body;
    return null;
  }

  static Future<String?> DELETE(String api, Map<String, String> params) async {
    var uri = Uri.https(url, api, params);
    Response response = await delete(uri, headers: getHeaders());

    print(response.body);

    if (response.statusCode == 200) return response.body;
    return null;
  }
}
