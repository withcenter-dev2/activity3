import 'package:flutter/material.dart'; // Flutter UI framework
import 'package:go_router/go_router.dart'; // Navigation package
import 'package:sqlite3/sqlite3.dart';
import 'package:activityn3/screens/list_question_screen.dart';
// import 'package:activityn3/providers/user_provider.dart';
//import 'package:activityn3/database/database_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); // Default constructor

  static const routeName = "/home_screen"; // Route name for GoRouter navigation
  static Function(BuildContext context) go = (context) =>
      context.go(routeName); // Shortcut to navigate using go()
  static Function(BuildContext context) push = (context) =>
      context.push(routeName); // Shortcut to navigate using push()

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // Creates mutable state for the widget
}

class _HomeScreenState extends State<HomeScreen> {
  late final Database db;

  final TextEditingController _questionController =
      TextEditingController(); // Controller for username input
  final TextEditingController _answerController =
      TextEditingController(); // Controller for password input

  void _question() async {
    // Handles questions

    final questions = _questionController.text.trim(); // Get trimmed username
    //final answers = _answerController.text.trim(); // Get trimmed password

    // final UserProvider auth = UserProvider(); // Instantiate AuthProvider directly
    // final success = await auth.loadUsers(questions, answers); // Call register method
    // if (!mounted) return; // Ensure widget is still in widget tree before updating UI
    context.push(
      QuestionList.routeName,
    ); // Navigate to UserScreen after registration

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Quiz added Successful')),
    ); // Show success message

    //  if (success) {
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(const SnackBar(content: Text('Quiz added Successful'))); // Show success message
    // } else {
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(const SnackBar(content: Text('Quiz already exists'))); // Show error message
    // }

    ResultSet result = db.select(
      "select * from quiz where question='$questions'",
    );
    if (result.isNotEmpty) {
      print(result.rows);
    } else {
      return null;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz')), // App bar with title
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around form
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                labelText: 'Question',
              ), // Label text
            ),
            TextField(
              controller: _answerController,
              decoration: const InputDecoration(
                labelText: 'Answer',
              ), // Label text
              obscureText: true, // Hide password characters
            ),
            const SizedBox(height: 20), // Space between inputs and button
            ElevatedButton(
              onPressed: _question,
              child: const Text('Add Question'),
            ), // Register button
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _questionController.dispose(); // Dispose username controller to free memory
    _answerController.dispose(); // Dispose password controller to free memory
    super.dispose(); // Call parent dispose
  }
}
