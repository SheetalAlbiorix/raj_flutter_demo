import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:get/get.dart';

class CustomEditTextField extends StatelessWidget {
  RxString errorMsg;
  String hintText;
  String labelText;
  bool readOnly;
  bool obsecureText;
  MaterialColor borderColor;
  TextInputType keyboardType;
  TextEditingController? controller;
  Function(String) onChanged;
  Widget? suffixIcon;
  int? minLines;
  int? maxLines;
  TextInputAction? textInputAction;
  List<TextInputFormatter>? inputFormatters = null;
  bool bottomPad;

  CustomEditTextField(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.borderColor,
      required this.keyboardType,
      this.readOnly = false,
      this.obsecureText = false,
      this.controller,
      required this.errorMsg,
      required this.onChanged,
      this.suffixIcon,
      this.textInputAction,
      this.inputFormatters,
      this.minLines = 1,
      this.maxLines,
      this.bottomPad = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: TextField(
            textInputAction: textInputAction,
            minLines: minLines,
            maxLines: minLines! > 1 ? null : 1,
            inputFormatters: inputFormatters,
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
                alignLabelWithHint: true,
                suffixIcon: suffixIcon,
                /*labelStyle: TextStyle(
                  color: borderColor
                ),*/
                hintText: hintText,
                labelText: labelText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.black),
                )),
            readOnly: readOnly,
            obscureText: obsecureText,
            keyboardType: keyboardType,
          ),
        ),
        Obx(() => errorMsg.value.isNotEmpty
            ? Text(
                errorMsg.value ?? "",
                style: TextStyle(color: Colors.red, fontSize: 13),
              )
            : bottomPad ? Text("") : SizedBox()),
        bottomPad
            ? SizedBox(
                height: 6,
              )
            : SizedBox(),
      ],
    );
  }
}
