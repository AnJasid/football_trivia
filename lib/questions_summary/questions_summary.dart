import 'package:flutter/material.dart';
import 'package:football_trivia/questions_summary/summary_item.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 530,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: summaryData.map(
                (data) {
                  return SummaryItem(data);
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
