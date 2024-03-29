import 'package:demo/Ui/LoginScreen.dart';
import 'package:demo/navigation/RouteClass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Ui/MyHomePage.dart';
import 'customWidget/Themes.dart';

void main() {
  runApp(RouteClass());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  RxBool screen = false.obs;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        theme: Themes.lightTheme(context),
        darkTheme: Themes.darkTheme(context),
        home: FutureBuilder<bool>(
          future: getPrefs(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data! ? MyHomePage() : LoginScreen();
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }

  Future<bool> getPrefs() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = _prefs.getBool("islogedin");
    String? email = _prefs.getString("email");
    return isLoggedIn != null && isLoggedIn;
/*    return _prefs.getString("email").?isNotEmpty == true;*/
  }
}
