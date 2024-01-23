import 'package:flutter/material.dart';
import 'package:football_trivia/components/custom_button.dart';
import 'package:football_trivia/data/questions.dart';
import 'package:football_trivia/questions_summary/questions_summary.dart';

class ViewAnswerPage extends StatelessWidget {
  const ViewAnswerPage({
    super.key,
    required this.chosenAnswers,
  });

  final List<String> chosenAnswers;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].questionText,
          'correct_answer': questions[i].answers[0],
          'user_answer': chosenAnswers[i]
        },
      );
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/BG1.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SizedBox(
        height: double.infinity,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
          ),
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              QuestionsSummary(summaryData),
              const SizedBox(height: 10),
              CustomButton(
                  onTap: () => Navigator.pop(context),
                  buttonText: 'BACK',
                  iconData: Icons.arrow_back_rounded),
              // TextButton(
              //   onPressed: () {
              //     Navigator.pop(context);
              //   },
              //   child: const Text(
              //     'BACK',
              //     style: TextStyle(
              //       fontFamily: 'Cambria',
              //       fontSize: 20,
              //       fontWeight: FontWeight.w900,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
