import 'package:flutter/material.dart';
import 'package:flutter_base/ui/widgets/customs/stone_tool_widget.dart';

class StoneToolScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StoneToolScreenState();
  }
}

class _StoneToolScreenState extends State<StoneToolScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Stone Tool"),
      ),
      body: Center(
        child: Container(
//          child: AspectRatio(
//            aspectRatio: 1,
            child: StoneToolWidget(),
//          ),
        ),
      ),
    );
  }
}
