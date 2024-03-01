import 'package:demo/Model/UserDetailModel.dart';
import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  final UserDetailModel item;

  const SummaryScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  void _showImageAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              widget.item.image == null ? Colors.red : Color(0x01000000),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.item.image == null
                  ? Container(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (String word in widget.item.name.split(" "))
                          Text(
                            word.isNotEmpty ? word[0] : '',
                            style: TextStyle(
                                fontSize: 150,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                      ],
                    ))
                  : Image.asset(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fitWidth,
                      widget.item.image!, // Replace with your image path
                      height: 300, // Adjust image width as needed
                    ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _showImageAlertDialog(context);
                },
                child: CircleAvatar(
                  backgroundImage: widget.item.image == null
                      ? null
                      : AssetImage(widget.item.image!),
                  backgroundColor:
                      widget.item.image == null ? Colors.red : null,
                  radius: 50,
                  child: widget.item.image == null
                      ? Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (String word in widget.item.name.split(" "))
                                Text(
                                  word.isNotEmpty ? word[0] : '',
                                  style: TextStyle(
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                            ],
                          ),
                        )
                      : null,
                ),
              ),
              SizedBox(height: 16),
              Text(
                widget.item.name ?? "",
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontSize: 20,
                ),
              ),
              Divider(
                color: Theme.of(context).focusColor,
              ),
              SizedBox(height: 5),
              Text(
                "About",
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.item.about}",
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
              SizedBox(height: 5),
              Divider(
                color: Theme.of(context).focusColor,
              ),
              SizedBox(height: 5),
              Text(
                "What I love about my job?",
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.item.myjob}",
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
              SizedBox(height: 5),
              Divider(
                color: Theme.of(context).focusColor,
              ),
              SizedBox(height: 5),
              Text(
                "My interests and hobbies",
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.item.hobbies}",
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
              SizedBox(height: 5),
              Divider(
                color: Theme.of(context).focusColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
