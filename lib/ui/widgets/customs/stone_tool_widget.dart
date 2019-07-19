import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/ui/widgets/customs/stone_item_widget.dart';
import 'package:flutter_base/ui/widgets/customs/stones_viewer_widget.dart';
import 'package:flutter_base/ui/widgets/customs/tool_item_widget.dart';

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

  GlobalKey _toolKey = GlobalKey();

  double _braceletRadius = 0;

  StonesViewerWidget _stonesViewerWidget;
  Size toolSize;

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
      toolSize = Size(constraint.maxWidth, constraint.maxHeight);
      return Container(
        key: _toolKey,
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
//                  ToolItemWidget(),
                ],
              ),
            ),
            ToolItemWidget(
              callback: _handleAddItem,
            ),
            Container(
              child: DragTarget(
                builder: (context, List<int> candidateData, rejectedData) {
//                  print('candidateData $candidateData');
                  return Container(
                    width: double.infinity,
                    height: double.infinity,
                  );
                },
                onWillAccept: (data) {
//                  print('onWillAccept $data');
                  return true;
                },
                onAccept: (data) {
//                  print('onAccept $data');
                },
                onLeave: (data) {
//                  print('onLeave $data');
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  void _handleAddItem(Offset offset) {
    final RenderBox containerRenderBox =
        _toolKey.currentContext.findRenderObject();
    final toolPosition = containerRenderBox.localToGlobal(Offset.zero);
//    print('SonLT ${offset.dx} : ${offset.dy}');
//    print('SonLT2 ${toolPosition.dx} : ${toolPosition.dy}');
    Offset offsetToCenter = Offset(
        offset.dx - toolPosition.dx - (toolSize.width / 2) + 20.0,
        offset.dy - toolPosition.dy - (toolSize.height / 2) + 20.0);
    double angle = atan2(offsetToCenter.dy, offsetToCenter.dx);
    print('SonLT2 ${offsetToCenter.dx} : ${offsetToCenter.dy}');
    _stonesViewerWidget.state.addRandomStoneWithAngel(angle);
  }
}
