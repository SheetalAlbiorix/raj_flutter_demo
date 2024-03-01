import 'package:flutter/material.dart';

class WallActivity extends StatelessWidget {
  final String name;

  const WallActivity({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("assets/images.png")),
              SizedBox(
                height: 25,
              ),
              Text(
                "No Activity Found",
                style: TextStyle(
                    color: Theme.of(context).focusColor, fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                "Content created by ${name} from the Wall can be shown here",
                style: TextStyle(color: Theme.of(context).focusColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
