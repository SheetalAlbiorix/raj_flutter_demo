import 'package:demo/Ui/MyHomePage.dart';
import 'package:demo/Ui/RegisterScreen.dart';
import 'package:demo/basestring/BaseString.dart';
import 'package:demo/customWidget/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../customWidget/CustomEditTextField.dart';

class LoginScreen extends StatelessWidget {
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
              SystemNavigator.pop();
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: Logindesign());
  }
}

class Logindesign extends StatefulWidget {
  const Logindesign({super.key});

  @override
  State<Logindesign> createState() => _LogindesignState();
}

class _LogindesignState extends State<Logindesign> {
  final _emailLogin = TextEditingController();
  final _passwordLogin = TextEditingController();
  var erromsgemail = "".obs;
  var errorpassword = "".obs;
  bool _rememberMe = false;
  bool _isLogin = false;
  bool passwordVisible = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    // Load saved email and password from shared preferences
    checkSharedPrefs();
  }

  Future<void> checkSharedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailLogin.text = prefs.getString("email") ?? "";
      _passwordLogin.text = prefs.getString("password") ?? "";
      _rememberMe =
          _emailLogin.text.isNotEmpty && _passwordLogin.text.isNotEmpty;
    });
    /* final String ? email =
    final String? password = prefs.getString("password");

    // Check if email and password are present in shared preferences
    return email != null && password != null;*/
  }

  Future<void> _saveSharedPrefData() async {
    final SharedPreferences prefs = await _prefs;
    if (_rememberMe) {
      prefs.setString("email", _emailLogin.text);
      prefs.setString("password", _passwordLogin.text);
      prefs.setBool("islogedin", true);
      prefs.setBool("isremember", _rememberMe);
    } else {
      prefs.remove("email");
      prefs.remove("password");
      prefs.setBool("islogedin", true);
      prefs.remove("isremember");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  child: Image(image: AssetImage('assets/removebg.png')),
                  padding: EdgeInsets.only(bottom: 16),
                ),
                CustomEditTextField(
                  hintText: BaseString.emailhint,
                  labelText: (BaseString.emaillabel),
                  borderColor: Colors.red,
                  keyboardType: TextInputType.name,
                  controller: _emailLogin,
                  errorMsg: erromsgemail,
                  textInputAction: TextInputAction.next,
                  onChanged: (String value) {
                    setState(() {
                      if (!RegExp(BaseString.emailRegexp).hasMatch(value)) {
                        erromsgemail.value = BaseString.emailerrorvalidate;
                      } else {
                        erromsgemail.value = (value.isEmpty
                            ? BaseString.emailerror
                            : "") as String;
                      }
                    });
                  },
                ),
                CustomEditTextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    hintText: BaseString.passwordhint,
                    labelText: BaseString.passwordlabel,
                    borderColor: Colors.red,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordLogin,
                    errorMsg: errorpassword,
                    obsecureText: passwordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(
                          () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                    onChanged: (String value) {
                      setState(() {
                        if (!RegExp(BaseString.passwordRegexp)
                            .hasMatch(_passwordLogin.text)) {
                          errorpassword.value = BaseString.passwordformet;
                        } else {
                          errorpassword.value = (value.isEmpty
                              ? BaseString.passworderror
                              : "") as String;
                        }
                      });
                    },
                    bottomPad: false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.red,
                          value: _rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                        Text(BaseString.rememberme,
                            style:
                                TextStyle(color: Theme.of(context).focusColor)),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Forgot Password tapped!");
                      },
                      child: Text(
                        BaseString.forgotPassword,
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  btnText: BaseString.loginbtn,
                  btnColor: Colors.red,
                  onPressed: () {
                    if (_emailLogin.text.isEmpty) {
                      erromsgemail.value = BaseString.emailerror;
                    } else {
                      erromsgemail.value = "";
                      if (!RegExp(BaseString.emailRegexp)
                          .hasMatch(_emailLogin.text)) {
                      } else {
                        erromsgemail.value = "";
                        if (_passwordLogin.text.isEmpty) {
                          errorpassword.value = BaseString.passworderror;
                        } else {
                          errorpassword.value = "";
                          if (!RegExp(BaseString.passwordRegexp)
                              .hasMatch(_passwordLogin.text)) {
                            errorpassword.value = BaseString.passwordformet;
                          } else {
                            if (_emailLogin.text != "rajshah9283@gmai.com" &&
                                _passwordLogin.text != "777Raj-shah") {
                              errorpassword.value = BaseString.finalvalidation;
                            } else {
                              errorpassword.value = "";
                              _saveSharedPrefData();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                              /*  Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePage()),
                                      );*/
                            }
                          }
                        }
                      }
                    }
                  },
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            "Don't have an account yet?",
                            style:
                                TextStyle(color: Theme.of(context).focusColor),
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                            /*Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => RegisterScreen()));*/
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
