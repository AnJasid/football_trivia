class FootballQuestion {
  FootballQuestion({
    required this.imageUrl,
    required this.questionText,
    required this.answers,
  });

  final String imageUrl;
  final String questionText;
  final List<String> answers;

  List<String>? _shuffledAnswers;
  List<String> get shuffledAnswers {
    // Check if answers are already shuffled
    if (_shuffledAnswers == null) {
      _shuffledAnswers = List.of(answers);
      _shuffledAnswers!.shuffle();
    }
    return _shuffledAnswers!;
  }
}
