class QuizQuestion {
  const QuizQuestion({
    required this.imageUrl,
    required this.questionText,
    required this.answers,
  });

  final String imageUrl;
  final String questionText;
  final List<String> answers;

  List<String> get shuffledAnswers {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}
