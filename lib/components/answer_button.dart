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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 30,
          ),
          backgroundColor: const Color(0xff389ccc),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: Colors.white,
              width: 3.0,
            ),
          ),
        ),
        child: Text(
          answerText,
          style: TextAppearance.bebasNeueMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
