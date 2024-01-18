import 'package:flutter/material.dart';
import 'package:football_trivia/components/answer_button.dart';
import 'package:football_trivia/data/questions.dart';
import 'package:football_trivia/utils/styles.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<QuestionsPage> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsPage> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswers) {
    widget.onSelectAnswer(selectedAnswers);
    // currentQuestionIndex = currentQuestionIndex + 1;
    // currentQuestionIndex += 1;
    setState(() {
      currentQuestionIndex++; // increments the value by 1
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 360,
              width: 390,
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
            ...currentQuestion.shuffledAnswers.map(
              (answer) {
                return AnswerButton(
                  answerText: answer,
                  onTap: () {
                    answerQuestion(answer);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
