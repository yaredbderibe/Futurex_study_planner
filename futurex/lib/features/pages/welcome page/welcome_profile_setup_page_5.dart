import 'package:flutter/material.dart';
import 'package:futurex/common_widget/common_widget.dart';
import 'package:futurex/utils/color_collections.dart';
import 'package:intl/intl.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class Welcome_Page_5 extends StatefulWidget {
  const Welcome_Page_5({super.key});

  @override
  State<Welcome_Page_5> createState() => _Welcome_Page_5State();
}

class _Welcome_Page_5State extends State<Welcome_Page_5> {
  DateTime? finalDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        margin: EdgeInsets.all(15),
        child: ListView(
          children: [
            buildStepProgressBar(5, 5), // 4 filled steps out of 5
            Center(
              child: ReusableText(
                FromTop: 70,
                TextColor: ColorCollections.TeritiaryColor,
                TextString: "Upcoming Final Exam",
                FontSize: 25,
                TextFontWeight: FontWeight.w900,
              ),
            ),
            Center(
              child: ReusableText(
                FromTop: 30,
                FromBottom: 0,
                TextColor: Colors.grey.shade600,
                TextString: "Select the date of your Final Exam this can",
                FontSize: 16,
                TextFontWeight: FontWeight.w400,
              ),
            ),
            Center(
              child: ReusableText(
                // FromTop: 50,
                TextColor: Colors.grey.shade600,
                TextString: " be modified later in settings",
                FontSize: 17,
                TextFontWeight: FontWeight.w400,
              ),
            ),
            InkWell(
              onTap: () => _selectDate(),
              child: Container(
                margin: EdgeInsets.only(top: 50),
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ReusableText(
                      // FromTop: 50,
                      TextColor: ColorCollections.TeritiaryColor,
                      TextString: finalDate == null
                          ? "Select the final date"
                          : DateFormat.yMMMd().add_jm().format(finalDate!),
                      FontSize: 17,
                      TextFontWeight: FontWeight.w400,
                    ),
                    Icon(Icons.calendar_month),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(height: 20,),
            reusableButtonContainer(
                context, "Continue", Colors.blue, Colors.white),
            SizedBox(height: 20,),
            reusableButtonContainer(
                context, "Back", Colors.white, Colors.black54),
          ],
        ),
      ),
    );
  }

  // String formatTime(DateTime finalDate){
  //     return ;
  // }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        finalDate = _picked;
      });
    }
  }

  Widget reusableButtonContainer(
      BuildContext context, String content, Color contColor, Color txtColor) {
    return InkWell(
      onTap: () {
        if (content == "Back") {
          Navigator.pop(context);
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, '/index_page', (predicate) => true);
        }
      },
      child: Container(
        // margin: EdgeInsets.only(top: 20, right: 3, left: 3),
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
  // Future<void> _selecteTime() async {
  //   TimeOfDay? pickTime = await showTimePicker(
  //     // barrierColor: ColorCollections.TeritiaryColor,
  //     context: context,
  //     initialTime: _timeOfDay,
  //   );
  //   if (pickTime != null) {
  //     setState(() {
  //       widget.item_model.time_picked = pickTime.hour.toString() +
  //           " : " +
  //           pickTime.minute.toString().padLeft(2, '0');
  //     });
  //   }
  // }
}
