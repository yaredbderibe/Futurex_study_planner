import 'package:flutter/material.dart';
import 'package:futurex/services/storage_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Global {
  static late StorageServices storageServices;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    storageServices = await StorageServices().init();
    // await dotenv.load(fileName: ".env");
  }
}
