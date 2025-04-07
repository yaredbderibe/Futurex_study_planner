import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futurex/common_widget/common_widget.dart';
import 'package:futurex/features/pages/welcome%20page/welcome_page_1_bloc/welcome_profile_setup_bloc.dart';
import 'package:futurex/utils/color_collections.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

class Welcome_Profile_Setup_Page_1 extends StatefulWidget {
  Welcome_Profile_Setup_Page_1({super.key});

  @override
  State<Welcome_Profile_Setup_Page_1> createState() =>
      _Welcome_Profile_Setup_Page_1State();
}

class _Welcome_Profile_Setup_Page_1State
    extends State<Welcome_Profile_Setup_Page_1> {
  String selectedGrade = 'None';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepProgressBar(1, 5),
            ReusableText(
              TextColor: Colors.black,
              FromLeft: 15,
              FromRight: 10,
              FromTop: 50,
              TextString: "Tell Us About Yourself",
              FontSize: 23,
              TextFontWeight: FontWeight.w900,
            ),
            ReusableText(
              TextColor: ColorCollections.TeritiaryColor,
              FromLeft: 15,
              FromRight: 10,
              FromTop: 10,
              TextString: "We're getting to know you better. Almost there!",
              FontSize: 16,
              TextFontWeight: FontWeight.w400,
            ),
            Row(
              children: [
                ReusableText(
                  TextColor: Colors.black,
                  FromLeft: 22,
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
                  FromLeft: 22,
                  FromRight: 10,
                  FromTop: 20,
                  FromBottom: 0,
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
                print("your grade selected value: ${state.value}");

                return Center(
                    child: Container(
                  margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                  height: 50,
                  child: DropdownMenu(
                      menuStyle: MenuStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(ColorCollections.SecondaryColor)),
                      width: double.infinity,
                      onSelected: (value) {
                        setState(() {
                          selectedGrade = value!;
                        });
                      },
                      initialSelection: "None",
                      inputDecorationTheme: InputDecorationTheme(
                        fillColor: ColorCollections.SecondaryColor,
                        border: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white), // Border color
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.white), // Unfocused border
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white), // Focused border
                        ),
                      ),
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                          value: "Grade 9",
                          label: "Grade 9",
                        ),
                        DropdownMenuEntry(
                          value: "Grade 10",
                          label: "Grade 10",
                        ),
                        DropdownMenuEntry(
                          value: "Grade 11",
                          label: "Grade 11",
                        ),
                        DropdownMenuEntry(
                          value: "Grade 12",
                          label: "Grade 12",
                        ),
                        DropdownMenuEntry(
                          value: "None",
                          label: "None",
                        ),
                      ]),
                ));
              },
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context,
                      '/welcome_profile_setup_2_page', (predicate) => true);
                },
                child: Container(
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
            ),
            SizedBox(height: 20,),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: ColorCollections.PrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: ReusableText(
                      TextColor: ColorCollections.Black54,
                      TextString: "Back",
                      FontSize: 18,
                      TextFontWeight: FontWeight.bold,
                    ),
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
