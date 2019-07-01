import 'package:flutter/material.dart';
import 'package:flutter_base/application.dart';
import 'package:flutter_base/ui/screens/splash_screen.dart';
import 'package:flutter_base/utilities/app_colors.dart';
import 'package:flutter_base/utilities/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

String kAppToken = "";
String kApiKey = "26763d7bf2e94098192e629eb975dab0"; //Key movie
//UserInfo appUser = UserInfo();
//Config appConfig = Config();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppLocalizationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppLocalizationsDelegate(newLocale: null);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _kAppThemeData,
      home: SplashScreen(),
      localizationsDelegates: [
        _newLocaleDelegate,
        const AppLocalizationsDelegate(),
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: Application().supportedLocales(),
    );
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppLocalizationsDelegate(newLocale: locale);
    });
  }
}

final ThemeData _kAppThemeData = new ThemeData(
  brightness: Brightness.light,
  primaryColorBrightness: Brightness.light,
  accentColor: AppColors.mainColor,
  accentColorBrightness: Brightness.light,
);
