import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.white,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
                height: 16.0,
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
                height: 16.0,
              ),
              Container(
                color: Colors.white,
                margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
                height: 32.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
