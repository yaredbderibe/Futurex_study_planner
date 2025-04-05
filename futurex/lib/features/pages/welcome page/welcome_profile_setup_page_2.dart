import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futurex/common_widget/common_widget.dart';
import 'package:futurex/features/pages/welcome%20page/welcome_page_2_bloc/welcome_page_2_bloc.dart';
import 'package:futurex/utils/color_collections.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:numberpicker/numberpicker.dart';

class Welcome_Profile_Setup_Page_2 extends StatefulWidget {
  Welcome_Profile_Setup_Page_2({super.key});

  @override
  State<Welcome_Profile_Setup_Page_2> createState() =>
      _Welcome_Profile_Setup_Page_2State();
}

class _Welcome_Profile_Setup_Page_2State
    extends State<Welcome_Profile_Setup_Page_2> {
  int hour = 1;
  int minute = 0;
  String timeFormat = "AM";
  int weekendStudyHour=3;
  int StudyDurationHour=3;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: LinearProgressBar(
                  maxSteps: 5,
                  progressType: LinearProgressBar
                      .progressTypeLinear, // Use Linear progress
                  currentStep: 2,
                  progressColor: Colors.blue,
                  backgroundColor: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10), //  NEW
                ),
              ),
              ReusableText(
                FromTop: 50,
                TextColor: ColorCollections.Black,
                TextString: "Study Schedule",
                FontSize: 23,
                TextFontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  ReusableText(
                    FromTop: 50,
                    TextColor: ColorCollections.Black,
                    TextString: "Preferred study time",
                    FontSize: 18,
                    TextFontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue.shade50,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NumberPicker(
                      value: hour,
                      minValue: 0,
                      maxValue: 100,
                      onChanged: (value) {
                        setState(() {
                          hour = value;
                        });
                      },
                      textStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 18),
                      selectedTextStyle:
                          TextStyle(color: Colors.blue.shade500, fontSize: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.blue),
                              bottom: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    NumberPicker(
                      value: minute,
                      minValue: 0,
                      maxValue: 100,
                      onChanged: (value) {
                        setState(() {
                          minute = value;
                        });
                      },
                      textStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 18),
                      selectedTextStyle:
                          TextStyle(color: Colors.blue.shade500, fontSize: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Colors.blue),
                              bottom: BorderSide(color: Colors.blue))),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  timeFormat = "AM";
                                });
                              },
                              child: Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: timeFormat == "AM"
                                      ? Colors.blue
                                      : Colors.blue.shade300,
                                ),
                                child: Center(
                                  child: ReusableText(
                                    TextString: "AM",
                                    FontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  timeFormat = "PM";
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 5),
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: timeFormat == "PM"
                                      ? Colors.blue
                                      : Colors.blue.shade300,
                                ),
                                child: Center(
                                  child: ReusableText(
                                    TextString: "PM",
                                    FontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    FromTop: 20,
                    FromBottom: 0,
                    TextColor: ColorCollections.Black,
                    TextString: "Study Duration(hour)",
                    FontSize: 18,
                    TextFontWeight: FontWeight.w500,
                  ),
                  ReusableText(
                    FromRight: 30,
                    FromTop: 20,
                    FromBottom: 0,
                    TextColor: ColorCollections.Black,
                    TextString: "Rest Day",
                    FontSize: 18,
                    TextFontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 5,),
                  NumberPicker(
                    value: StudyDurationHour,
                    minValue: 0,
                    maxValue: 100,
                    onChanged: (value) {
                      setState(() {
                        StudyDurationHour = value;
                      });
                    },
                    textStyle:
                        TextStyle(color: Colors.grey.shade500, fontSize: 18),
                    selectedTextStyle:
                        TextStyle(color: Colors.blue.shade500, fontSize: 20),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.blue),
                            bottom: BorderSide(color: Colors.blue))),
                  ),
                  DropdownMenu(
                      onSelected: (value) {
                        setState(() {});
                      },
                      initialSelection: "None",
                      dropdownMenuEntries: [
                        DropdownMenuEntry(
                          value: "Monday",
                          label: "Monday",
                        ),
                        DropdownMenuEntry(
                          value: "Tuesday",
                          label: "Tuesday",
                        ),
                        DropdownMenuEntry(
                          value: "Wendsday",
                          label: "Wendsday",
                        ),
                        DropdownMenuEntry(
                          value: "Thursday",
                          label: "Thursday",
                        ),
                        DropdownMenuEntry(
                          value: "Friday",
                          label: "Friday",
                        ),
                        DropdownMenuEntry(
                          value: "Saturday",
                          label: "Saturday",
                        ),
                        DropdownMenuEntry(
                          value: "Sunday",
                          label: "Sunday",
                        ),
                        DropdownMenuEntry(
                          value: "None",
                          label: "None",
                        ),
                      ]),
                ],
              ),
              Row(
                children: [
                  ReusableText(
                    FromTop: 20,
                    FromBottom: 0,
                    TextColor: ColorCollections.Black,
                    TextString: "Weekend Study hour",
                    FontSize: 18,
                    TextFontWeight: FontWeight.w500,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 30,),
                  NumberPicker(
                    value: weekendStudyHour,
                    minValue: 0,
                    maxValue: 100,
                    onChanged: (value) {
                      setState(() {
                        weekendStudyHour = value;
                      });
                    },
                    textStyle:
                    TextStyle(color: Colors.grey.shade500, fontSize: 18),
                    selectedTextStyle:
                    TextStyle(color: Colors.blue.shade500, fontSize: 20),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.blue),
                            bottom: BorderSide(color: Colors.blue))),
                  ),
                ],
              ),

              reusableButtonContainer(context,"Continue",Colors.blue,Colors.white),

              reusableButtonContainer(context,"Back",Colors.white,Colors.black),

            ],
          ),
        ),
      ),
    );
  }

  List<String> contentOfButton = [
    "Math",
    "Science",
    "History",
    "English",
    "Language",
    "Art",
  ];


  Widget reusableButtonContainer(
      BuildContext context, String content, Color contColor, Color txtColor) {
    return InkWell(
      onTap: () {
        if (content == "Back") {
          Navigator.pop(context);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, '/welcome_profile_setup_3_page', (predicate) => true);
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 10,top: 20),
        height: 55,
        // width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: contColor,
            border: Border.all(color: Colors.grey.shade300)),
        child: Center(
          child: ReusableText(
            TextColor: txtColor,
            // FromLeft: 15,
            FromRight: 10,
            // FromTop: 50,
            TextString: content,
            FontSize: 18,
            // TextFontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
