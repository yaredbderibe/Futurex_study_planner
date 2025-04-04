import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:futurex/features/pages/home/home_page.dart';
import 'package:futurex/route_handler/pages.dart';
import 'package:futurex/services/global.dart';
import 'package:futurex/utils/color_collections.dart';

void main() async{

  AwesomeNotifications().initialize(
    "resource://drawable/res_futurex_notifications_icon",
    [
      NotificationChannel(
        channelKey: 'Basic_channel',
        channelName: 'Basic Notification',
        defaultColor: ColorCollections.TeritiaryColor,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        playSound: true,
        // soundSource: "resource://raw/res_custom_notification",
        channelDescription: "Basic notification enables the notification for Basic event like when item matched exists.",
      ),
      NotificationChannel(
        channelKey: 'schedule_channel',
        channelName: 'Schedule Notification',
        defaultColor:  ColorCollections.QuaterneryColor,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        locked: true,
        channelDescription: "Schedule notification enables the notification for scheduled event like user not respond to the item matched.",
      ),
    ],
  );
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MultiBlocProvider(
        providers: [...NamedRouteSettings.allBlocProviders(context)],
        child: const MaterialApp(
          onGenerateRoute: NamedRouteSettings.GenerateRouteSettings,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
