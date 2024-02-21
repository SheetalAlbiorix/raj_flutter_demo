import 'dart:async';

import 'package:demo/Ui/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => RegisterScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: Image(image:AssetImage('assets/albiorix.png'),),
     ),
   );
  }
}
