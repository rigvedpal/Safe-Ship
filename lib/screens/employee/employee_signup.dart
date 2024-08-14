import 'package:flutter/material.dart';
import 'package:safe_ship/services/auth_service.dart';
import 'package:safe_ship/widgets/custom_text_field.dart';
import 'package:safe_ship/widgets/custom_button.dart';
import 'package:safe_ship/screens/employee/employee_dashboard.dart';

class EmployeeSignup extends StatefulWidget {
  @override
  _EmployeeSignupState createState() => _EmployeeSignupState();
}

class _EmployeeSignupState extends State<EmployeeSignup> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '', _name = '', _dob = '', _employeeId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Sign Up')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  labelText: 'Full Name',
                  validator: (value) => value.isEmpty ? 'Enter your name' : null,
                  onSaved: (value) => _name = value,
                ),
                CustomTextField(
                  labelText: 'Email',
                  validator: (value) => value.isEmpty ? 'Enter an email' : null,
                  onSaved: (value) => _email = value,
                ),
                CustomTextField(
                  labelText: 'Password',
                  obscureText: true,
                  validator: (value) => value.length < 6 ? 'Password too short' : null,
                  onSaved: (value) => _password = value,
                ),
                CustomTextField(
                  labelText: 'Date of Birth (YYYY-MM-DD)',
                  validator: (value) => value.isEmpty ? 'Enter your date of birth' : null,
                  onSaved: (value) => _dob = value,
                ),
                CustomTextField(
                  labelText: 'Employee ID',
                  validator: (value) => value.isEmpty ? 'Enter your employee ID' : null,
                  onSaved: (value) => _employeeId = value,
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: _submitForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (_auth.verifyAge(_dob)) {
        try {
          await _auth.registerWithEmailAndPassword(_email, _password, _name, _dob, 'employee');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EmployeeDashboard()),
          );
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You must be 18 or older to sign up.')));
      }
    }
  }
}