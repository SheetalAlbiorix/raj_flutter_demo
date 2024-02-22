import 'package:demo/Ui/LoginScreen.dart';
import 'package:demo/basestring/BaseString.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    getPrefs();
    super.initState();
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
}
