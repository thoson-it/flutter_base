import 'entity/stone_widget_info.dart';
import 'dart:math';

///Note: Góc của mỗi hạt sẽ được tính theo chiều kim đồng hồ,
///Góc này lớn hơn 0 và không vượt quá 360

class BraceletModel {
  //List đá, được sắp xếp theo chiều kim đồng hồ
  List<StoneWidgetInfo> stones = List<StoneWidgetInfo>();

  bool addNewStone(StoneWidgetInfo stone) {
    if ((_getOccupyAngle() + stone.occupyAngle) > (2 * pi)) {
      //the circle full
      return false;
    }

    var newStone = stone;
//    var previousIndex = _getPreviousNearItemIndex(newStone);
//    if (previousIndex < 0) {
//      stones.add(newStone);
//      return true;
//    }
    var newStoneIndex = _addStoneToList(stone);
//    newStone.index = newStoneIndex;
    //Add stone to list
//    stones.insert(newStoneIndex, stone);
    //Update index for each stone
    for (int i = 0; i < stones.length; i++) {
//      stones[i].index = i;
      stones[i].oldAngleInParent = stones[i].angleInParent;
    }
    //Update angel in parent for each stone
    var currentIndex = newStoneIndex;
    for (int i = 0; i < stones.length; i++) {
      //Lấy index của hạt kế tiếp để kiểm tra bị đè lên nhau
      var previousStoneIndex =
          currentIndex == 0 ? stones.length - 1 : currentIndex - 1;
      if (_isStoneOverlapAnother(
          stones[currentIndex], stones[previousStoneIndex])) {
        //Update angle in parent
        stones[currentIndex].angleInParent =
            stones[previousStoneIndex].angleInParent +
                (stones[currentIndex].occupyAngle +
                        stones[previousStoneIndex].occupyAngle) /
                    2.0;
        if (stones[currentIndex].angleInParent > (2 * pi)) {
          stones[currentIndex].angleInParent =
              stones[currentIndex].angleInParent - (2 * pi);
        }
      } else {
//        break;
      }
      currentIndex += 1;
      if (currentIndex >= stones.length) currentIndex = 0;
    }
    return true;
  }

  void removeStoneAdIndex(StoneWidgetInfo stone) {}

  ///Tính tổng góc đã bị chiếm giữ trên vòng bởi các hạt
  double _getOccupyAngle() {
    double total = 0;
    stones.forEach((item) {
      total += item.occupyAngle;
    });
    return total;
  }

  ///Chèn thêm stone vào list
  int _addStoneToList(StoneWidgetInfo stone) {
    var newStone = stone;
    var previousIndex = _getPreviousNearItemIndex(newStone);
    //Trường hợp danh sách trống
    if (stones.isEmpty) {
      stones.add(stone);
      return stones.length - 1;
    }
    //Trường hợp nhiều hơn 1 phần tử thì previous index luôn là 0
    if (newStone.angleInParent >= stones[previousIndex].angleInParent) {
      stones.insert(previousIndex + 1, newStone);
      return previousIndex + 1;
    } else {
      stones.insert(0, newStone);
      return 0;
    }
  }

  ///Lấy vị trí hạt ở trước
  int _getPreviousNearItemIndex(StoneWidgetInfo stone) {
    if (stones.isEmpty) return -1;
    if (stones.length == 1) {
      return 0;
    }
    for (int i = 0; i < stones.length; i++) {
      int nextIndex = i + 1;
      if (nextIndex == stones.length) {
        nextIndex = 0;
      }
      var previousStone = stones[i];
      var nextStone = stones[nextIndex];

      if (previousStone.angleInParent <= nextStone.angleInParent) {
        if (stone.angleInParent >= previousStone.angleInParent &&
            stone.angleInParent <= nextStone.angleInParent) {
          return i;
        }
      } else {
        if (stone.angleInParent <= previousStone.angleInParent ||
            stone.angleInParent >= nextStone.angleInParent) {
          return nextIndex;
        }
      }
    }
    return -1;
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

  ///Lấy vị trí hạt ở sau sẽ bị đè lên của
//  int _getNextNeartItemIndex(StoneWidgetInfo stone) {
//    return stones.indexWhere((item) {
//      return ((item.angleInParent + item.occupyAngle) >
//          (stone.angleInParent - stone.occupyAngle) &&
//          item.angleInParent < stone.angleInParent);
//    });
//  }
}
