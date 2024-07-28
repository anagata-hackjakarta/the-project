import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:safina/model/analyzeRequestModel.dart';
import 'package:safina/model/analyzeResponseModel.dart';
import 'package:safina/model/loginRequestModel.dart';
import 'package:safina/model/registerRequestModel.dart';
import 'package:safina/model/registerResponseModel.dart';

class Services {
  Future<RegisterResponseModel> getData() async {
    late RegisterResponseModel data;
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/comments/1'),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        data = RegisterResponseModel.fromJson(
            item); // Mapping json response to our data model
      } else {
        print('Error Occurred');
      }
    } catch (e) {
      print('Error Occurred' + e.toString());
    }
    return data;
  }

  static Future<RegisterResponseModel> doRegister(
      RegisterRequestModel req) async {

    late RegisterResponseModel data;
    try {
      print("Masuk isniii");

      final requestBody = json.encode(req.toJson().map((key, value) => MapEntry(key, value.toString())));

      final response = await http.post(
          Uri.parse('https://api-himeko.thatismunn.my.id/v1/register'),
          headers: {'Content-Type': 'application/json'},
          body: requestBody);

      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        data = RegisterResponseModel.fromJson(
            item); // Mapping json response to our data model
      } else {
        data = RegisterResponseModel();
        data.message = "Something went wrong";
        print('Error Occurred');
      }
    } catch (e) {
      print('Error Occurred [REGISTER REQUEST]' + e.toString());
    }
    return data;
  }

  static Future<RegisterResponseModel> doLogin(LoginRequestModel req) async {
    late RegisterResponseModel data;
    try {
      final response = await http.post(
        Uri.parse('https://api-himeko.thatismunn.my.id/v1/login'),
        body: json.encode(req.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        data = RegisterResponseModel.fromJson(
            item); // Mapping json response to our data model
      } else if (response.statusCode == 404) {
        data = RegisterResponseModel();
        data.user = null;
      } else {
        print('Error Occurred [LOGIN REQUEST]');
      }
    } catch (e) {
      // throw if 404 response RegisterResponseModel.user is null
      if (e is http.ClientException && e.message.contains('404')) {
        data.user = null;
      } else {
        print('Error Occurred [LOGIN REQUEST]' + e.toString());
      }
    }
    return data;
  }

  static Future<AnalyzeResponseModel> anlyze(AnalyzeRequestModel req) async {
    late AnalyzeResponseModel data;
    try {
      final response = await http.post(
        Uri.parse('https://ai-api-himeko.thatismunn.my.id/v1/analyze'),
        body: json.encode(req.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        data = AnalyzeResponseModel.fromJson(
            item); // Mapping json response to our data model
      } else {
        print('Error Occurred [LOGIN REQUEST]');
      }
    } catch (e) {
      // throw if 404 response RegisterResponseModel.user is null
      print('Error Occurred [LOGIN REQUEST]' + e.toString());
    }
    return data;
  }


}
