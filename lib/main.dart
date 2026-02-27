import 'package:flutter/material.dart'; // Flutter UI framework
import 'package:provider/provider.dart'; // State management package
import 'package:activityn3/go_router.dart';
import 'package:activityn3/providers/user_provider.dart'; // State management package
//import 'package:activityn3/screens/list_question_screen.dart'; 


void main() {
  runApp(
    ChangeNotifierProvider(
      // Provide AuthProvider to the whole app for state management
      create: (_) => UserProvider(), // Create an instance of UserProvider
      child: const MyApp(), // Root widget of the app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Default constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // MaterialApp configured for GoRouter
      routerConfig: router, // Assign the GoRouter configuration to handle navigation
    );
  }
}
