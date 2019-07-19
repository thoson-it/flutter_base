import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/models/entity/stone_widget_info.dart';

typedef void ToolItemCallback(Offset offset);

class ToolItemWidget extends StatefulWidget {
  ToolItemCallback callback;
  ToolItemWidget({this.callback});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ToolItemWidgetState();
  }
}

class _ToolItemWidgetState extends State<ToolItemWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Draggable(
      child: ClipRRect(
        borderRadius: BorderRadius.all(
            Radius.circular(20)),
        child: Container(
            width: 20.0 * 2,
            height: 20.0 * 2,
            color: Colors.red,
            child: Center(
              child: Text('ST'),
            ),
        ),
      ),
      feedback: ClipRRect(
        borderRadius: BorderRadius.all(
            Radius.circular(20)),
        child: Container(
          width: 20.0 * 2,
          height: 20.0 * 2,
          color: Colors.red,
        ),
      ),
      childWhenDragging: ClipRRect(
        borderRadius: BorderRadius.all(
            Radius.circular(20)),
        child: Container(
          width: 20.0 * 2,
          height: 20.0 * 2,
          color: Colors.red,
        ),
      ),
      data: 10,
      onDragStarted: () {},
      onDragEnd: (DraggableDetails details) {
//        print('Canceled: ${details}');
        if(widget.callback != null) {
          widget.callback(details.offset);
        }
      },
      onDragCompleted: () {},
      onDraggableCanceled: (Velocity velocity, Offset offset) {
//        print('Canceled: $velocity === $offset');

      },
    );
  }
}
