import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/movies_bloc.dart';
import 'package:flutter_base/models/entity/movie_entity.dart';
import 'package:flutter_base/models/enums/load_type.dart';
import 'package:flutter_base/models/states/movies_state.dart';
import 'package:flutter_base/ui/screens/movie_detail/movie_screen.dart';
import 'package:flutter_base/ui/widgets/cells/loading_cell.dart';
import 'package:flutter_base/ui/widgets/cells/movie_cell.dart';
import 'package:flutter_base/ui/widgets/customs/reload_button_widget.dart';
import 'package:flutter_base/utilities/app_colors.dart';
import 'package:flutter_base/utilities/app_dimens.dart';
import 'package:flutter_base/utilities/app_images.dart';

class MoviesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MoviesScreenState();
  }
}

class _MoviesScreenState extends State<MoviesScreen> {
  //Bloc
  MoviesBloc _bloc;

  //Properties
  List<MovieEntity> _movies = List<MovieEntity>();

  //Widget controller
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = MoviesBloc();
    _bloc.inLoadMoviesSink.add(LoadType.INITIAL);
    //
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          title: Text('Movies', style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            FlatButton(onPressed: (){}, child: Image.asset(AppImages.icSettingKey))
          ],
        ),
        preferredSize: Size.fromHeight(AppDimens.appBarHeight),
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
    _scrollController.dispose();
  }

  ///Build widget

  Widget _buildBodyWidget() {
    return Container(
      child: StreamBuilder(
          stream: _bloc.outMoviesStream,
          builder: (context, snapshot) {
            MoviesState state = snapshot.data;
            if (state is MoviesLoading) {
              return _buildLoadingList();
            } else if (state is MoviesLoaded) {
              _movies = state.list;
              return _buildMovieList();
            } else if (state is MoviesEmpty) {
              return _buildEmptyList();
            } else {
              return _buildErrorList();
            }
          }),
    );
  }

  Widget _buildMovieList() {
    Widget listWidget = Container(
      margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
      color: AppColors.backgroundColor,
      child: GridView.builder(
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 3 / 4),
          itemCount: _movies.length,
          itemBuilder: (context, index) {
            return MovieCell(_movies[index], _handleSelectedMovie);
          }),
    );
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      child: listWidget,
      onRefresh: _onRefreshList,
    );
  }

  Widget _buildLoadingList() {
    return Container(
      margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
      color: AppColors.backgroundColor,
      child: GridView.count(
        childAspectRatio: 3 / 4,
        crossAxisCount: 2,
        children: new List<Widget>.generate(
          10,
          (index) {
            return LoadingCell();
          },
        ),
      ),
    );
  }

  Widget _buildEmptyList() {
    return Container(
      child: Center(
        child: ReloadButtonWidget(
          title: "Data empty",
          onPressed: () {
            _bloc.inLoadMoviesSink.add(LoadType.REFRESH);
          },
        ),
      ),
    );
  }

  Widget _buildErrorList() {
    return Container(
      child: Center(
        child: ReloadButtonWidget(
          title: "Data error",
          onPressed: () {
            _bloc.inLoadMoviesSink.add(LoadType.INITIAL);
          },
        ),
      ),
    );
  }

  ///Widget controller
  Future<Null> _onRefreshList() {
    _bloc.inLoadMoviesSink.add(LoadType.REFRESH);
    return Future.delayed(const Duration(seconds: 0));
  }

  //Scroll listener
  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      //reach the bottom
      _bloc.inLoadMoviesSink.add(LoadType.MORE);
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      //reach the top
    }
  }

  /// Handler

  void _handleSelectedMovie(MovieEntity movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieScreen(),
      ),
    );
  }
}
