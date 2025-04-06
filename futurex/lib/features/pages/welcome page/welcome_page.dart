import 'package:flutter/material.dart';
import 'package:futurex/common_widget/common_widget.dart';
import 'package:futurex/utils/color_collections.dart';

class Welcome_Page extends StatelessWidget {
  const Welcome_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorCollections.ThemeColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 100),
                child: Image.asset(
                  "assets/logo/futurex_logo.png",
                  height: 70,
                ),
              ),
            ),
            ReusableText(
              FromTop: 15,
              TextString: "Your personal study assistant",
              FontSize: 25,
            ),
            ReusableText(
              FromLeft: 15,
              FromRight: 10,
              FromTop: 10,
              TextString: "Smart study timer, daily quizzes, and progress",
              FontSize: 15,
            ),
            ReusableText(
              TextString: "tracking to help you succeed",
              FontSize: 15,
            ),
            ReusableContainer(
                context,
                Icons.timer_outlined,
                "Smart Study Timer",
                "Focus better with our Pomodoro timer",
                40),
            ReusableContainer(context, Icons.psychology, "Daily Quizzes",
                "Test your knowledge regularly", 15),
            ReusableContainer(context, Icons.analytics, "Track Progress",
                "Monitor your improvement over time", 15),
            InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context,
                    '/welcome_profile_setup_1_page', (predicate) => true);
              },
              child: Container(
                margin: EdgeInsets.only(top: 40),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: ColorCollections.PrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: ReusableText(
                    TextColor: ColorCollections.ThemeColor,
                    TextString: "Get Started",
                    FontSize: 18,
                    TextFontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ReusableText(
              TextColor: ColorCollections.PrimaryColor,
              FromTop: 10,
              TextString: "Takes only 2 minutes to set up",
              FontSize: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget ReusableContainer(BuildContext context, IconData icon, String title,
      String subtitle, double marginTop) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      height: 85,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 34, 152, 206),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Icon(
              icon,
              size: 45,
              color: ColorCollections.PrimaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  FromTop: 15,
                  FromBottom: 0,
                  TextString: title,
                  FontSize: 18,
                  TextFontWeight: FontWeight.bold,
                ),
                ReusableText(
                  TextString: subtitle,
                  FontSize: 14,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
