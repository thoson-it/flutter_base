import 'package:flutter/material.dart';

class ReloadButtonWidget extends StatelessWidget {
  VoidCallback _onPressed;
  String _title;

  ReloadButtonWidget({String title = "", VoidCallback onPressed}) {
    _onPressed = onPressed;
    _title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildTitleWidget(),
        Container(
          width: 48.0,
          height: 48.0,
          child: FlatButton(
              padding: EdgeInsets.all(0.0),
              onPressed: _onPressed,
              child: Container(
                width: 48.0,
                height: 48.0,
                child: Icon(
                  Icons.refresh,
                  color: Colors.grey,
                ),
              ),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0))),
        )
      ],
    );
  }

  Widget _buildTitleWidget() {
    if (_title != null && _title.isNotEmpty) {
      return Text(
        _title,
        style: TextStyle(color: Colors.grey),
      );
    } else {
      return Container();
    }
  }
}
