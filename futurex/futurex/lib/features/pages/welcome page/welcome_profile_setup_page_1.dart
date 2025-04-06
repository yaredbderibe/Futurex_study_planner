import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futurex/common_widget/common_widget.dart';
import 'package:futurex/features/pages/welcome%20page/welcome_page_1_bloc/welcome_profile_setup_bloc.dart';
import 'package:futurex/utils/color_collections.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class Welcome_Profile_Setup_Page_1 extends StatelessWidget {
   Welcome_Profile_Setup_Page_1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: LinearProgressBar(
                maxSteps: 5,
                progressType:
                    LinearProgressBar.progressTypeLinear, // Use Linear progress
                currentStep: 1,
                progressColor: Colors.blue,
                backgroundColor: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10), //  NEW
              ),
            ),
            ReusableText(
              TextColor: Colors.blue.shade600,
              FromLeft: 15,
              FromRight: 10,
              FromTop: 130,
              TextString: "Set your profile",
              FontSize: 25,
              TextFontWeight: FontWeight.bold,
            ),
            Row(
              children: [
                ReusableText(
                  TextColor: Colors.black,
                  FromLeft: 15,
                  FromRight: 10,
                  FromTop: 50,
                  TextString: "Your name",
                  FontSize: 18,
                  // TextFontWeight: FontWeight.bold,
                ),
                Expanded(child: Container()),
              ],
            ),
            reusableTextField(
              FromLeft: 15,
              FromRight: 25,
              hintText: "Enter your name",
              textType: "name",
              onchange: (onchange) {},
            ),
            Row(
              children: [
                ReusableText(
                  TextColor: Colors.black,
                  FromLeft: 15,
                  FromRight: 10,
                  FromTop: 20,
                  TextString: "Your grade",
                  FontSize: 18,
                  // TextFontWeight: FontWeight.bold,
                ),
                Expanded(child: Container()),
              ],
            ),
            BlocConsumer<WelcomeProfileSetupBloc, WelcomeProfileSetupState>(
              listener: (context, state) {
                // TODO: implement listener
                print("button clicked.");
              },
              builder: (context, state) {
                print("value: ${state.value}");
                print("value: ${state.contColor}");
                print("value: ${state.txtColor}");
                print("value: ${state.content}");

                return Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<WelcomeProfileSetupBloc>().add(
                              WelcomeProfileSetupButtonClickedEvent(
                                  value: index,
                                  contColor: Colors.blue,
                                  txxtColor: Colors.white,
                                  content: contentOfButton[index] ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 4),
                          height: 40.h,
                          width: 110.w,
                          decoration: BoxDecoration(
                            color: index==state.value ? state.contColor : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Center(
                            child: ReusableText(
                              TextColor: index==state.value ? state.txtColor : Colors.black,
                              // FromTop: 50,
                              TextString: contentOfButton[index],
                              FontSize: 18,
                              // TextFontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            InkWell(
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(context, '/welcome_profile_setup_2_page', (predicate)=>true);
              },
              child: Container(
                margin: EdgeInsets.only(top: 40),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: ReusableText(
                    TextColor: Colors.white,
                    TextString: "Next",
                    FontSize: 18,
                    TextFontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userGradeChooseButton(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<WelcomeProfileSetupBloc>().add(
            WelcomeProfileSetupButtonClickedEvent(
                value: 2,
                contColor: Colors.blue,
                txxtColor: Colors.white,
                content: "content"));
      },
      child: Container(
        height: 40.h,
        width: 120.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Center(
          child: ReusableText(
            TextColor: Colors.blue.shade600,
            // FromTop: 50,
            TextString: "Grade 10",
            FontSize: 18,
            // TextFontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
  List<String> contentOfButton = [
    "Grade 10",
    "Grade 11",
    "Grade 12",
  ];
}
