  import 'package:demo/Model/UserDetailModel.dart';
import 'package:demo/Ui/TimeLine.dart';
import 'package:flutter/material.dart';

import 'SummaryScreen.dart';
import 'WallActivity.dart';

class DetailScreen extends StatelessWidget {
  final UserDetailModel item;

  const DetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            'Details',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, '/derawer');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.red,
                child: TabBar(
                  tabs: [
                    Tab(
                      text: "Summary",
                    ),
                    Tab(text: "Wall Activity"),
                    Tab(text: "Timeline")
                  ],
                  indicatorColor: Colors.white,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                ),
              ),
              Expanded(
                  child: TabBarView(
                children: [
                  SummaryScreen(item: item),
                  WallActivity(name: item.name),
                  TimeLine(date: item.myDate)
                ],
              ))
            ],
          ),
        ),
        /*   body: TabBarView(
         children: [

         ],
       )*/
        /*   AppBar(
         title: Text('Details',style: TextStyle(
           color: Colors.white,
           fontSize: 18,
           fontWeight: FontWeight.bold,
         ),

         ),
         leading: IconButton(
           onPressed: () {
           */ /*  Navigator.pop(context, '/Login');*/ /*
           },
           icon: Icon(Icons.arrow_back, color: Colors.white),
         ),
         centerTitle: true,
         backgroundColor: Colors.red,
       ),*/
        /*   bottomSheet: Container(
         color: Colors.red,
         child: TabBar(tabs: [
           Tab(text: "Summary",),
           Tab(text: "Wall Activity")
         ],
           indicatorColor: Colors.white,
           labelColor: Colors.white,
           unselectedLabelColor: Colors.white,
         ),
       ),*/
      ),
    );
  }
}
