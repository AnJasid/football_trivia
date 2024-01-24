import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_trivia/pages/quiz.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.initialize("27350c67-5d07-4899-b450-10b7425fd642");
  OneSignal.Notifications.requestPermission(true);

  // to set the orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const Quiz());
}
