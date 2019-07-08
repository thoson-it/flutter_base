import 'dart:io';

import 'package:flutter_base/models/base_entity.dart';

class ProductEntity extends BaseEntity {
  int id;
  String name;
  String detail;
  String imageDesign;
  int stoneId;
  String stoneName;
  String stoneJapaneseName;
  int colorId;
//  List<SizeEntity> sizes = List<SizeEntity>();

  List<ProductEntity> birthStones = List<ProductEntity>();

  ProductEntity();

  ProductEntity.fromJson(Map<String, dynamic> json) {
    parseJson(json);
  }

  @override
  void parseJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    detail = json['detail'];
    imageDesign = json['image_design'];
    stoneId = json['stone_id'];
    stoneName = json['stone_name'];
    stoneJapaneseName = json['stone_japanese_name'];
    colorId = json['color_id'];
    // Parser Sizes
//    if (json['sizes'] is List) {
//      sizes.addAll((json['sizes'] as List).map((item) {
//        return SizeEntity.fromJson(item);
//      }));
//    }
    // Parser birthStones
    if (json['product_ids'] is List) {
      birthStones.addAll((json['product_ids'] as List).map((item) {
        return ProductEntity.fromJson(item);
      }));
    }
  }

  @override
  Map<String, dynamic> toJson() {
//    var sizesMap = sizes.map((entity) => entity.toJson()).toList();
    var result = {
      "id": id,
      "name": name,
      "detail": detail,
      "image_design": imageDesign,
      "stone_id": stoneId,
      "stone_name": stoneName,
      "stone_japanese_name": stoneJapaneseName,
      "color_id": colorId,
//      "sizes": sizesMap,
    };
    if (birthStones.isNotEmpty) {
      var birthStonesMap =
          birthStones.map((entity) => entity.toJson()).toList();
      result.addAll({"product_ids": birthStonesMap});
    }
    return result;
  }

}
