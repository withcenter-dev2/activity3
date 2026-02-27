import 'package:flutter/material.dart'; // Flutter UI framework
import 'package:go_router/go_router.dart'; // Navigation package
//import 'package:sqlite3/sqlite3.dart';

class QuestionList extends StatefulWidget {
  const QuestionList({super.key}); // Default constructor

  static const routeName =
      "/list_question_screen"; // Route name for GoRouter navigation
  static Function(BuildContext context) go = (context) =>
      context.go(routeName); // Shortcut to navigate using go()
  static Function(BuildContext context) push = (context) =>
      context.push(routeName); // Shortcut to navigate using push()

  @override
  State<QuestionList> createState() => _QuestionListState(); // Creates mutable state for the widget
}


class QuizProvider extends ChangeNotifier {

  final List<QuizModel> _quizzes = [
    const QuizModel(
      id: 1,
      question: '1+1?',
      choices: ['2', '3', '4', '5'],
      answer: '2',
      timerSecs: 15,
    ),
    const QuizModel(
      id: 2,
      question: 'Which planet is known as the Red Planet?',
      choices: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
      answer: 'Mars',
      timerSecs: 12,
    ),
    const QuizModel(
      id: 3,
      question: 'How many sides does a hexagon have?',
      choices: ['5', '6', '7', '8'],
      answer: '6',
      timerSecs: 10,
    ),
    const QuizModel(
      id: 4,
      question: 'What language is Flutter written in?',
      choices: ['Kotlin', 'Swift', 'Dart', 'Java'],
      answer: 'Dart',
      timerSecs: 15,
    ),
    const QuizModel(
      id: 5,
      question: 'Which ocean is the largest?',
      choices: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
      answer: 'Pacific',
      timerSecs: 12,
    ),
  ];

  // Auto-increment ID tracker — avoids ID collisions when adding new items
  int _nextId = 6;

  List<QuizModel> get quizzes => List.unmodifiable(_quizzes); // safe copy, no external mutation
  int get count => _quizzes.length;


  // ADD: appends new question and triggers rebuild in subscribed screens
  void addQuiz(QuizModel quiz) {
    final withId = QuizModel(
      id: _nextId++,            // assign next available id
      question: quiz.question,
      choices: quiz.choices,
      answer: quiz.answer,
      timerSecs: quiz.timerSecs,
    );
    _quizzes.add(withId);
    notifyListeners();          // ← signals all context.select subscribers to rebuild
  }

  // EDIT: replaces the item at the matching index with an updated copy
  void updateQuiz(QuizModel updated) {
    final i = _quizzes.indexWhere((q) => q.id == updated.id);
    if (i == -1) return;        // guard: id not found, do nothing
    _quizzes[i] = updated;      // replace in-place — list length unchanged
    notifyListeners();
  }

  // DELETE: removes by id
  void deleteQuiz(int id) {
    _quizzes.removeWhere((q) => q.id == id);
    notifyListeners();
  }
}

