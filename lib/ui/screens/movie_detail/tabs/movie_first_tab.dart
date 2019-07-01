import 'package:flutter/material.dart';
import 'package:flutter_base/ui/widgets/customs/ribbon_widget.dart';

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
        height: 200.0,
        width: 500.0,
        padding: EdgeInsets.all(50),
        color: Colors.red,
        child: new CustomPaint(
          foregroundPainter: RibbonWidget(cornerRadius: 10),
        ),
      ),
    );
  }
}
