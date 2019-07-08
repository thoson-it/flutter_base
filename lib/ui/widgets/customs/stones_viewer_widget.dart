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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return LayoutBuilder(builder: (context, constraint) {
      _braceletRadius =
          min<double>(constraint.maxWidth, constraint.maxHeight) / 2 - 20;
      parentSize = Size(_braceletRadius * 2 + 40, _braceletRadius * 2 + 40);
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
    });
  }

  List<Widget> _buildStoneListWidget() {
    return widget.braceletModel.stones.map((info) {
      info.parentSize = parentSize;
      info.generatePosition(_braceletRadius);
      return _buildStoneWidget(info);
    }).toList();
  }

  Widget _buildStoneWidget(StoneWidgetInfo stone) {
    print('Draw stone: ${stone.index}');
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
              child: StoneItemWidget(stone),
              origin: Offset(
                parentSize.width / 2 - stone.oldPosition.dx,
                parentSize.height / 2 - stone.oldPosition.dy,
              ),
            ),
      ),
    );
  }

  var temp = 0.0;
  var index = 0;

  void addRandomStone() {
    setState(() {
      var stoneInfo = StoneWidgetInfo();
      stoneInfo.angleInParent = Random().nextDouble() * pi;
//      stoneInfo.angleInParent = temp;
      temp += 0.1;
      index += 1;
      stoneInfo.index = index;
//      stoneInfo.radius = Random().nextDouble() * 10 + 10;
      stoneInfo.oldAngleInParent = stoneInfo.angleInParent;
      stoneInfo.parentSize = parentSize;
      stoneInfo.generatePosition(_braceletRadius);
      widget.braceletModel.addNewStone(stoneInfo);
    });
  }
}
