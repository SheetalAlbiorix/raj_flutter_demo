

import 'dart:io';

import 'package:demo/Model/LoadCountry.dart';
import 'package:demo/Ui/MyHomePage.dart';
import 'package:demo/basestring/BaseString.dart';
import 'package:demo/customWidget/CustomButton.dart';
import 'package:demo/customWidget/CustomEditTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(BaseString.Register),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, '/Login');
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: RegisterDesign(),
    );
  }
}

class RegisterDesign extends StatefulWidget {
  const RegisterDesign({super.key});

  @override
  State<RegisterDesign> createState() => _RegisterDesignState();
}

class _RegisterDesignState extends State<RegisterDesign> {
  List<LoadCountry> _items = [];
  late LoadCountry selectedCountry;

  bool _isLoading = true;
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _Cpassword = TextEditingController();
  final _Experience = TextEditingController();
  final _Phone = TextEditingController();
  final _Address = TextEditingController();
  var erromsg = "".obs;
  var errormsglastname = "".obs;
  var errormsgemail = "".obs;
  var errorpassword = "".obs;
  var errorconfirmpassword = "".obs;
  var errorworkexperience = "".obs;
  var errordropdown = "".obs;
  var errorcountrydropdown = "".obs;
  var errorcompanyname = "".obs;
  var errorphone = "".obs;
  bool passwordVisible = false;
  bool confirmpasswordVisible = false;
  var erroraddress = "".obs;

