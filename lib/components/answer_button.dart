import 'package:flutter/material.dart';
import 'package:football_trivia/utils/styles.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 40,
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
          side: const BorderSide(
            color: Color.fromARGB(255, 33, 1, 95),
            width: 3.0,
          ),
        ),
      ),
      child: Text(
        answerText,
        style: TextAppearance.bebasNeueMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}
