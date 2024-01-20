import 'package:flutter/material.dart';
import 'package:football_trivia/components/answer_button.dart';
import 'package:football_trivia/data/questions.dart';
import 'package:football_trivia/utils/styles.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({
    super.key,
    required this.onSelectAnswer,
    required this.startElapsedTimeTimer,
    required this.elapsedTime,
    required this.totalTime,
  });

  final void Function(String answer) onSelectAnswer;
  final void Function() startElapsedTimeTimer;
  final int elapsedTime;
  final int totalTime;

  @override
  State<QuestionsPage> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsPage> {
  var currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.startElapsedTimeTimer();
  }

  void answerQuestion(String selectedAnswers) {
    widget.onSelectAnswer(selectedAnswers);
    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final shuffledAnswers = currentQuestion.shuffledAnswers;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Container(
            //   width: double.infinity,
            //   height: 35,
            //   decoration: BoxDecoration(
            //     border: Border.all(color: const Color(0xFF3F4768), width: 3),
            //     borderRadius: BorderRadius.circular(50),
            //   ),
            //   child: const Stack(
            //     children: [],
            //   ),
            // ),

            SizedBox(
              height: 25,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: widget.elapsedTime / widget.totalTime,
                  backgroundColor: Colors.grey,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
            Text(
              '${(widget.elapsedTime / widget.totalTime * 100).toStringAsFixed(1)}% Complete',
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            // Text(
            //   'Time spent: ${(widget.elapsedTime ~/ 3600).toString().padLeft(2, '0')}:${((widget.elapsedTime % 3600) ~/ 60).toString().padLeft(2, '0')}:${(widget.elapsedTime % 60).toString().padLeft(2, '0')}',
            //   style: const TextStyle(fontSize: 16.0, color: Colors.white),
            // ),
            const SizedBox(height: 10),
            Container(
              height: 360,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text('Image Here'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // question number
                    Text(
                      'Question ${currentQuestionIndex + 1} / 20',
                      style: TextAppearance.bebasNeueSmall,
                    ),
                    const SizedBox(height: 10),
                    // question text
                    Text(
                      currentQuestion.questionText,
                      style: TextAppearance.bebasNeueMedium,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            ...shuffledAnswers.map(
              (answer) {
                return AnswerButton(
                  answerText: answer,
                  onTap: () {
                    answerQuestion(answer);
                  },
                );
              },
            ),
            // ...currentQuestion.shuffledAnswers.map(
            //   (answer) {
            //     return AnswerButton(
            //       answerText: answer,
            //       onTap: () {
            //         answerQuestion(answer);
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
