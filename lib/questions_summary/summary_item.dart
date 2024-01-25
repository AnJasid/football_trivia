import 'package:flutter/material.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    // final isCorrectAnswer =
    //     itemData['user_answer'] == itemData['correct_answer'];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child:
          // QuestionIdentifier(
          //   isCorrectAnswer: isCorrectAnswer,
          //   questionIndex: itemData['question_index'] as int,
          // ),
          // const SizedBox(width: 20),
          Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                itemData['question'] as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          itemData['user_answer'] == itemData['correct_answer']
                              ? Colors.green
                              : Colors.red,
                    ),
                    child: Center(
                      child: Icon(
                        itemData['user_answer'] == itemData['correct_answer']
                            ? Icons.check
                            : Icons.cancel,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      itemData['user_answer'] as String,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 202, 171, 252),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Correct Answer: ${itemData['correct_answer']}',
                style: const TextStyle(
                  color: Color.fromARGB(255, 181, 254, 246),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
