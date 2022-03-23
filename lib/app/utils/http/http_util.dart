import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kurs_sabak8_weather/app/utils/constants/texts/app_texts.dart';

class HttpUtil {
  //get
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    Object body,
    Map<String, String> headers,
  }) async {
    var client = http.Client();
    final _url = AppTexts.baseUrl + endpoint;
    try {
      Uri _uri = Uri.parse(_url);
      final response = await client.get(_uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;

        return json.decode(body) as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //post
  static Future<Map<String, dynamic>> post({
    String url,
    Object body,
    Map<String, String> headers,
  }) async {
    var client = http.Client();
    try {
      Uri _uri = Uri.parse(url);
      final response = await client.post(_uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;

        return json.decode(body) as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //delete
  static Future<Map<String, dynamic>> delete({
    String url,
    Object body,
    Map<String, String> headers,
  }) async {
    var client = http.Client();
    try {
      Uri _uri = Uri.parse(url);
      final response = await client.delete(_uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;

        return json.decode(body) as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //update
  static Future<Map<String, dynamic>> update({
    String url,
    Object body,
    Map<String, String> headers,
  }) async {
    var client = http.Client();
    try {
      Uri _uri = Uri.parse(url);
      final response = await client.put(_uri);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = response.body;

        return json.decode(body) as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
