import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> registerWithEmailAndPassword(String email, String password, String name, String dob, String userType) async {
    if (!verifyAge(dob)) {
      throw Exception('You must be 18 or older to sign up.');
    }

    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User user = result.user;

    await user.sendEmailVerification();

    await _firestore.collection('users').doc(user.uid).set({
      'name': name,
      'email': email,
      'dob': dob,
      'userType': userType,
      'emailVerified': false,
    });

    return result;
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User user = result.user;

    if (!user.emailVerified) {
      throw Exception('Please verify your email before signing in.');
    }

    return result;
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  bool verifyAge(String dob) {
    DateTime birthDate = DateTime.parse(dob);
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age >= 18;
  }
}