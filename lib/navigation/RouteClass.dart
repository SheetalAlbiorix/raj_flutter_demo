import 'package:demo/Ui/ContactUsScreen.dart';
import 'package:demo/Ui/LoginScreen.dart';
import 'package:demo/Ui/RegisterScreen.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../Ui/AboutUsScreen.dart';
import '../Ui/ApiCallingScreen.dart';
import '../Ui/MyHomePage.dart';
import '../Ui/SplashScreen.dart';
import '../customWidget/Themes.dart';

class RouteClass extends StatelessWidget {
  // Create a unique GlobalKey for RouteClass
  final GlobalKey<NavigatorState> routeClassKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: Themes.lightTheme(context),
      darkTheme: Themes.darkTheme(context),
      initialRoute: '/',
      navigatorKey: routeClassKey,
      // Use the unique GlobalKey here
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splashscreen':
            return MaterialPageRoute(builder: (context) => SplashScreen());
          case '/AboutUs':
            return MaterialPageRoute(builder: (context) => AboutUsScreen());
          case '/derawer':
            return MaterialPageRoute(builder: (context) => MyHomePage());
          case '/mainActivity':
            return MaterialPageRoute(builder: (context) => MyApp());
          case '/ContactUs':
            return MaterialPageRoute(builder: (context) => ContactUsScreen());
          case '/Register':
            return MaterialPageRoute(builder: (context) => RegisterScreen());
          case '/Login':
            return MaterialPageRoute(builder: (context) => LoginScreen());
          case '/ApiCalling':
            return MaterialPageRoute(builder: (context) => ApiCallingScreen());
          /* case '/DetailScreen':
            return MaterialPageRoute(builder: (context) => DetailScreen(item:UserDetailModel()));*/
          default:
            return MaterialPageRoute(builder: (context) => MyApp());
        }
      },
    );
  }
}
