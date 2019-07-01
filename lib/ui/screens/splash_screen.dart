import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/database/file_manager.dart';
import 'package:flutter_base/ui/screens/movies_screen.dart';
import 'package:flutter_base/utilities/app_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _openMoviesScreenWithAsync();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBodyContent(),
    );
  }

  ///Build widget
  Widget _buildBodyContent() {
    return Container(
      color: AppColors.mainColor,
    );
  }

  ///
  void _openMoviesScreenWithAsync() async {
    await new Future.delayed(const Duration(seconds: 2));
    _openMoviesScreen();
  }

  ///Navigate
  void _openMoviesScreen() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoviesScreen(),
      ),
    );
    //Todo: handle result here
  }
}
