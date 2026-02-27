import 'package:flutter/material.dart';
import 'package:activityn3/repository/repository.dart';
import 'package:activityn3/models/user_modal.dart';


class UserProvider extends ChangeNotifier {

  final UserRepository repository = UserRepository();

  List<UserModel> _users = [];  // ← this is STATE (data that changes)
  List<UserModel> get users => _users;  // ← exposes state to UI

  Future<void> loadUsers(String questions, String answers) async {
    _users = await repository.getUsers(); // ← state changes here
    notifyListeners(); // ← tells UI to rebuild with new data
  }

  // Future<void> addUser(String name) async {
  //   await repository.insertUser(UserModel(name: name));
  //   await loadUsers();
  // }

}
