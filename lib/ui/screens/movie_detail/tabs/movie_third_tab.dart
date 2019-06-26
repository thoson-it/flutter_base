import 'package:flutter/material.dart';

class MovieThirdTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MovieThirdTabState();
  }
}

class _MovieThirdTabState extends State<MovieThirdTab>
    with AutomaticKeepAliveClientMixin<MovieThirdTab> {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.blue,
      ),
    );
  }
}
