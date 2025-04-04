import 'package:flutter/material.dart';
import 'package:futurex/models/notificationModel.dart';
import 'package:futurex/services/notification_services.dart';

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
      body:ListView(
        children: [
          ElevatedButton(
              onPressed: (){
                (noObj);
              },
              child: Text(
                  "Click me if you dare"),
          ),
        ],
      ),
    );
  }
}
