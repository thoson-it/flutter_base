import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/base/bloc_provider.dart';
import 'package:flutter_base/blocs/movie_bloc.dart';

class MovieThirdTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MovieThirdTabState();
  }
}

class _MovieThirdTabState extends State<MovieThirdTab>
    with AutomaticKeepAliveClientMixin<MovieThirdTab> {
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
        color: Colors.blue,
        child: StreamBuilder(
            initialData: 0,
            stream: _movieBloc.outMoviesStream,
            builder: (context, snapshot) {
              return Center(
                child: Text(
                  "Value ${snapshot.data}",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }),
      ),
    );
  }
}
