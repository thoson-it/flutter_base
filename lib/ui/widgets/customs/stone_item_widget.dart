import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/models/entity/stone_widget_info.dart';

typedef void OnStartDrag(int index);
typedef void OnEndDrag(StoneWidgetInfo stoneWidgetInfo, Offset offset);

class StoneItemWidget extends StatefulWidget {
  StoneWidgetInfo stoneWidgetInfo;
  double rotate;
  OnStartDrag onStartDrag;
  OnEndDrag onEndDrag;

  StoneItemWidget(this.stoneWidgetInfo,
      {this.rotate, this.onStartDrag, this.onEndDrag});

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
          color: Colors.transparent,
        ),
      ),
      data: "Stone",
      onDragStarted: () {
        if (widget.onStartDrag != null) {
          widget.onStartDrag(widget.stoneWidgetInfo.index);
        }
      },
      onDragEnd: (DraggableDetails details) {
//        print('Canceled: ${details.offset}');
      },
      onDragCompleted: () {},
      onDraggableCanceled: (Velocity velocity, Offset offset) {
        if (widget.onStartDrag != null) {
          widget.onEndDrag(widget.stoneWidgetInfo, offset);
        }
      },
    );
  }
}
