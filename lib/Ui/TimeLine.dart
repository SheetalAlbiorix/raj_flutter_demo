import 'package:another_stepper/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeLine extends StatefulWidget {
  final String date;

  const TimeLine({Key? key, required this.date}) : super(key: key);

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  late List<StepperData> stepperData;
  int workAnniversaryCount = 1;

  @override
  void initState() {
    super.initState();

    stepperData = generateStepperData();
  }

  List<StepperData> generateStepperData() {
    try {
      DateTime joinDate = DateTime.parse(widget.date);
      DateTime currentDate = DateTime.now();
      List<StepperData> generatedData = [];
      final dateFormat = DateFormat('dd MMM, yyyy');

      // Initial StepperData
      generatedData.add(
        StepperData(
          title: StepperText("Joined Albiorix Technology",
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          subtitle: StepperText(dateFormat.format(joinDate)),
          iconWidget: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Icon(Icons.timer, color: Colors.white),
          ),
        ),
      );

      // Generate additional StepperData for each year
      for (int i = 1;
          joinDate.add(Duration(days: 365 * i)).isBefore(currentDate);
          i++) {
        DateTime anniversaryDate = joinDate.add(Duration(days: 365 * i));
        generatedData.add(
          StepperData(
            title: StepperText("${workAnniversaryCount} Work Anniversary",
                textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            subtitle: StepperText(dateFormat.format(anniversaryDate)),
            iconWidget: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Icon(Icons.timer, color: Colors.white),
            ),
          ),
        );
        workAnniversaryCount++;
      }
      generatedData.add(
        StepperData(
          title: StepperText("Currernt Activity",
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          subtitle: StepperText(dateFormat.format(currentDate)),
          iconWidget: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Icon(Icons.timer, color: Colors.white),
          ),
        ),
      );

      return generatedData;
    } catch (e) {
      print("Error parsing date: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: AnotherStepper(
                stepperList: stepperData,
                stepperDirection: Axis.vertical,
                inActiveBarColor: Colors.redAccent,
                iconWidth: 40,
                iconHeight: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
