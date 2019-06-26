import 'package:flutter_base/models/base_entity.dart';

import 'error_code.dart';

typedef S ItemCreator<S>();

class Response<T extends BaseEntity> extends BaseEntity {
  bool status = false;
  ErrorCode errorCode;
  int page = 1;
  int totalResults = 0;
  int totalPages = 0;

  ItemCreator<T> creator;
  T data;
  List<T> dataList = <T>[];

  Response(ItemCreator<T> creator) {
    this.creator = creator;
  }

  @override
  void parseJson(Map<String, dynamic> json) {
    if (json == null) {
      this.status = false;
      return;
    }
    this.status = true;
    try {
      //Parse status
//      if (json['status'] != null && json['status'] is int) {
//        int status = json['status'];
//        this.status = status == 1;
//      }
      //Parse error_code
      if (json['error_code'] != null && json['error_code'] is int) {
        int code = json['error_code'];
        errorCode = ErrorCode.valueOf(code);
      }
      //Parse page
      if (json['page'] != null && json['page'] is int) {
        page = json['page'];
      }
      //Parse totalResults
      if (json['total_results'] != null && json['total_results'] is int) {
        totalResults = json['total_results'];
      }
      //Parse totalPages
      if (json['total_pages'] != null && json['total_pages'] is int) {
        totalPages = json['total_pages'];
      }

      if (json["results"] is List) {
        //Parse list
        List<T> list = (json["results"] as List).map((item) {
          T entity = creator();
          entity.parseJson(item);
          return entity;
        }).toList();
        dataList.clear();
        dataList.addAll(list);
      } else if (json["result"] is Map) {
        //Parse object
        data = this.creator();
        data.parseJson(json["result"]);
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error_code'] = errorCode.getValue();
    data['status'] = status ? 1 : 0;
    return data;
  }
}
