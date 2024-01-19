import 'package:flutter/material.dart';
import 'package:football_trivia/data/questions.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
    required this.elapsedTime,
  });

  final void Function() onRestart;
  final List<String> chosenAnswers;
  final int elapsedTime;

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
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((data) => data['user_answer'] == data['correct_answer'])
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 521,
              width: double.infinity,
              child: Stack(
                children: [
                  Container(
                    height: 340,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: CircleAvatar(
                        radius: 85,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        child: CircleAvatar(
                          radius: 71,
                          backgroundColor: Colors.white.withOpacity(0.4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Your Score'),
                              Text('${numCorrectQuestions * 10}%'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 70,
                    left: 20,
                    child: Container(
                      height: 190,
                      width: 330,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text('$numCorrectQuestions'),
                          Text(
                              '${(elapsedTime ~/ 3600).toString().padLeft(2, '0')}:${((elapsedTime % 3600) ~/ 60).toString().padLeft(2, '0')}:${(elapsedTime % 60).toString().padLeft(2, '0')}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // QuestionsSummary(summaryData),
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Restart',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
