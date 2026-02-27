import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:activityn3/screens/list_question_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const routeName = "/home_screen";
  static Function(BuildContext context) go = (context) => context.go(routeName);
  static Function(BuildContext context) push = (context) =>
      context.push(routeName);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Database db;

  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDatabase(); // Initialize the database on startup
  }

  void _initDatabase() {
    db = sqlite3.open('quiz.db'); //  Opens (or creates) the database file

    // Create table if it doesn't exist yet
    db.execute('''
      CREATE TABLE IF NOT EXISTS quiz (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT NOT NULL,
        answer TEXT NOT NULL
      )
    ''');
  }

  void _addQuestion() {
    final question = _questionController.text.trim();
    final answer = _answerController.text.trim();

    //Validate inputs before doing anything
    if (question.isEmpty || answer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both fields')),
      );
      return;
    }

    // Check if question already exists
    final existing = db.select(
      'SELECT * FROM quiz WHERE question = ?',
      [question], // Use parameterized queries to prevent SQL injection
    );

    if (existing.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Question already exists')));
      return;
    }

    // Insert the new question and answer
    db.execute('INSERT INTO quiz (question, answer) VALUES (?, ?)', [
      question,
      answer,
    ]);

    // Confirm insertion by fetching it back
    final result = db.select('SELECT * FROM quiz WHERE question = ?', [
      question,
    ],
    );

    if (result.isNotEmpty) {
      print('Inserted: ${result.rows}');
    }

    // Clear fields after successful insert
    _questionController.clear();
    _answerController.clear();

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Quiz added successfully')));

    // Navigate after everything is done
    context.push(QuestionList.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(labelText: 'Answer'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addQuestion, // enamed for clarity
              child: const Text('Add Question'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    db.dispose(); // Always close the database when done
    super.dispose();
  }
}
