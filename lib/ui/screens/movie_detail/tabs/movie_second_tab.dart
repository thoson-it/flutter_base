import 'package:flutter/material.dart';

class MovieSecondTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MovieSecondTabState();
  }
}

class _MovieSecondTabState extends State<MovieSecondTab>
    with AutomaticKeepAliveClientMixin<MovieSecondTab> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
