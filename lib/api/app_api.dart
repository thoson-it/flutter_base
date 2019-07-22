import 'package:flutter_base/api/response.dart';
import 'package:flutter_base/models/entity/movie_entity.dart';
import 'package:flutter_base/utilities/app_configs.dart';
import 'api_client.dart';

AppApi appApi = AppApi();

class AppApi {
  ApiClient _apiClient = ApiClient();

  ///Base API
  static const String baseUrl = AppConfigs.apiBaseUrl;
  static const String baseUrlHttp = AppConfigs.apiBaseUrlHttp;

  ///Path
  static const String moviesUrl = "/3/discover/movie";
  static const String uploadImageFileUrl = "/api/image/store";

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
    var response = await _apiClient.getRequest(uri);
    Response<MovieEntity> myResponse = new Response(() => MovieEntity());
    myResponse.parseJson(response);
    return myResponse;
  }
}
