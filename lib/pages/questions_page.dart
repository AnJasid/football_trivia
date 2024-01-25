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
  double containerHeight = 50.0;

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
    // Initial height of the container

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Container(
          // margin: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // Text(
                  //   'Time spent: ${(widget.elapsedTime ~/ 3600).toString().padLeft(2, '0')}:${((widget.elapsedTime % 3600) ~/ 60).toString().padLeft(2, '0')}:${(widget.elapsedTime % 60).toString().padLeft(2, '0')}',
                  //   style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  // ),
                  // const SizedBox(height: 10),

                  Container(
                    // height: 600,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xff38649c),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                        bottomRight: Radius.circular(80),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 5,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Container(
                                  height: 30,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(13.5),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value:
                                          widget.elapsedTime / widget.totalTime,
                                      backgroundColor: Colors.grey[350],
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                        Color(0xff00ccff),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    alignment: Alignment.center,
                                    color: Colors.transparent,
                                    child: Text(
                                      '${(widget.elapsedTime ~/ 60).toString().padLeft(2, '0')}:${(widget.elapsedTime % 60).toString().padLeft(2, '0')}',
                                      style: const TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                currentQuestion.imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // question number
                          Text(
                            'Question ${currentQuestionIndex + 1} / 25',
                            // style: TextAppearance.bebasNeueSmall,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currentQuestion.questionText,
                            // style: TextAppearance.bebasNeueMedium,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const SizedBox(height: 25),

                          // ElevatedButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       containerHeight == 50.0
                          //           ? containerHeight = 200.0
                          //           : containerHeight = 50.0;
                          //     });
                          //   },
                          //   child: const Text('data'),
                          // ),
                          // const SizedBox(height: 16.0),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     setState(() {
                          //     containerHeight == 100.0
                          //         ? containerHeight = 200.0
                          //         : containerHeight = 100.0;
                          //   });
                          //   child: Text('dat'),
                          // ),

                          // Padding(
                          //   padding: const EdgeInsets.symmetric(vertical: 10),
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       color: Colors.transparent,
                          //       border: Border.all(
                          //         color: Colors.white,
                          //         width: 2.0,
                          //       ),
                          //     ),
                          //     child: Text(
                          //       currentQuestion.questionText,
                          //       style: TextAppearance.bebasNeueMedium,
                          //       textAlign: TextAlign.left,
                          //     ),
                          //   ),
                          // ),
                          // question text
                          // Text(
                          //   currentQuestion.questionText,
                          //   style: TextAppearance.bebasNeueMedium,
                          //   textAlign: TextAlign.left,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xff00ccff),
                              Color(0xff0066ff),
                            ]),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
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
                          ],
                        ),
                      ),
                    ),
                  ),

                  // const SizedBox(height: 40),

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
          ),
        ),
      ),
    );
  }
}
