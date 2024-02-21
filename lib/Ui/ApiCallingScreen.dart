import 'package:demo/controller/UserController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../basestring/BaseString.dart';

class ApiCallingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BaseString.ApiCall),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, '/mainActivity');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body:ApiCall() ,

    );

  }
}

class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  UserController controller = Get.put(UserController());

  @override
  void initState() {
    controller.fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => controller.isloading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: controller.userList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(controller.userList[index].avatar),
                    ),
                    title: Text(controller.userList[index].firstName),
                    subtitle: Text(controller.userList[index].email),
                  );
                })));
  }
}
