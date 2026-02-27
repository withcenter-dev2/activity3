import 'package:activityn3/screens/home_screen.dart';
import 'package:activityn3/screens/list_question_screen.dart';
import 'package:go_router/go_router.dart';
//import 'package:path/path.dart';

final router = GoRouter(
  initialLocation: HomeScreen.routeName, // Start at login
  // Routes
  routes: [
    GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: QuestionList.routeName,
      builder: (context, state) => const QuestionList(),
    ),
    // GoRoute(
    //   path: UserScreen.routeName,
    //   builder: (context, state) => const UserScreen(),
    // ),
  ],
);
