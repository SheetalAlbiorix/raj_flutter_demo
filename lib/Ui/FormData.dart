import 'dart:io';

import 'package:demo/Ui/MyHomePage.dart';
import 'package:demo/customWidget/CustomFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:path_provider/path_provider.dart';

import '../Model/UserData.dart';
import '../Model/UserDetailModel.dart';
import '../basestring/BaseString.dart';

class FormDetail extends StatelessWidget {
  const FormDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NewUser"),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, '/derawer');
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: MyCustomForm());
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

var nameError = "".obs;
var DesignationError = "".obs;
var LocationError = "".obs;

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        _dateController.text = picked.toString();
        selectedDate = picked;
      });
    }
  }

  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _departmentController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _aboutController = TextEditingController();
  TextEditingController _aboutjobController = TextEditingController();
  TextEditingController _hobbiesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Image(
                  image: AssetImage("assets/user.jpg"),
                  height: 150,
                ),
                CustomFormField(
                  hintText: BaseString.formnamelbl,
                  labelText: BaseString.formnamehint,
                  controller: _nameController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(BaseString.flname)),
                  ],
                  keyboardType: TextInputType.name,
                  icon: Icons.person,
                  autovalid: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return BaseString.formnamelbl;
                    }
                    return null;
                  },
                  /* errorMsg: nameError,*/
                ),
                CustomFormField(
                  hintText: BaseString.formdesignationhint,
                  labelText: BaseString.formdesignationlbl,
                  icon: Icons.accessibility_new_outlined,
                  controller: _designationController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(BaseString.flname)),
                  ],
                  keyboardType: TextInputType.name,
                  autovalid: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return BaseString.formdesignationhint;
                    }
                    return null;
                  },
                  /*errorMsg: DesignationError,*/
                ),
                CustomFormField(
                  hintText: BaseString.formlocationhint,
                  labelText: BaseString.formlocationlbl,
                  icon: Icons.location_on,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(BaseString.flname)),
                  ],
                  keyboardType: TextInputType.name,
                  controller: _locationController,
                  autovalid: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return BaseString.formlocationhint;
                    }
                    return null;
                  },
                  /*    errorMsg: LocationError,*/
                ),
                CustomFormField(
                  hintText: BaseString.Departmenthint,
                  labelText: BaseString.Departmentlbl,
                  keyboardType: TextInputType.name,
                  icon: Icons.local_fire_department_sharp,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(
                        RegExp(BaseString.flname)),
                  ],
                  controller: _departmentController,
                  autovalid: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return BaseString.Departmenthint;
                    }
                    return null;
                  },
                  /*    errorMsg: LocationError,*/
                ),
                CustomFormField(
                  hintText: BaseString.formemailhint,
                  labelText: BaseString.formemaillbl,
                  icon: Icons.email,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  autovalid: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return BaseString.emailhint;
                    }
                    if (!RegExp(BaseString.emailRegexp).hasMatch(value)) {
                      return BaseString.emailvalidation;
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  hintText: BaseString.formphonehint,
                  labelText: BaseString.formphonelbl,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(
                        RegExp(BaseString.rangephone)),
                  ],
                  icon: Icons.phone,
                  keyboardType: TextInputType.number,
                  controller: _numberController,
                  autovalid: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return BaseString.formphonehint;
                    }
                    if (value.length == 10) {
                      return null;
                    }
                    return BaseString.phonevalidation;
                  },
                ),
                CustomFormField(
                  hintText: BaseString.formdatehint,
                  labelText: BaseString.formdatelbl,
                  keyboardType: TextInputType.name,
                  icon: Icons.date_range,
                  controller: _dateController,
                  autovalid: AutovalidateMode.onUserInteraction,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return BaseString.formdatehint;
                    }
                    return null;
                  },
                  onTap: () => {_selectDate(context)},
                ),
                CustomFormField(
                  hintText: BaseString.formabouthint,
                  labelText: BaseString.formaboutlbl,
                  keyboardType: TextInputType.name,
                  icon: Icons.add_box_outlined,
                  controller: _aboutController,
                  minLines: 3,
                  autovalid: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return BaseString.formabouthint;
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  hintText: BaseString.formaboujobthint,
                  labelText: BaseString.formaboutjoblbl,
                  icon: Icons.data_object_outlined,
                  controller: _aboutjobController,
                  keyboardType: TextInputType.name,
                  minLines: 3,
                  autovalid: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return BaseString.formphonehint;
                    }
                    return null;
                  },
                ),
                CustomFormField(
                  hintText: BaseString.formhobbihint,
                  labelText: BaseString.formhobbilbl,
                  icon: Icons.playlist_add_check,
                  keyboardType: TextInputType.name,
                  controller: _hobbiesController,
                  minLines: 3,
                  autovalid: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return BaseString.formhobbihint;
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      UserData userData = UserData(
                        image: null,
                        name: _nameController.text,
                        designation: _designationController.text,
                        location: _locationController.text,
                        department: _departmentController.text,
                        email: _emailController.text,
                        phoneNumber: _numberController.text,
                        dateOfBirth: _dateController.text,
                        about: _aboutController.text,
                        aboutJob: _aboutjobController.text,
                        hobbies: _hobbiesController.text,
                      );

                      UserDetailModel userDetailModel = UserDetailModel(
                        image: null,
                        name: userData.name,
                        designation: userData.designation,
                        loaction: userData.location,
                        department: userData.department,
                        email: userData.email,
                        mobile: userData.phoneNumber,
                        myDate: userData.dateOfBirth,
                        about: userData.about,
                        myjob: userData.aboutJob,
                        hobbies: userData.hobbies,
                      );
                      try {
                        Directory cacheDirectory =
                            await getTemporaryDirectory();
                        String filePath =
                            "${cacheDirectory.path}/UserDetail.json";

                        List<UserDetailModel> jsonData = [];
                        File file = File(filePath);
                        if (file.existsSync()) {
                          String jsonString = await file.readAsString();
                          jsonData = userDetailModelFromJson(jsonString);
                        }

                        jsonData.add(userDetailModel);

                        String updatedJsonString =
                            userDetailModelToJson(jsonData);
                        await file.writeAsString(updatedJsonString,
                            flush: true);

                        final directory =
                            await getApplicationDocumentsDirectory();
                        final path = directory.path;
                        final MyFilePath = "$path/json.txt";

                        File localfile = File(MyFilePath);
                        await localfile.writeAsString(updatedJsonString,
                            flush: true);
                        var readingfile = await localfile.readAsString();

                        print(
                            "-------------------------$readingfile----------------------------------");

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                        );
                      } catch (e) {
                        print("Error updating JSON file: $e");
                        // Handle errors, if any
                      }
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
