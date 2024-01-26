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
          color: const Color(0xff333333),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 5),
              Text(
                'Correct Answer: ${itemData['correct_answer']}',
                style: TextStyle(
                  color: Colors.amber[300],
                ),
              ),
              const SizedBox(height: 8),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          itemData['user_answer'] == itemData['correct_answer']
                              ? Colors.green
                              : Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 1,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            itemData['user_answer'] ==
                                    itemData['correct_answer']
                                ? Icons.check
                                : Icons.cancel,
                            size: 15,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            itemData['user_answer'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
