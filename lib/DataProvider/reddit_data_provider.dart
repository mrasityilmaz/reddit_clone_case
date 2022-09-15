import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../Models/post_model.dart';
import '../Utils/ApiStatus/api_status.dart';
import '../Utils/Constants/api_constants.dart';

class RedditDataProvider {
  final Client httpClient;

  RedditDataProvider({required this.httpClient});

  Future<Object> getMainItems() async {
    try {
      var url = Uri.parse(redditGetMainItems);
      var response = await httpClient.get(url);

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);

        return Success(response: RedditPostModel.fromJson(responseJson));
      }
      return Failure(
        errorMessage: response.body,
      );
    } on HttpException {
      return Failure(errorMessage: "No Internet Connection");
    } on FormatException {
      return Failure(errorMessage: "Invalid Format");
    } on SocketException {
      return Failure(errorMessage: "No Internet Connection");
    } catch (e) {
      return Failure(errorMessage: "Invalid Error");
    }
  }
}
