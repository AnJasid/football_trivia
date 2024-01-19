import 'dart:async';

import 'package:flutter/material.dart';
import 'package:football_trivia/data/questions.dart';
import 'package:football_trivia/pages/questions_page.dart';
import 'package:football_trivia/pages/results_page.dart';
import 'package:football_trivia/pages/start_page.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  // ignore: unused_field
  late Timer _elapsedTimeTimer;
  int _elapsedTime = 0;

  void startElapsedTimeTimer() {
    _elapsedTimeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime++;
      });
    });
  }

  List<String> _selectedAnswers = [];
  String activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    _selectedAnswers.add(answer);

    if (_selectedAnswers.length == questions.length) {
      _elapsedTimeTimer.cancel();
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      _selectedAnswers = [];
      activeScreen = 'questions-screen';
      _elapsedTime = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartPage(switchScreen);
    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsPage(
        onSelectAnswer: chooseAnswer,
        startElapsedTimeTimer: startElapsedTimeTimer,
        elapsedTime: _elapsedTime,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsPage(
        chosenAnswers: _selectedAnswers,
        onRestart: restartQuiz,
        elapsedTime: _elapsedTime,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey[700],
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
