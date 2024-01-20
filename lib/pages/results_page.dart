import 'package:flutter/material.dart';
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
              height: 400,
              decoration: BoxDecoration(
                color: const Color(0xff38649c),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white, // Specify the color of the border
                  width: 3,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(
                    color: Colors.white,
                    thickness: 2,
                    height: 40,
                  ),
                ],
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
                    GestureDetector(
                      onTap: widget.onRestart,
                      child: const Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xff37AFA1),
                            radius: 35,
                            child: Center(
                              child: Icon(
                                Icons.refresh,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Restart',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        openViewAnswer(context);
                      },
                      child: const Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xff37AFA1),
                            radius: 35,
                            child: Center(
                              child: Icon(
                                Icons.visibility_rounded,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'View Answer',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
