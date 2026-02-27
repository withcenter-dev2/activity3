class QuizModel {
  final int id;
  final String question;
  final List<String> choices;  // 2–6 answer options
  final String answer;         // must be one of the choices
  final int timerSecs;         // seconds before auto-advance

  const QuizModel({
    required this.id,
    required this.question,
    required this.choices,
    required this.answer,
    required this.timerSecs,
  });

  // Creates a copy with modified fields — used in edit operations
  // Original object stays immutable; provider holds the new copy
  QuizModel copyWith({
    String? question,
    List<String>? choices,
    String? answer,
    int? timerSecs,
  }) =>
      QuizModel(
        id: id,
        question: question ?? this.question,
        choices: choices ?? this.choices,
        answer: answer ?? this.answer,
        timerSecs: timerSecs ?? this.timerSecs,
      );
}