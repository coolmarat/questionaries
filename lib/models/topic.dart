import 'dart:math';

class Topic {
  final int id;
  final String name;
  final List<Question> questions;
  late final List<Question> shuffledQuestions;

  Topic({
    required this.id,
    required this.name,
    required this.questions,
  }) {
    // Создаем копию списка и перемешиваем её
    shuffledQuestions = List.from(questions)..shuffle(Random());
  }

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      name: json['name'],
      questions: (json['questions'] as List)
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }
}

class Question {
  final int id;
  final String question;
  final String? answer;

  Question({
    required this.id,
    required this.question,
    this.answer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}
