import 'dart:io';

import 'package:dio/dio.dart' as DioLib;
import '../main.dart';
import 'http_method.dart';
import 'package:path/path.dart';

class ApiClient {
  ///Configs
  static const int CONNECT_TIMEOUT = 30000; //millisecond

  ///Open method
  Future<Map<String, dynamic>> getRequest(Uri uri,
      {Map<String, dynamic> query}) async {
    return await _callRequest(HttpMethod.GET, uri, query: query);
  }

  Future<Map<String, dynamic>> postRequest(Uri uri,
      {Map<String, dynamic> query, dynamic body}) async {
    return await _callRequest(HttpMethod.POST, uri, query: query, body: body);
  }

  Future<Map<String, dynamic>> putRequest(Uri uri,
      {Map<String, dynamic> query, dynamic body}) async {
    return await _callRequest(HttpMethod.PUT, uri, query: query, body: body);
  }

  //Download file
  Future<bool> downloadFile(
      Uri uri, File file, DioLib.ProgressCallback callBack) async {
    return _downloadFile(uri, file, callBack);
  }

  /// Routine to invoke the Web Server to get answers
  Future<Map<String, dynamic>> _callRequest(HttpMethod method, Uri uri,
      {Map<String, dynamic> query, dynamic body}) async {
    print('🔗' + method.toString() + ": " + uri.toString());

    DioLib.Response response;
    DioLib.Dio dio = new DioLib.Dio();

    dio.options.connectTimeout = CONNECT_TIMEOUT;

    if ((kAppToken ?? "").isNotEmpty) {
      dio.options.headers = {
        'Authorization': 'Bearer ' + kAppToken,
        'content-type': 'application/json'
      };
    }

    try {
      switch (method) {
        case HttpMethod.GET:
          response = await dio.get(uri.toString(), queryParameters: query);
          break;
        case HttpMethod.POST:
          response = await dio.post(uri.toString(),
              queryParameters: query, data: body);
          break;
        case HttpMethod.PUT:
          response =
              await dio.put(uri.toString(), queryParameters: body, data: body);
          break;
        case HttpMethod.DELETE:
          response = await dio.delete(uri.toString(),
              queryParameters: body, data: body);
          break;
        case HttpMethod.PATCH:
          response = await dio.patch(uri.toString(),
              queryParameters: body, data: body);
          break;
      }
    } catch (e) {
      //Internet connection error
      return null;
    }

    print('🔗' + '${response.statusCode}' + ": " + uri.toString());
    switch (response.statusCode) {
      case 200:
        print('Data ' + response.data.toString());
        return response.data;
      case 401:
        return null;
      case 400:
        return null;
    }
    return null;
  }

  ///UploadImageFile
  Future<Map<String, dynamic>> _uploadFile(
      Uri uri, File file, DioLib.ProgressCallback callBack) async {
    print('🔗' + 'Upload' + uri.toString());

    DioLib.Response response;
    DioLib.Dio dio = new DioLib.Dio();

    if ((kAppToken ?? "").isNotEmpty) {
      dio.options.headers = {
        'Authorization': 'Bearer ' + kAppToken,
      };
    }

    dio.options.connectTimeout = CONNECT_TIMEOUT;
    dio.options.receiveTimeout = 300000;

    DioLib.FormData formData = new DioLib.FormData.from({
      "image_file": DioLib.UploadFileInfo(file, basename(file.path)),
    });
    try {
      response = await dio.post(
        uri.path,
        data: formData,
        onSendProgress: callBack,
      );
    } catch (e) {
      return null;
    }

    print('🔗' + '${response.statusCode}' + ": " + uri.toString());
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

  //Download file
  Future<bool> _downloadFile(
      Uri uri, File file, DioLib.ProgressCallback callBack) async {
    print('🔗' + 'Download' + uri.path);

    DioLib.Response response;
    DioLib.Dio dio = new DioLib.Dio();

    if ((kAppToken ?? "").isNotEmpty) {
      dio.options.headers = {
        'Authorization': 'Bearer ' + kAppToken,
      };
    }

    dio.options.connectTimeout = CONNECT_TIMEOUT;
    dio.options.receiveTimeout = 300000;

    try {
      response = await dio.download(
        uri.toString(),
        file.path,
        onReceiveProgress: callBack,
      );
    } catch (e) {
      return false;
    }

    print('🔗' + '${response.statusCode}' + ": " + uri.toString());
    switch (response.statusCode) {
      case 200:
        return true;
      case 401:
        return false;
      case 400:
        return false;
      default:
        return false;
    }
  }

  void _handleUnauthorized() {
    //Dp something here
  }
}
