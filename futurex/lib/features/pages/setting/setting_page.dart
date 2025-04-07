import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futurex/common_widget/common_widget.dart';
import 'package:futurex/features/pages/welcome%20page/welcome_page_1_bloc/welcome_profile_setup_bloc.dart';
import 'package:futurex/features/pages/welcome%20page/welcome_page_2_bloc/welcome_page_2_bloc.dart';
import 'package:futurex/utils/color_collections.dart';

class Settings_Page extends StatefulWidget {
  const Settings_Page({super.key});

  @override
  State<Settings_Page> createState() => _Settings_PageState();
}

class _Settings_PageState extends State<Settings_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorCollections.SecondaryColor,
         body: Container(
           margin: EdgeInsets.all(10),
           child: ListView(
             children: [
               ReusableText(
                 TextColor: Colors.black,
                 TextString: "Settings",
                 FontSize: 25,
                 TextFontWeight: FontWeight.w900,
                 // TextFontWeight: FontWeight.bold,
               ),
               ReusableText(
                 TextColor: Colors.grey.shade700,
                 TextString: "Manage your profile and preference",
                 FontSize: 20,
                 // TextFontWeight: FontWeight.w900,
                 // TextFontWeight: FontWeight.bold,
               ),
               Container(
                 padding: EdgeInsets.all(15),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(10),
                   // border: Border.all(color: Colors.grey.shade200),
                 ),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       children: [
                         Icon(Icons.person,color: Colors.blue,),
                         ReusableText(
                           FromLeft: 20,
                           TextColor: Colors.black,
                           TextString: "Personal Information",
                           FontSize: 20,
                           TextFontWeight: FontWeight.w700,
                           // TextFontWeight: FontWeight.bold,
                         ),
                       ],
                     ),
                     ReusableText(
                       FromTop: 15,
                       TextColor: Colors.black,
                       TextString: "Your name",
                       FontSize: 18,
                       TextFontWeight: FontWeight.w500,
                       // TextFontWeight: FontWeight.bold,
                     ),
                     ReusableText(
                       FromTop: 15,
                       TextColor: Colors.black54,
                       TextString: "Yared",
                       FontSize: 18,
                       TextFontWeight: FontWeight.w500,
                       // TextFontWeight: FontWeight.bold,
                     ),
                     SizedBox(height: 30,),
                     Row(
                       children: [
                         Icon(Icons.school,color: Colors.blue,),
                         ReusableText(
                           // FromTop: 40,
                           FromLeft: 20,
                           TextColor: Colors.black,
                           TextString: "Academic Information",
                           FontSize: 20,
                           TextFontWeight: FontWeight.w700,
                           // TextFontWeight: FontWeight.bold,
                         ),
                       ],
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
                         print("Your grade selected value index: ${state.value}");

                         return Container(
                           margin: EdgeInsets.only(top: 10),
                           height: 50,
                           child: ListView.builder(
                             physics: NeverScrollableScrollPhysics(),
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
                                       TextColor: index==state.value ? state.txtColor : Colors.black54,
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
                     SizedBox(height: 20,),
                     Row(
                       children: [
                         Icon(Icons.menu_book,color: Colors.blue,),
                         ReusableText(
                           // FromTop: 40,
                           FromLeft: 20,
                           TextColor: Colors.black,
                           TextString: "Subject Preference",
                           FontSize: 20,
                           TextFontWeight: FontWeight.w700,
                           // TextFontWeight: FontWeight.bold,
                         ),
                       ],
                     ),
                     ReusableText(
                       FromTop: 50,
                       FromBottom: 10,
                       TextColor: ColorCollections.TeritiaryColor,
                       TextString: "Preferred subjects",
                       FontSize: 18,
                       // TextFontWeight: FontWeight.bold,
                     ),
                     BlocConsumer<WelcomePage2Bloc, WelcomePage2State>(
                       listener: (context, state) {
                         // TODO: implement listener
                       },
                       builder: (context, state) {
                         print("Your Preferred subject selected value index: ${state.preferredSelectedSubject}");
                         final preferredSubject = state.preferredSelectedSubject ?? [];
                         return GridView.count(
                           physics: NeverScrollableScrollPhysics(),
                           crossAxisSpacing: 5,
                           mainAxisSpacing: 5,
                           childAspectRatio: 9 / 2,
                           crossAxisCount: 2,
                           shrinkWrap: true,
                           cacheExtent: 20,
                           children: List.generate(
                             6, // Number of items
                                 (index) =>
                                 InkWell(
                                   onTap: () {

                                     // Safe way to check existence
                                     final subjectExists = preferredSubject.any((sub) => sub.value == index);

                                     if (!subjectExists) {
                                       // Add new subject
                                       context.read<WelcomePage2Bloc>().add(
                                         WelcomeProfileSetup2ButtonClickedAddEvent(
                                           value: index,
                                           contColor: Colors.blue,
                                           txtColor: Colors.white,
                                           content: preferredContentOfButton[index],
                                         ),
                                       );
                                     } else {
                                       // Remove existing subject
                                       final updatedSubjects = preferredSubject.where(
                                               (elm) => elm.value != index
                                       ).toList();

                                       context.read<WelcomePage2Bloc>().add(
                                         WelcomeProfileSetup2ButtonClickedDeleteEvent(
                                           subjects: updatedSubjects,
                                         ),
                                       );
                                     }
                                   },
                                   child: Container(
                                     margin: EdgeInsets.only(right: 4),
                                     height: 40.h,
                                     width: 110.w,
                                     decoration: BoxDecoration(
                                       color: preferredSubject.any((sub) => sub.value == index) ? Colors.blue: Colors.white,
                                       borderRadius: BorderRadius.circular(10),
                                       border: Border.all(color: Colors.grey.shade200),
                                     ),
                                     child: Center(
                                       child: ReusableText(
                                         TextColor: preferredSubject.any((sub) => sub.value == index) ? Colors.white: Colors.black54,
                                         // FromTop: 50,
                                         TextString: preferredContentOfButton[index],
                                         FontSize: 18,
                                         // TextFontWeight: FontWeight.bold,
                                       ),
                                     ),
                                   ),
                                 ),
                           ),
                         );
                       },
                     ),

                     //subjects to improve

                     ReusableText(
                       FromTop: 50,
                       FromBottom: 10,
                       TextColor: ColorCollections.TeritiaryColor,
                       TextString: "Subjects to improve",
                       FontSize: 18,
                       // TextFontWeight: FontWeight.bold,
                     ),
                     BlocConsumer<WelcomePage2Bloc, WelcomePage2State>(
                       listener: (context, state) {
                         // TODO: implement listener
                       },
                       builder: (context, state) {
                         print("Your Subjects to improve selected value index: ${state.improvedSelectedSubject}");
                         final improvedSubject = state.improvedSelectedSubject ?? [];
                         return GridView.count(
                           physics: NeverScrollableScrollPhysics(),
                           crossAxisSpacing: 5,
                           mainAxisSpacing: 5,
                           childAspectRatio: 9 / 2,
                           crossAxisCount: 2,
                           shrinkWrap: true,
                           cacheExtent: 20,
                           children: List.generate(
                             6, // Number of items
                                 (index) =>
                                 InkWell(
                                   onTap: () {

                                     // Safe way to check existence
                                     final subjectExists = improvedSubject.any((sub) => sub.value == index);

                                     if (!subjectExists) {
                                       // Add new subject
                                       context.read<WelcomePage2Bloc>().add(
                                         WelcomeProfileSetup2ImproveButtonClickedAddEvent(
                                           value: index,
                                           contColor: Colors.blue,
                                           txtColor: Colors.white,
                                           content: preferredContentOfButton[index],
                                         ),
                                       );
                                     } else {
                                       // Remove existing subject
                                       final updatedSubjects = improvedSubject.where(
                                               (elm) => elm.value != index
                                       ).toList();

                                       context.read<WelcomePage2Bloc>().add(
                                         WelcomeProfileSetup2ImproveButtonClickedDeleteEvent(
                                           subjects: updatedSubjects,
                                         ),
                                       );
                                     }
                                   },
                                   child: Container(
                                     margin: EdgeInsets.only(right: 4),
                                     height: 40.h,
                                     width: 110.w,
                                     decoration: BoxDecoration(
                                       color: improvedSubject.any((sub) => sub.value == index) ? Colors.blue: Colors.white,
                                       borderRadius: BorderRadius.circular(10),
                                       border: Border.all(color: Colors.grey.shade200),
                                     ),
                                     child: Center(
                                       child: ReusableText(
                                         TextColor: improvedSubject.any((sub) => sub.value == index) ? Colors.white: Colors.black54,
                                         // FromTop: 50,
                                         TextString: preferredContentOfButton[index],
                                         FontSize: 18,
                                         // TextFontWeight: FontWeight.bold,
                                       ),
                                     ),
                                   ),
                                 ),
                           ),
                         );
                       },
                     ),
                   ],
                 ),
               ),
               SizedBox(height: 30,),
               Row(
                 children: [
                   Expanded(
                       child: reusableButtonContainer(
                           context, "Cancel", Colors.white, Colors.black)),
                   Expanded(
                       child: reusableButtonContainer(
                           context, "Save Changes", Colors.blue, Colors.white)),
                 ],
               ),
               Container(
                 padding: EdgeInsets.all(20),
                 margin: EdgeInsets.only(top: 20),
                 decoration: BoxDecoration(
                   color: Colors.red.shade100,
                   borderRadius: BorderRadius.circular(10),
                   // border: Border.all(color: Colors.grey.shade200),
                 ),
                 child:Column(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Icon(Icons.sync,color: Colors.red.shade900,),
                         ReusableText(
                           // FromTop: 50,
                           FromBottom: 10,
                           TextColor: Colors.red.shade900,
                           TextString: "Reset Progress",
                           FontSize: 18,
                           // TextFontWeight: FontWeight.bold,
                         ),
                       ],
                     ),
                     ReusableText(
                       // FromTop: 50,
                       FromBottom: 10,
                       TextColor: Colors.red.shade900,
                       TextString: "This will reset all your data and start over",
                       FontSize: 16,
                       // TextFontWeight: FontWeight.bold,
                     ),

                     reusableButtonContainer(
                         context, "Reset All Data", Colors.red.shade400, Colors.white)
                   ],
                 ),
               ),
               SizedBox(height: 20,),
             ],
           ),
         ),
    );
  }
  List<String> contentOfButton = [
    "Grade 10",
    "Grade 11",
    "Grade 12",
  ];
  List<String> preferredContentOfButton = [
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
          // Navigator.pop(context);
        } else {
          // Navigator.pushNamedAndRemoveUntil(
          //     context, '/index_page', (predicate) => true);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 3, left: 3),
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
