import 'package:flutter/material.dart';
import 'package:football_trivia/components/custom_button.dart';
import 'package:football_trivia/players_data/questions.dart';
import 'package:football_trivia/pages/view_answer_page.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
    required this.elapsedTime,
  });

  final void Function() onRestart;
  final List<String> chosenAnswers;
  final int elapsedTime;

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < widget.chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].questionText,
          'correct_answer': questions[i].answers[0],
          'user_answer': widget.chosenAnswers[i]
        },
      );
    }
    return summary;
  }

  void openViewAnswer(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => ViewAnswerPage(chosenAnswers: widget.chosenAnswers),
    );
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
            const Text(
              'RESULTS',
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff38649c),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff0066cc),
                            Color(0xff00ffcc),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 8,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Your Score',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              '${numCorrectQuestions * 10}%',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 2,
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.amber,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.access_time_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${((widget.elapsedTime % 3600) ~/ 60).toString().padLeft(2, '0')}:${(widget.elapsedTime % 60).toString().padLeft(2, '0')}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'Completion Time',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    numCorrectQuestions.toString(),
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'Correct',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.purple,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.quiz,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    '25',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'Total Question',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Container(
                                    height: 25,
                                    width: 25,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.cancel,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${(numTotalQuestions - numCorrectQuestions)}',
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                'Wrong',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(
                      onTap: widget.onRestart,
                      buttonText: 'Restart',
                      iconData: Icons.refresh,
                    ),
                    CustomButton(
                      onTap: () => openViewAnswer(context),
                      buttonText: 'View Answer',
                      iconData: Icons.visibility_rounded,
                    ),
                  ],
                ),
              ),
            ),
            // QuestionsSummary(summaryData),
          ],
        ),
      ),
    );
  }
}
