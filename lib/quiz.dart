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
      setState(() {
        activeScreen = 'results-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      _selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartPage(switchScreen);
    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsPage(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsPage(
        chosenAnswers: _selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            // gradient: LinearGradient(
            //   colors: [
            //     Color.fromARGB(255, 78, 13, 151),
            //     Color.fromARGB(255, 107, 15, 168),
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
