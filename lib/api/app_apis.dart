import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as DioLib;
import 'package:flutter_base/api/http_method.dart';
import 'package:flutter_base/api/response.dart';
import 'package:flutter_base/models/entity/movie_entity.dart';

import '../main.dart';

AppApis kAppApis = AppApis();

class AppApis {
  //Configs
  static const int TIMEOUT_DURATION = 30; //second
  //Base url
  static const String baseUrl = "api.themoviedb.org";

  //Path
  static const String moviesUrl = "/3/discover/movie";
  static const String uploadImageFileUrl = "/api/image/store";

  /// Routine to invoke the Web Server to get answers
  Future<Map<String, dynamic>> _callRequest(HttpMethod method, Uri uri,
      {Map<String, dynamic> body}) async {
    print(method.toString() + ": " + uri.toString());

    DioLib.Response response;
    DioLib.Dio dio = new DioLib.Dio();

    if ((kAppToken ?? "").isNotEmpty) {
      dio.options.headers = {
        'Authorization': 'Bearer ' + kAppToken,
        'content-type': 'application/json'
      };
    }

    try {
      switch (method) {
        case HttpMethod.GET:
          response = await dio.get(uri.toString(), queryParameters: body);
          break;
        case HttpMethod.POST:
          response = await dio.post(uri.toString(), queryParameters: body);
          break;
        case HttpMethod.PUT:
          response = await dio.put(uri.toString(), queryParameters: body);
          break;
        case HttpMethod.DELETE:
          response = await dio.delete(uri.toString(), queryParameters: body);
          break;
        case HttpMethod.PATCH:
          response = await dio.patch(uri.toString(), queryParameters: body);
          break;
      }
    } catch (e) {
      //Internet connection error
      return null;
    }

    print('Response ' + response.statusCode.toString());
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 401:
        return null;
      case 400:
        return null;
    }
    return null;
  }

  ///UploadImageFile
  Future<Map<String, dynamic>> _uploadFileImage(
      int type, File file, DioLib.ProgressCallback callBack) async {
    String url =
        (baseUrl + uploadImageFileUrl).replaceAll("{type}", type.toString());

    print("🔗" + url);

    DioLib.Response response;
    DioLib.Dio dio = new DioLib.Dio();

    if ((kAppToken ?? "").isNotEmpty) {
      dio.options.headers = {
        'Authorization': 'Bearer ' + kAppToken,
      };
    }

    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;

    DioLib.FormData formData = new DioLib.FormData.from({
      "image_file": DioLib.UploadFileInfo(file, "temp"),
    });
    try {
      response = await dio.post(
        url,
        data: formData,
        onSendProgress: callBack,
      );
    } catch (e) {
      return null;
    }

    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 401:
        return null;
      case 400:
        return null;
    }

    return null;
  }

  ///Fetch movies
  Future<Response<MovieEntity>> fetchMovies(int page, String apiKey) async {
    var uri = Uri.https(
      baseUrl,
      moviesUrl,
      <String, String>{
        'page': '$page',
        'api_key': apiKey,
      },
    );
    var response = await _callRequest(HttpMethod.GET, uri);
    Response<MovieEntity> myResponse = new Response(() => MovieEntity());
    myResponse.parseJson(response);
    return myResponse;
  }
}
