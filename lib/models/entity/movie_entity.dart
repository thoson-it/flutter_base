import '../base_entity.dart';

class MovieEntity extends BaseEntity {
  int id = 0;
  int voteCount = 0;
  bool video = false;
  double voteAverage = 0;
  String title = '';
  double popularity = 0.0;
  String posterPath = '';
  String originalLanguage = '';
  String originalTitle = '';
  List<int> genreIds = [];
  String backdropPath = '';
  bool adult = false;
  String overview = '';

  MovieEntity();

  MovieEntity.fromJson(Map<String, dynamic> json) {
    parseJson(json);
  }

  @override
  void parseJson(Map<String, dynamic> json) {
    id = json['id'];
    voteCount = json['vote_count'];
    video = json['video'];
    voteAverage = json['vote_average'].toDouble();
    title = json['title'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
//    genreIds = json['genre_ids'];
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vote_count': voteCount,
      'video': video,
      'vote_average': voteAverage,
      'title': title,
      'popularity': popularity,
      'poster_path': posterPath,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'backdrop_path': backdropPath,
      'adult': adult,
      'overview': overview,
    };
  }

  String getPosterPath() {
    return 'https://image.tmdb.org/t/p/w185' + posterPath;
  }
}
