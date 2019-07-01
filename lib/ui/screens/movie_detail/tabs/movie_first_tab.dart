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
        color: Colors.red,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              width: 400,
              padding: EdgeInsets.all(50),
              child: new CustomPaint(
                foregroundPainter: RibbonWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
