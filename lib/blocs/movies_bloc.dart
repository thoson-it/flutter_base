import 'package:flutter_base/api/app_api.dart';
import 'package:flutter_base/models/entity/movie_entity.dart';
import 'package:flutter_base/models/enums/load_type.dart';
import 'package:flutter_base/models/states/movies_state.dart';
import 'package:rxdart/rxdart.dart';
import '../main.dart';
import 'base/bloc_provider.dart';

class MoviesBloc extends BlocBase {
  List<MovieEntity> _movies = List<MovieEntity>();
  LoadType _loadType = LoadType.NONE;
  int _currentPage = 1;

  /// In load movie
  BehaviorSubject<LoadType> _loadMoviesController =
      new BehaviorSubject<LoadType>();

  Sink<LoadType> get inLoadMoviesSink => _loadMoviesController.sink;

  /// Out movies
  BehaviorSubject<MoviesState> _moviesController =
      new BehaviorSubject<MoviesState>();

  Stream<MoviesState> get outMoviesStream => _moviesController.stream;

  MoviesBloc() {
    _loadMoviesController.stream.listen(_onRequestLoadMovies);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loadMoviesController.close();
    _moviesController.close();
  }

  void _onRequestLoadMovies(LoadType loadType) {
    //Check is loading data
    if (_loadType != LoadType.NONE) return;
    //
    int page = _currentPage;
    switch (loadType) {
      case LoadType.INITIAL:
        page = 1;
        _onResponseMovies(MoviesLoading());
        break;
      case LoadType.REFRESH:
        page = 1;
        _movies.clear();
        break;
      case LoadType.MORE:
        page += 1;
        break;
      case LoadType.NONE:
        return;
    }

    appApi.fetchMovies(page, kApiKey).then((response) {
      if (response.status == true) {
        switch (loadType) {
          case LoadType.INITIAL:
          case LoadType.REFRESH:
            _movies = response.dataList;
            if (_movies.isNotEmpty) {
              _onResponseMovies(MoviesLoaded(list: _movies));
            } else {
              _onResponseMovies(MoviesEmpty());
            }
            break;
          case LoadType.MORE:
            _movies.addAll(response.dataList);
            _onResponseMovies(MoviesLoaded(list: _movies));
            break;
          default:
            break;
        }
        //Set current page
        if (response.page <= response.totalPages) {
          _currentPage = response.page;
        }
      } else {
        switch (loadType) {
          case LoadType.INITIAL:
            _onResponseMovies(MoviesError());
            break;
          case LoadType.REFRESH:
            _onResponseMovies(MoviesError());
            break;
          default:
            break;
        }
      }
    });
  }

  void _onResponseMovies(MoviesState state) {
    _moviesController.sink.add(state);
  }
}
