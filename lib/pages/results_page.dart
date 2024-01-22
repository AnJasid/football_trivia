import 'package:flutter/material.dart';
import 'package:football_trivia/components/custom_button.dart';
import 'package:football_trivia/data/questions.dart';
import 'package:football_trivia/pages/start_page.dart';
import 'package:football_trivia/pages/view_answer_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int bestScore = 0;
  int bestTimeInSeconds = 0;

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

  @override
  void initState() {
    super.initState();
    // Load previous best score and best time from SharedPreferences
    loadBestScore();
    loadBestTime();
  }

  void _goToStartPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => StartPage(() {}),
      ),
    );
  }

  void openViewAnswer(BuildContext context) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const ViewAnswerPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((data) => data['user_answer'] == data['correct_answer'])
        .length;

    // Check if the current score is higher than the best score
    if (numCorrectQuestions > bestScore) {
      // Update best score in SharedPreferences
      setState(() {
        saveBestScore(numCorrectQuestions);
      });
    }

    // Check if the current time is shorter than the best time
    if (widget.elapsedTime < bestTimeInSeconds || bestTimeInSeconds == 0) {
      // Update best time in SharedPreferences
      setState(() {
        saveBestTime(widget.elapsedTime);
      });
    }

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xff38649c),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white, // Specify the color of the border
                  width: 3,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff0066cc),
                            Color(0xff00ffcc),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Your Score',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            '${numCorrectQuestions * 10}%',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
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
                                  const SizedBox(width: 2),
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
                                  const SizedBox(width: 2),
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
                                  const SizedBox(width: 2),
                                  const Text(
                                    '20',
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
                                  const SizedBox(width: 2),
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
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 30),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             children: [
                    //               Container(
                    //                 height: 15,
                    //                 width: 15,
                    //                 decoration: const BoxDecoration(
                    //                   shape: BoxShape.circle,
                    //                   color: Color(0xffA42FC1),
                    //                 ),
                    //               ),
                    //               const Text(
                    //                 '100%',
                    //                 style: TextStyle(color: Colors.white),
                    //               ),
                    //             ],
                    //           ),
                    //           const Text(
                    //             'Completion',
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //         ],
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             children: [
                    //               Container(
                    //                 height: 15,
                    //                 width: 15,
                    //                 decoration: const BoxDecoration(
                    //                   shape: BoxShape.circle,
                    //                   color: Color(0xffA42FC1),
                    //                 ),
                    //               ),
                    //               const Text(
                    //                 '20',
                    //                 style: TextStyle(color: Colors.white),
                    //               ),
                    //             ],
                    //           ),
                    //           const Text(
                    //             'Total Question',
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const SizedBox(height: 15),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 30),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             children: [
                    //               Container(
                    //                 height: 15,
                    //                 width: 15,
                    //                 decoration: const BoxDecoration(
                    //                   shape: BoxShape.circle,
                    //                   color: Colors.green,
                    //                 ),
                    //               ),
                    //               Text(
                    //                 numCorrectQuestions.toString(),
                    //                 style: const TextStyle(color: Colors.white),
                    //               ),
                    //             ],
                    //           ),
                    //           const Text(
                    //             'Correct',
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //         ],
                    //       ),
                    //       Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Row(
                    //             children: [
                    //               Container(
                    //                 height: 15,
                    //                 width: 15,
                    //                 decoration: const BoxDecoration(
                    //                   shape: BoxShape.circle,
                    //                   color: Colors.red,
                    //                 ),
                    //               ),
                    //               Text(
                    //                 '${(numTotalQuestions - numCorrectQuestions)}',
                    //                 style: const TextStyle(color: Colors.white),
                    //               ),
                    //             ],
                    //           ),
                    //           const Text(
                    //             'Wrong',
                    //             style: TextStyle(color: Colors.white),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),

            // SizedBox(
            //   height: 521,
            //   width: double.infinity,
            //   child: Stack(
            //     children: [
            //       Container(
            //         height: 340,
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //           color: Colors.amber,
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //         child: Center(
            //           child: CircleAvatar(
            //             radius: 85,
            //             backgroundColor: Colors.white.withOpacity(0.3),
            //             child: CircleAvatar(
            //               radius: 71,
            //               backgroundColor: Colors.white.withOpacity(0.4),
            //               child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   const Text('Your Score'),
            //                   Text('${numCorrectQuestions * 10}%'),
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Positioned(
            //         bottom: 70,
            //         left: 20,
            //         child: Container(
            //           height: 190,
            //           width: 330,
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //           child: Column(
            //             children: [
            //               Text('Score: $numCorrectQuestions'),
            //               Text(
            //                   'Best Score: ${(widget.elapsedTime ~/ 3600).toString().padLeft(2, '0')}:${((widget.elapsedTime % 3600) ~/ 60).toString().padLeft(2, '0')}:${(widget.elapsedTime % 60).toString().padLeft(2, '0')}'),
            //               const SizedBox(height: 10),
            //               // Show best score and best time widgets
            //               Text(
            //                 'Best Score: $bestScore',
            //                 style: const TextStyle(fontSize: 16),
            //               ),
            //               Text(
            //                 'Best Time: ${bestTimeInSeconds ~/ 60}:${bestTimeInSeconds % 60}',
            //                 style: const TextStyle(fontSize: 16),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // button Restart
                    CustomButton(
                      onTap: widget.onRestart,
                      buttonText: 'Restart',
                      iconData: Icons.refresh,
                    ),
                    // button View Answer
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

  // Function to save the best score to SharedPreferences
  Future<void> saveBestScore(int score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('bestScore', score);
  }

  // Function to load the best score from SharedPreferences
  Future<void> loadBestScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bestScore = prefs.getInt('bestScore') ?? 0;
  }

  // Function to save the best time to SharedPreferences
  Future<void> saveBestTime(int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('bestTimeInSeconds', time);
  }

  // Function to load the best time from SharedPreferences
  Future<void> loadBestTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bestTimeInSeconds = prefs.getInt('bestTimeInSeconds') ?? 0;
  }
}
