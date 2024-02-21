import 'package:demo/basestring/BaseString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BaseString.ContactUS),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leading:IconButton(onPressed: () {
          Navigator.pop(context,'/mainActivity');
        }, icon: Icon(Icons.arrow_back,color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
    );
  }

}