  List<String> dropdownItems = [
    'Select Option',
    'Years',
    'Month',
    'Year',
    'Months'
  ];
  String selectedvalue = 'Select Option';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    loadAndSetData();
    passwordVisible = true;
    confirmpasswordVisible = true;
    super.initState();
  }

  Future<void> loadAndSetData() async {
    List<LoadCountry> loadedData = await readJson();
    setState(() {
      _items = loadedData;
      selectedCountry = _items[0];
      _isLoading = false;
    });
  }
  Future getImageFromGallery() async {
    File _image;
    XFile? image;
    image=(await ImagePicker().pickImage(source: ImageSource.gallery));

    setState(() {
        _image = File(image!.path);
    });
  }
  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('firstname', _firstname.text);
    prefs.setString('lastname', _lastname.text);
    prefs.setString("email", _email.text);
    prefs.setString("password", _password.text);
    prefs.setString("confirm password", _Cpassword.text);
    prefs.setString("work experience", _Experience.text);
    prefs.setString("dropdown data", selectedvalue);
    prefs.setString("select country", selectedCountry.name);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
           backgroundColor: Theme.of(context).primaryColor,
            body: Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            getImageFromGallery();
                          },
                          child: Padding(
                            child: Image(
                              image: AssetImage('assets/removebg.png'),
                            ),
                            padding: EdgeInsets.only(bottom: 16),
                          )),
                      CustomEditTextField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(BaseString.flname)),
                        ],
                        hintText: BaseString.firstnamehint,
                        labelText: (BaseString.firstnamelabel),
                        borderColor: Colors.red,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: _firstname,
                        errorMsg: erromsg,
                        onChanged: (String value) {
                          setState(() {
                            erromsg.value = (value.isEmpty
                                ? BaseString.firstname
                                : "") as String;
                          });
                        },
                      ),
                      CustomEditTextField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(BaseString.flname)),
                        ],
                        hintText: BaseString.lastnamehint,
                        labelText: BaseString.lastnamelabel,
                        borderColor: Colors.red,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: _lastname,
                        errorMsg: errormsglastname,
                        onChanged: (String value) {
                          setState(() {
                            errormsglastname.value = (value.isEmpty
                                ? BaseString.lastnameerror
                                : "") as String;
                          });
                        },
                      ),
                      CustomEditTextField(
                        hintText: BaseString.addresshint,
                        labelText: BaseString.addresslabel,
                        borderColor: Colors.red,
                        keyboardType: TextInputType.name,
                        controller: _Address,
                        textInputAction: TextInputAction.next,
                        errorMsg: erroraddress,
                        minLines: 3,
                        onChanged: (String value) {
                          setState(() {
                            erroraddress.value = (value.isEmpty
                                ? BaseString.addresshint
                                : "") as String;
                          });
                        },
                      ),
                      CustomEditTextField(
                        hintText: BaseString.emailhint,
                        labelText: BaseString.emaillabel,
                        borderColor: Colors.red,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        controller: _email,
                        errorMsg: errormsgemail,
                        onChanged: (String value) {
                          setState(() {
                            if (!RegExp(BaseString.emailRegexp)
                                .hasMatch(value)) {
                              errormsgemail.value =
                                  BaseString.emailerrorvalidate;
                            } else {
                              errormsgemail.value = (value.isEmpty
                                  ? BaseString.emailerror
                                  : "") as String;
                            }
                            /*    errormsgemail.value=(!RegExp("^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\\.[a-zA-Z]{2,4}\$").hasMatch(value))?
                                BaseString.emailerrorvalidate:"";*/
                          });
                        },
                      ),

                      CustomEditTextField(
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.allow(
                                RegExp(BaseString.rangephone)),
                          ],

                          hintText: BaseString.phonehint,
                          labelText: BaseString.phonelabel,
                          borderColor: Colors.red,
                          keyboardType: TextInputType.phone,
                          controller: _Phone,
                          errorMsg: errorphone,
                          textInputAction: TextInputAction.next,
                          onChanged: (String value) {
                            setState(() {
                              if (_Phone.text.length != 10) {
                                errorphone.value = BaseString.phonevalidation;
                              } else {
                                errorphone.value = (value.isEmpty
                                    ? BaseString.phoneerror
                                    : "") as String;
                              } /*else{
                                errorphone.value = (value.isEmpty
                                    ? BaseString.phonevalidation
                                    : "") as String;
                              }*/
                            });
                          }),
                      CustomEditTextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                        ],
                        hintText: BaseString.passwordhint,
                        labelText: BaseString.passwordlabel,
                        borderColor: Colors.red,
                        keyboardType: TextInputType.visiblePassword,
                        obsecureText: passwordVisible,
                        controller: _password,
                        errorMsg: errorpassword,
                        textInputAction: TextInputAction.next,
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
                                .hasMatch(_password.text)) {
                              errorpassword.value = BaseString.passwordformet;
                            } else {
                              errorpassword.value = (value.isEmpty
                                  ? BaseString.passworderror
                                  : "") as String;
                            }
                          });
                        },
                      ),
                      CustomEditTextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(15),
                        ],
                        hintText: BaseString.confirmpasswordhint,
                        labelText: BaseString.confirmpasswordlabel,
                        borderColor: Colors.red,
                        keyboardType: TextInputType.text,
                        obsecureText: confirmpasswordVisible,
                        controller: _Cpassword,
                        errorMsg: errorconfirmpassword,
                        textInputAction: TextInputAction.next,
                        suffixIcon: IconButton(
                          icon: Icon(confirmpasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(
                                  () {
                                confirmpasswordVisible =
                                !confirmpasswordVisible;
                              },
                            );
                          },
                        ),
                        onChanged: (String value) {
                          setState(() {
                            if (_password.text != _Cpassword.text) {
                              errorconfirmpassword.value =
                                  BaseString.confirmPasswordnotmatch;
                            } else {
                              errorconfirmpassword.value = (value.isEmpty
                                  ? BaseString.confirmPassworderror
                                  : "") as String;
                            }
                          });
                        },
                      ),

                      // Two text fields in a single row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: screenWidth * 0.45,
                            child: CustomEditTextField(
                              inputFormatters: <TextInputFormatter>[
                                LengthLimitingTextInputFormatter(2),
                                FilteringTextInputFormatter.allow(
                                    RegExp(BaseString.range)),
                              ],
                              hintText: BaseString.workexperiancehint,
                              labelText: BaseString.workexperiencelabel,
                              borderColor: Colors.red,
                              keyboardType: TextInputType.number,
                              controller: _Experience,
                              errorMsg: errorworkexperience,
                              onChanged: (String value) {
                                setState(() {
                                  errorworkexperience.value = (value.isEmpty
                                      ? BaseString.experienceerror
                                      : "") as String;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                              width: screenWidth * 0.45,
                              child: Column(
                                children: [
                                  DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                          fillColor:
                                              Theme.of(context).focusColor,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .focusColor,
                                                width: 0.7,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.7,
                                                  color: Theme.of(context)
                                                      .focusColor
                                                      .withOpacity(0.5)),
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      value: selectedvalue,
                                      onChanged: (newValue) {
                                        setState(() {
                                          if (newValue != null) {
                                            selectedvalue = newValue;
                                            ;
                                          }
                                          if (selectedvalue ==
                                              'Select Option') {
                                            errordropdown.value =
                                                BaseString.selection;
                                          } else {
                                            errordropdown.value = "";
                                          }
                                        });
                                      },
                                      items: dropdownItems.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .focusColor,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        );
                                      }).toList()),
                                  Obx(() => errordropdown.value.isNotEmpty
                                      ? Text(
                                          errordropdown.value ?? "",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 14),
                                        )
                                      : Text(""))
                                ],
                              )
                              /* child: CustomEditTextField(
                              hintText: BaseString.companyhint,
                              labelText: BaseString.companylabel,
                              borderColor: Colors.red,
                              keyboardType: TextInputType.text,
                                controller: _companyname,
                                errorMsg: errorcompanyname,
                            ),*/
                              ),
                        ],
                      ),

                      Column(
                        children: [
                          DropdownButtonFormField<LoadCountry>(
                            isExpanded: true,
                            decoration: InputDecoration(
                                fillColor: Theme.of(context).focusColor,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).focusColor,
                                      width: 0.7,
                                    ),
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.7,
                                        color: Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(10))),
                            value: selectedCountry,
                            // Set the initial value or null
                            onChanged: (LoadCountry? newValue) {
                              // Handle dropdown item selection
                              setState(() {
                                if (newValue != null)
                                  selectedCountry = newValue;
                                if (selectedCountry.name == "Select Country") {
                                  errorcountrydropdown.value =
                                      BaseString.selectionCountry;
                                } else {
                                  errorcountrydropdown.value = "";
                                }
                                // Perform actions based on the selected item if needed
                              });
                            },
                            items: _items.map((LoadCountry value) {
                              return DropdownMenuItem<LoadCountry>(
                                  value: value,
                                  child: Text(
                                    value.name,
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontWeight: FontWeight.normal),
                                  ));
                            }).toList(),
                          ),
                          Obx(() => errorcountrydropdown.value.isNotEmpty
                              ? Text(
                                  errorcountrydropdown.value ?? "",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14),
                                )
                              : Text(""))
                        ],
                      ),

                      CustomButton(
                          btnText: BaseString.registerButton,
                          btnColor: Colors.red,
                          onPressed: () {
                            if (_firstname.text.isEmpty) {
                              erromsg.value = BaseString.firstname;
                            } else {
                              erromsg.value = "";
                              if (_lastname.text.isEmpty) {
                                errormsglastname.value =
                                    BaseString.lastnameerror;
                              } else {
                                errormsglastname.value = "";
                                if (_Address.text.isEmpty) {
                                  erroraddress.value = BaseString.addresshint;
                                } else {
                                  erroraddress.value = "";
                                  if (_email.text.isEmpty) {
                                    errormsgemail.value = BaseString.emailerror;
                                  } else {
                                    errormsgemail.value = "";
                                    if (!RegExp(BaseString.emailRegexp)
                                        .hasMatch(_email.text)) {
                                      errormsgemail.value =
                                          BaseString.emailerrorvalidate;
                                    } else {
                                      errormsgemail.value = "";
                                      if (_Phone.text.isEmpty) {
                                        errorphone.value =
                                            BaseString.phoneerror;
                                      } else {
                                        errorphone.value = "";
                                        if (_Phone.text.length != 10) {
                                          errorphone.value =
                                              BaseString.phonevalidation;
                                        } else {
                                          errorphone.value = "";
                                          if (_password.text.isEmpty) {
                                            errorpassword.value =
                                                BaseString.passworderror;
                                          } else {
                                            errorpassword.value = "";
                                            if (!RegExp(
                                                    BaseString.passwordRegexp)
                                                .hasMatch(_password.text)) {
                                              errorpassword.value =
                                                  BaseString.passwordformet;
                                            } else {
                                              errorpassword.value = "";
                                              if (_Cpassword.text.isEmpty) {
                                                errorconfirmpassword.value =
                                                    BaseString
                                                        .confirmPassworderror;
                                              } else {
                                                if (_password.text.toString() !=
                                                    _Cpassword.text
                                                        .toString()) {
                                                  errorconfirmpassword.value =
                                                      BaseString
                                                          .confirmPasswordnotmatch;
                                                } else {
                                                  errorconfirmpassword.value =
                                                      "";
                                                  if (_Experience
                                                      .text.isEmpty) {
                                                    errorworkexperience.value =
                                                        BaseString
                                                            .experienceerror;
                                                  } else {
                                                    errorworkexperience.value =
                                                        "";
                                                    if (selectedvalue ==
                                                        'Select Option') {
                                                      errordropdown.value =
                                                          BaseString.selection;
                                                    } else {
                                                      if (selectedCountry
                                                              .name ==
                                                          "Select Country") {
                                                        errordropdown.value =
                                                            "";
                                                        errorcountrydropdown
                                                                .value =
                                                            BaseString
                                                                .selectionCountry;
                                                      } else {
                                                        errorcountrydropdown
                                                            .value = "";
                                                        _incrementCounter();
                                                        Navigator.of(context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            MyHomePage()));
                                                        /*   Navigator.push(
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
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                              /* else{
                                errormsglastname.value="";
                              }*/
                            }
                          }
                          /*showCountryPicker(
                              context: context,
                              onSelect: (co) {
                                readJson();
                              });*/
                          ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

Future<List<LoadCountry>> readJson() async {
  List<LoadCountry> _items = [];
  final String response = await rootBundle.loadString('assets/Country.json');
  final data = await loadCountryFromJson(response);
  _items.addAll(data);
  print(_items);
  return _items;
}
