import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/models/bracelet_model.dart';
import 'package:flutter_base/models/entity/stone_widget_info.dart';
import 'package:flutter_base/ui/widgets/customs/stone_item_widget.dart';
import 'dart:math';

class StonesViewerWidget extends StatefulWidget {
  BraceletModel braceletModel = BraceletModel();

  _StonesViewerWidgetState state;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    state = _StonesViewerWidgetState();
    return state;
  }
}

class _StonesViewerWidgetState extends State<StonesViewerWidget> {
  double _braceletRadius = 0;
  Size parentSize = Size(0, 0);
  Size viewerSize;
  GlobalKey _viewerKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LayoutBuilder(
      key: _viewerKey,
      builder: (context, constraint) {
        _braceletRadius =
            min<double>(constraint.maxWidth, constraint.maxHeight) / 2 - 20;
        parentSize = Size(_braceletRadius * 2 + 40, _braceletRadius * 2 + 40);
        viewerSize = Size(constraint.maxWidth, constraint.maxHeight);
        return Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              child: Stack(
                children: _buildStoneListWidget(),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildStoneListWidget() {
    var list = widget.braceletModel.stones.map((info) {
      info.parentSize = parentSize;
      info.generatePosition(_braceletRadius);
      return _buildStoneWidget(info);
    }).toList();

    var ges = GestureDetector(
      onPanStart: _handleOnPanStart,
      onPanUpdate: _handleOnPanUpdate,
      onPanEnd: _handleOnPanEnd,
      child: Container(color: Colors.transparent),
    );

    list.insert(0, ges);
    return list;
  }

  Widget _buildStoneWidget(StoneWidgetInfo stone) {
//    print('Draw stone: ${stone.index}');
    var deltaRotate;
    if (stone.angleInParent >= stone.oldAngleInParent) {
      deltaRotate = stone.angleInParent - stone.oldAngleInParent;
    } else {
      deltaRotate = 2 * pi - stone.oldAngleInParent + stone.angleInParent;
    }
    return Positioned(
      top: stone.oldPosition.dy - stone.radiusInApp,
      left: stone.oldPosition.dx - stone.radiusInApp,
      child: Animator(
        tween: Tween<double>(begin: 0, end: deltaRotate),
        duration: Duration(milliseconds: 400),
        cycles: 1,
        builder: (anim) => Transform.rotate(
              angle: anim.value,
              child: StoneItemWidget(
                stone,
                rotate: stone.angleInParent,
                onStartDrag: _handleStartDragStone,
                onEndDrag: _handleEndDragStone,
              ),
              origin: Offset(
                parentSize.width / 2 - stone.oldPosition.dx,
                parentSize.height / 2 - stone.oldPosition.dy,
              ),
            ),
      ),
    );
  }

  void removeStoneAtIndex(int index) {
    widget.braceletModel.stones.removeWhere((stone) {
      return stone.index == index;
    });
  }

  var index = 0;

  void addRandomStoneWithAngel(double angle) {
    setState(() {
      var stoneInfo = StoneWidgetInfo();
      stoneInfo.angleInParent = angle;
      index += 1;
      stoneInfo.index = index;
      stoneInfo.oldAngleInParent = stoneInfo.angleInParent;
      stoneInfo.parentSize = parentSize;
      stoneInfo.generatePosition(_braceletRadius);
      widget.braceletModel.addNewStone(stoneInfo);
    });
  }

  void _handleStartDragStone(int index) {}

  void _handleEndDragStone(StoneWidgetInfo stone, Offset offset) {
    final RenderBox containerRenderBox =
        _viewerKey.currentContext.findRenderObject();
    final viewerPosition = containerRenderBox.localToGlobal(Offset.zero);

    ///
    Offset offsetToCenter = Offset(
        offset.dx -
            viewerPosition.dx -
            (viewerSize.width / 2) +
            stone.radiusInApp,
        offset.dy -
            viewerPosition.dy -
            (viewerSize.height / 2) +
            stone.radiusInApp);
    double angle = atan2(offsetToCenter.dy, offsetToCenter.dx);
    if (angle < 0) {
      angle = 2 * pi + angle;
    }

    ///
    if (offsetToCenter.dy > 300) {
      setState(() {
        removeStoneAtIndex(stone.index);
      });
    } else {
      removeStoneAtIndex(stone.index);
      addRandomStoneWithAngel(angle);
    }
  }

  ///Gesture
  void _handleOnPanStart(DragStartDetails detail) {
    print("Start drag");
    widget.braceletModel.resetAnimation();
  }

  void _handleOnPanUpdate(DragUpdateDetails detail) {
    print("Update drag");
  }

  void _handleOnPanEnd(DragEndDetails detail) {
    print("End drag");
  }
}
