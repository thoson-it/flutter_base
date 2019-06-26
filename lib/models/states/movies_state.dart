import 'package:flutter_base/models/entity/movie_entity.dart';

abstract class MoviesState {}

class MoviesEmpty extends MoviesState {}

class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  List<MovieEntity> list = List<MovieEntity>();

  MoviesLoaded({this.list});
}

class MoviesError extends MoviesState {}
