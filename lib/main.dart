import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:football_trivia/pages/quiz.dart';

void main() {
  // to set the orientation to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const Quiz());
}
