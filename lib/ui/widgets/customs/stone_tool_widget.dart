import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/ui/widgets/customs/stone_item_widget.dart';
import 'package:flutter_base/ui/widgets/customs/stones_viewer_widget.dart';

class StoneToolWidget extends StatefulWidget {
  _StoneToolWidgetState state;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    state = _StoneToolWidgetState();
    return state;
  }
}

class _StoneToolWidgetState extends State<StoneToolWidget> {
  final GlobalKey<State<DragTarget>> _dragTarget =
      new GlobalKey<State<DragTarget>>();

  double _braceletRadius = 0;

  StonesViewerWidget _stonesViewerWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stonesViewerWidget = StonesViewerWidget();
  }

  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      _braceletRadius =
          min<double>(constraint.maxWidth, constraint.maxHeight) / 2 - 20;
      return Container(
        color: Colors.grey,
        child: Stack(
          children: <Widget>[
            Center(
              child: Container(
                width: _braceletRadius * 2,
                height: _braceletRadius * 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey, width: 1.0),
                  borderRadius:
                      BorderRadius.all(Radius.circular(_braceletRadius)),
                ),
              ),
            ),
            _stonesViewerWidget,
            Container(
              alignment: Alignment.bottomCenter,
              height: 50,
              child: Row(
                children: <Widget>[
                  RaisedButton(
                      child: Text('Add'),
                      onPressed: () {
                        _stonesViewerWidget.state.addRandomStone();
                      }),
                ],
              ),
            ),
//          Container(
////            color: Colors.deepOrange,
//            child: DragTarget(
//              builder: (context, List<int> candidateData, rejectedData) {
//                print('candidateData $candidateData');
//                return StonesViewerWidget();
//              },
//              onWillAccept: (data) {
//                print('onWillAccept $data');
//                return true;
//              },
//              onAccept: (data) {
//                print('onAccept $data');
//              },
//              onLeave: (data) {
//                print('onLeave $data');
//              },
//            ),
//          ),
          ],
        ),
      );
    });
  }
}
