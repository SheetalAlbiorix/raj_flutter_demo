
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../basestring/BaseString.dart';

class DisplayData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BaseString.Login),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, '/Register');
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: DisplayDataScreen(),
    );
  }
}
class DisplayDataScreen extends StatefulWidget {
  const DisplayDataScreen({super.key});

  @override
  State<DisplayDataScreen> createState() => _DisplayDataScreenState();
}

class _DisplayDataScreenState extends State<DisplayDataScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

