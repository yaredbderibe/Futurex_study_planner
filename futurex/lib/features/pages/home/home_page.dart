import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:futurex/common_widget/common_widget.dart';
import 'package:futurex/features/pages/home/bloc/home_bloc.dart';
import 'package:futurex/models/notificationModel.dart';
import 'package:futurex/services/notification_services.dart';
import 'package:futurex/utils/color_collections.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  NotificationsSentObject noObj = NotificationsSentObject(
    content: "content",
    isSent: false,
    date: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            ReusableText(
              TextColor: Colors.black,
              FromLeft: 15,
              FromRight: 10,
              FromTop: 50,
              TextString: "Hi,Yared!",
              FontSize: 35,
              TextFontWeight: FontWeight.w900,
            ),
            ReusableText(
              TextColor: Colors.grey.shade500,
              FromLeft: 15,
              FromRight: 10,
              // FromTop: 130,
              TextString: "Here's your study plan for today",
              FontSize: 20,
              TextFontWeight: FontWeight.w600,
            ),
            BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.all(12),
                  // height: 250,
                  // width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                        TextColor: Colors.black,
                        TextString: "Today's plan",
                        FontSize: 20,
                        FromBottom: 20,
                        TextFontWeight: FontWeight.w900,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, index) {
                            final planDone = state.todo ?? [];
                            bool? isPlanDone =
                                planDone.any((elm) => elm.index == index);

                            return homePlanRow(context, planTxt[index],
                                isPlanDone ?? false, index, planDone);
                          }),
                      ReusableContainer(context, Icons.timer_outlined,
                          "Start Study Sessions", 20),
                    ],
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(12),
              // height: 250,
              // width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReusableText(
                    TextColor: Colors.black,
                    TextString: "Quick Morning Questions",
                    FontSize: 20,
                    FromBottom: 10,
                    TextFontWeight: FontWeight.w900,
                  ),
                  ReusableText(
                    TextColor: Colors.black54,
                    TextString: "Test your knowledge with 5 quick questions",
                    FontSize: 16,
                    FromBottom: 10,
                    TextFontWeight: FontWeight.w500,
                  ),
                  ReusableContainer(
                      context, Icons.memory, "Take 5 Quick Question", 15),
                ],
              ),
            ),
            MotivationalReusableContainer(context, Icons.bar_chart,
                "Stay Consistent", "You got this!", 10)
          ],
        ),
      ),
    );
  }

  List<String> planTxt = [
    "Math Chapter 5 Review",
    "Science Lab Report",
    "History Essay Research"
  ];

  Widget MotivationalReusableContainer(BuildContext context, IconData icon,
      String title, String subtitle, double marginTop) {
    return Container(
      margin: EdgeInsets.only(top: marginTop, left: 10, right: 10),
      height: 85,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue, Colors.grey.shade50]),
        color: Colors.blue.shade400,
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
                  FontSize: 16,
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

  Widget ReusableContainer(
      BuildContext context, IconData icon, String title, double marginTop) {
    return Container(
      margin: EdgeInsets.only(top: marginTop),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.blue.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // margin: EdgeInsets.only(left: 15),
            child: Icon(
              icon,
              size: 30,
              color: ColorCollections.PrimaryColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: ReusableText(
              // FromTop: 15,
              FromBottom: 0,
              TextString: title,
              FontSize: 16,
              TextFontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget homePlanRow(BuildContext context, String content, bool is_todo_done,
      int index, List<TodoObject> todo) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              final subjectExists = todo.any((sub) => sub.index == index);

              if (!subjectExists) {
                // Add new subject
                context.read<HomeBloc>().add(
                    HomeTodoButtonClickEvent(is_todo_done: true, index: index));
              } else {
                // Remove existing subject
                final updatedSubjects =
                    todo.where((elm) => elm.index != index).toList();

                context
                    .read<HomeBloc>()
                    .add(HomeTodoButtonClickEvent(todo: updatedSubjects));
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 5, top: 3),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade500),
              ),
              child: is_todo_done
                  ? Icon(
                      Icons.check,
                      color: Colors.blue, // ✅ blue tick
                      size: 20,
                    )
                  : null,
            ),
          ),

          // ✅ Strike through text if done
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Text(
              content,
              style: TextStyle(
                color: is_todo_done ? Colors.grey : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                decoration: is_todo_done
                    ? TextDecoration.lineThrough
                    : TextDecoration.none, // ✅ strike-through when done
              ),
            ),
          ),
        ],
      ),
    );
  }
}
