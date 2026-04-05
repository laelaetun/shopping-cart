import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  int indexing = 0;
  int totalScore = 0;

  final items = [
    {
      'questions': '1. What is Flutter?',
      'answer': [
        {'text': 'A. A programming language', 'score': 0},
        {'text': 'B. A UI toolkit', 'score': 10},
        {'text': 'C. A database', 'score': 0},
        {'text': 'D. An operating system', 'score': 0},
      ],
    },
    {
      'questions': '2. Which language is used to write Flutter apps?',
      'answer': [
        {'text': 'A. Java', 'score': 0},
        {'text': 'B. Kotlin', 'score': 0},
        {'text': 'C. Dart', 'score': 10},
        {'text': 'D. Swift', 'score': 0},
      ],
    },
    {
      'questions': '3. What is a Widget in Flutter?',
      'answer': [
        {'text': 'A. A function', 'score': 0},
        {'text': 'B. A UI element', 'score': 10},
        {'text': 'C. A database', 'score': 0},
        {'text': 'D. A file', 'score': 0},
      ],
    },
  ];

  void answerQuestion(int score) {
    totalScore += score; // ✅ correct

    setState(() {
      indexing++;
    });
  }

  void restart() {
    setState(() {
      indexing = 0; // ✅ reset
      totalScore = 0; // ✅ reset
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz App")),
      body: indexing < items.length
          ? Column(
              children: [
                const SizedBox(height: 20),

                // 🧠 QUESTION
                Text(
                  items[indexing]['questions'] as String,
                  style: const TextStyle(fontSize: 22),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),

                // 🎯 ANSWERS
                ...(items[indexing]['answer'] as List<Map<String, Object>>).map(
                  (ans) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () => answerQuestion(ans['score'] as int),
                        child: Text(ans['text'] as String),
                      ),
                    );
                  },
                ).toList(),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Score: $totalScore",
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: restart,
                    child: const Text("Restart"),
                  ),
                ],
              ),
            ),
    );
  }
}
