import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  /*final RxString errorMsg;*/
  final String hintText;
  final String labelText;
  final IconData icon;
  final AutovalidateMode autovalid;
  final String? Function(String?)? validator;
  int? minLines;
  TextInputType keyboardType;
  int? maxLines;
  bool readOnly;
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters = null;

  Function()? onTap;

  CustomFormField(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.icon,
      this.minLines = 1,
      this.maxLines,
      this.controller,
      this.inputFormatters,
      /* required this.errorMsg,*/
      this.validator,
      required this.keyboardType,
      required this.autovalid,
      this.readOnly = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextFormField(
          minLines: minLines,
          maxLines: minLines! > 1 ? null : 1,
          validator: validator,
          autovalidateMode: autovalid,
          keyboardType: keyboardType,
          controller: controller,
          inputFormatters: inputFormatters,
          readOnly: readOnly,
          onTap: onTap,
          /* enabled: false,*/
          decoration: InputDecoration(
            alignLabelWithHint: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            icon: Icon(icon),
            hintText: hintText,
            labelText: labelText,
            labelStyle: TextStyle(color: Theme.of(context).focusColor),
          ),
        ),
      ),

      /*   Obx(
        () => errorMsg.value.isNotEmpty
            ? Text(
                errorMsg.value ?? "",
                style: TextStyle(color: Colors.red, fontSize: 13),
              )
            : SizedBox(),
      )*/
    ]);
  }
}
