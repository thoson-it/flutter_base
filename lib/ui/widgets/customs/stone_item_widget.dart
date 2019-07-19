import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/models/entity/stone_widget_info.dart';

class StoneItemWidget extends StatefulWidget {
  StoneWidgetInfo stoneWidgetInfo;
  double rotate;

  StoneItemWidget(this.stoneWidgetInfo, {this.rotate});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StoneItemWidgetState();
  }
}

class _StoneItemWidgetState extends State<StoneItemWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Draggable(
      child: ClipRRect(
        borderRadius: BorderRadius.all(
            Radius.circular(widget.stoneWidgetInfo.radiusInApp)),
        child: Transform.rotate(
          angle: widget.rotate + (3 * pi / 2),
          child: Container(
            width: widget.stoneWidgetInfo.radiusInApp * 2,
            height: widget.stoneWidgetInfo.radiusInApp * 2,
            color: Colors.red,
            child: Center(
              child: Text('${widget.stoneWidgetInfo.index}'),
            ),
          ),
        ),
      ),
      feedback: ClipRRect(
        borderRadius: BorderRadius.all(
            Radius.circular(widget.stoneWidgetInfo.radiusInApp)),
        child: Container(
          width: widget.stoneWidgetInfo.radiusInApp * 2,
          height: widget.stoneWidgetInfo.radiusInApp * 2,
          color: Colors.yellow,
        ),
      ),
      childWhenDragging: ClipRRect(
        borderRadius: BorderRadius.all(
            Radius.circular(widget.stoneWidgetInfo.radiusInApp)),
        child: Container(
          width: widget.stoneWidgetInfo.radiusInApp * 2,
          height: widget.stoneWidgetInfo.radiusInApp * 2,
          color: Colors.blue,
        ),
      ),
      data: "Stone",
      onDragStarted: () {},
      onDragEnd: (DraggableDetails details) {
//        print('Canceled: ${details.offset}');
      },
      onDragCompleted: () {},
      onDraggableCanceled: (Velocity velocity, Offset offset) {
//        print('Canceled: $velocity === $offset');
      },
    );
  }
}
