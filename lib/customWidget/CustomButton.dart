import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({super.key, required this.btnText,required this.btnColor, required this.onPressed});
  final String btnText;
  final MaterialColor btnColor;
  final VoidCallback onPressed;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
        child: ElevatedButton(onPressed: widget.onPressed, child: Text(
          widget.btnText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
          style: ElevatedButton.styleFrom(
              backgroundColor: widget.btnColor
          ),
        )
    );
  }
}
