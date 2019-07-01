import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/base/bloc_provider.dart';
import 'package:flutter_base/blocs/movie_bloc.dart';

class MovieSecondTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MovieSecondTabState();
  }
}

class _MovieSecondTabState extends State<MovieSecondTab>
    with AutomaticKeepAliveClientMixin<MovieSecondTab> {
  MovieBloc _movieBloc;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _movieBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: RaisedButton(
            child: Text("Add"),
            onPressed: () {
              _movieBloc.inLoadMoviesSink.add(1);
            },
          ),
        ),
      ),
    );
  }
}
