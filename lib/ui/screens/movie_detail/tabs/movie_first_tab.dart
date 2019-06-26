import 'package:flutter/material.dart';

class MovieFirstTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MovieFirstTabState();
  }
}

class _MovieFirstTabState extends State<MovieFirstTab>
    with AutomaticKeepAliveClientMixin<MovieFirstTab> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
