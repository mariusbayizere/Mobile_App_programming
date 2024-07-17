// lib/services/auth_service.dart

import 'package:flutter/foundation.dart';
import '../models/models/user.dart';
// import '../models/user.dart';
import 'user_service.dart';

class AuthService with ChangeNotifier {
  User? _currentUser;
  final UserService _userService = UserService();

  User? get currentUser => _currentUser;

  Future<bool> signUp(String username, String email, String password) async {
    final existingUser = await _userService.getUserByEmail(email);
    if (existingUser != null) {
      return false; // User already exists
    }

    final user = User(
      id: DateTime.now().toString(),
      username: username,
      email: email,
      password: password,
    );
    await _userService.insertUser(user);
    _currentUser = user;
    notifyListeners();
    return true;
  }

  Future<bool> signIn(String email, String password) async {
    final user = await _userService.getUser(email, password);
    if (user != null) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  void signOut() {
    _currentUser = null;
    notifyListeners();
  }
}
