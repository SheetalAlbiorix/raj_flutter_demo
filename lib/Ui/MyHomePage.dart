import 'dart:convert';

import 'package:demo/Ui/LoginScreen.dart';
import 'package:demo/basestring/BaseString.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/UserDetailModel.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  late RxString loginemail = "".obs;
  late RxString loginpassword = "".obs;
  late RxBool isLogedin = false.obs;
  late RxBool isRememberme = false.obs;
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  List<UserDetailModel> _items = [];
  bool _isLoading = true;
  final scrollController = ScrollController();
  int currentPage = 1;
  int pageSize = 4;
  bool isLoadingmore = false;

  Future<dynamic> getPrefs() async {
    final SharedPreferences _prefs = await prefs;
    loginemail.value = _prefs.getString("email")!;
    loginpassword.value = _prefs.getString("password")!;
    isLogedin.value = _prefs.getBool("islogedin")!;
    isRememberme.value = _prefs.getBool("isremember")!;
  }

  Future<void> clearPrefs() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (isRememberme == true) {
      loginemail.value = _prefs.getString("email")!;
      loginpassword.value = _prefs.getString("password")!;
      _prefs.remove("islogedin");
    } else {
      _prefs.remove("islogedin");
      _prefs.remove("email");
      _prefs.remove("password");
    }
  }

  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    loadAndSetData();
    getPrefs();
    super.initState();
  }

  Future<void> loadAndSetData() async {
    try {
      List<UserDetailModel> loadedUserData =
          await readJson(currentPage, pageSize);

      setState(() {
        _items = loadedUserData;
        _isLoading = false;
      });
    } catch (error) {
      print("Error loading initial data: $error");
    }
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(BaseString.logout),
          content: Text(
            BaseString.logouttxt,
            style: TextStyle(color: Theme.of(context).focusColor),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(BaseString.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(BaseString.logout),
              onPressed: () {
                clearPrefs();
                isLogedin.value = false;
                Navigator.pop(context, true);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));

                /*Get.offAllNamed('/login');*/
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(BaseString.HomePage),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(12.0),
                  controller: scrollController,
                  itemCount: _items.length + (isLoadingmore ? 1 : 0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index < _items.length) {
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(_items[index].image),
                                radius: 50,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _items[index].name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context).focusColor),
                                    ),
                                    Text(
                                      _items[index].designation,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Theme.of(context).focusColor),
                                    ),
                                    Text(
                                      "Location : ${_items[index].loaction}",
                                      style: TextStyle(
                                          color: Theme.of(context).focusColor),
                                    ),
                                    Text(
                                      "Department : ${_items[index].department}",
                                      style: TextStyle(
                                          color: Theme.of(context).focusColor),
                                    ),
                                    Text(
                                      "Email : ${_items[index].email}",
                                      style: TextStyle(
                                          color: Theme.of(context).focusColor,
                                          overflow: TextOverflow.ellipsis),
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Mobile : ${_items[index].mobile}",
                                      style: TextStyle(
                                          color: Theme.of(context).focusColor),
                                    ),
                                    // Add more Text widgets for additional details
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (isLoadingmore) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
            ),
            /* if (isLoadingmore) // Display the progress indicator if data is still loading
                CircularProgressIndicator(),*/
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Center(
                child: UserAccountsDrawerHeader(
                  accountName: Text("raj"),
                  accountEmail: Text("raj@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage(
                        "assets/download1.png"), // Replace with your image path
                  ),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "About Us",
                ),
                leading: Icon(
                  Icons.account_balance_outlined,
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/AboutUs');
                },
              ),
              ListTile(
                title: Text("Contact Us"),
                leading: Icon(Icons.phone),
                onTap: () {
                  Navigator.pushNamed(context, '/ContactUs');
                },
              ),
              /*   ListTile(
                title: Text("Register"),
                leading: Icon(Icons.supervised_user_circle_outlined),
                onTap: (){
                  Navigator.pushNamed(context, '/Register');
                },
              ),
              ListTile(
                title: Text("Login"),
                leading: Icon(Icons.supervised_user_circle),
                onTap: (){
                  Navigator.pushNamed(context, '/Login');
                },
              ),
              ListTile(
                title: Text("api call"),
                leading: Icon(Icons.list),
                onTap: (){
                  Navigator.pushNamed(context, '/ApiCalling');
                },
              )*/
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white),
              label: "Home",
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white),
            label: "Search",
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.logout, color: Colors.white),
              label: "Logout",
              backgroundColor: Colors.red),
        ],
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            if (index == 2) {
              _showLogoutDialog();
              /*   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  LoginScreen()));*/
              /*Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LoginScreen()),
              );*/
            }
          });
        },
      ),
    );
  }

  Future<void> loadMoreData() async {
    setState(() {
      isLoadingmore = true;
    });

    try {
      // Load the remaining data (5 to n)
      await Future.delayed(Duration(seconds: 2));
      List<UserDetailModel> moreData =
          await readJson(currentPage + 1, pageSize);

      setState(() {
        _items.addAll(moreData);
        currentPage = currentPage + 1;
      });
    } catch (error) {
      print("Error loading more data: $error");
    } finally {
      setState(() {
        isLoadingmore = false;
      });
    }
  }

  Future<void> _scrollListener() async {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isLoadingmore) {
      print("new data load");
      await loadMoreData();
    }
  }
}

Future<List<UserDetailModel>> readJson(int page, int pageSize) async {
  final String response = await rootBundle.loadString('assets/UserDetail.json');
  final List<dynamic> jsonData = json.decode(response);
  final List<UserDetailModel> data = jsonData
      .map((item) => UserDetailModel.fromJson(item))
      .skip((page - 1) * pageSize) // Skip the already loaded items
      .take(pageSize) // Take the next set of items
      .toList();
  return data;
}
