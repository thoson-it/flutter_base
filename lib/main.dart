import 'package:flutter/material.dart';
import 'package:flutter_base/ui/screens/splash_screen.dart';
import 'package:flutter_base/utilities/app_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

String kAppToken = "";
String kApiKey = "26763d7bf2e94098192e629eb975dab0"; //Key movie
//UserInfo appUser = UserInfo();
//Config appConfig = Config();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _kAppThemeData,
      home: SplashScreen(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ja', 'JP'),
        const Locale('en', 'US'),
      ],
    );
  }
}

final ThemeData _kAppThemeData = new ThemeData(
  brightness: Brightness.light,
  primaryColorBrightness: Brightness.light,
  accentColor: AppColors.mainColor,
  accentColorBrightness: Brightness.light,
);
