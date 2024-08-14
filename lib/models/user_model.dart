import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String email;
  final String name;
  final String userType;

  UserModel({this.uid, this.email, this.name, this.userType});

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      name: user.displayName,
      userType: 'customer', // Default to customer, update this based on your user data
    );
  }
}