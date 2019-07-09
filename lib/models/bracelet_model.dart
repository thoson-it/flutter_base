import 'entity/stone_widget_info.dart';
import 'dart:math';

///Note: Góc của mỗi hạt sẽ được tính theo chiều kim đồng hồ,
///Góc này lớn hơn 0 và không vượt quá 360

class BraceletModel {
  //List đá, được sắp xếp theo chiều kim đồng hồ
  List<StoneWidgetInfo> stones = List<StoneWidgetInfo>();

  bool addNewStone(StoneWidgetInfo stone) {
    //List đã đầy
    if ((_getOccupyAngle() + stone.occupyAngle) > (2 * pi)) {
      //the circle full
      return false;
    }
    //Thực hiện add stone
    var newStoneIndex = _addStoneToList(stone);
    //Update lại vị trí stone
    _updateStonePosition(newStoneIndex);
    return true;
  }

  void removeStoneAtIndex(StoneWidgetInfo stone) {}

  bool _isFullItemIfAddNew(StoneWidgetInfo stone) {
    if ((_getOccupyAngle() + stone.occupyAngle) > (2 * pi)) {
      //the circle full
      return false;
    }
  }

  ///Tính tổng góc đã bị chiếm giữ trên vòng bởi các hạt
  double _getOccupyAngle() {
    double total = 0;
    stones.forEach((item) {
      total += item.occupyAngle;
    });
    return total;
  }

  ///Chèn thêm stone vào list
  ///Return position insert
  int _addStoneToList(StoneWidgetInfo stone) {
    //Trường hợp danh sách trống
    if (stones.isEmpty) {
      stones.add(stone);
      return 0;
    }
    //Trường hợp insert vào đầu hoặc cuối list
    if (stone.angleInParent <= stones.first.angleInParent) {
      stones.insert(0, stone);
      return 0;
    }
    if (stone.angleInParent >= stones.last.angleInParent) {
      stones.add(stone);
      return stones.length - 1;
    }
    //Trường hợp chèn vào giữa danh sách
    var previousIndex = _getPreviousItemIndex(stone);
    stones.insert(previousIndex + 1, stone);
    return previousIndex + 1;
  }

  ///Lấy vị trí hạt ở trước
  int _getPreviousItemIndex(StoneWidgetInfo stone) {
    if (stones.isEmpty) return -1;
    if (stones.length == 1) {
      return 0;
    }
    if (stone.angleInParent < stones.first.angleInParent ||
        stone.angleInParent > stones.last.angleInParent) {
      return stones.length - 1;
    }
    for (int i = 0; i < stones.length; i++) {
      var previousStone = stones[i];
      var nextStone = stones[i + 1];

      if (stone.angleInParent >= previousStone.angleInParent &&
          stone.angleInParent <= nextStone.angleInParent) {
        return i;
      }
    }
    return -1;
  }

  ///Update lại vị trí stone
  void _updateStonePosition(int startPosition) {
    //Save old position
    for (int i = 0; i < stones.length; i++) {
      stones[i].oldAngleInParent = stones[i].angleInParent;
    }
    //Update angel in parent for each stone
    var currentTrackingIndex = startPosition;
    for (int i = 0; i < stones.length; i++) {
      //Lấy index của hạt trước đó để kiểm tra bị đè lên nhau
      var previousTrackingIndex = currentTrackingIndex == 0
          ? stones.length - 1
          : currentTrackingIndex - 1;
      if (_isStoneOverlapAnother(
          stones[currentTrackingIndex], stones[previousTrackingIndex])) {
        //Update angle in parent
        stones[currentTrackingIndex].angleInParent =
            stones[previousTrackingIndex].angleInParent +
                (stones[currentTrackingIndex].occupyAngle +
                        stones[previousTrackingIndex].occupyAngle) /
                    2.0;
        //Kiểm tra vị trí được update vượt quá 2*pi
        if (stones[currentTrackingIndex].angleInParent > (2 * pi)) {
          stones[currentTrackingIndex].angleInParent =
              stones[currentTrackingIndex].angleInParent - (2 * pi);
        }
      }
      currentTrackingIndex += 1;
      if (currentTrackingIndex >= stones.length) currentTrackingIndex = 0;
    }
  }

  bool _isStoneOverlapAnother(StoneWidgetInfo first, StoneWidgetInfo second) {
    var delta = (first.angleInParent - second.angleInParent).abs();
    if ((2 * pi - delta) < delta) {
      delta = 2 * pi - delta;
    }
    if (delta < (first.occupyAngle / 2 + second.occupyAngle / 2)) {
      return true;
    } else {
      return false;
    }
  }
}
