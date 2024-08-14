import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safe_ship/models/user_model.dart';
import 'package:safe_ship/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;
  AuthService _authService = AuthService();

  UserModel get user => _user;

  Future<bool> signUp(String email, String password, String name, String dob, String userType) async {
    try {
      UserCredential result = await _authService.registerWithEmailAndPassword(email, password, name, dob, userType);
      _user = UserModel.fromFirebaseUser(result.user);
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      UserCredential result = await _authService.signInWithEmailAndPassword(email, password);
      _user = UserModel.fromFirebaseUser(result.user);
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}