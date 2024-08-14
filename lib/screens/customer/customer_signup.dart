import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_ship/providers/auth_provider.dart';
import 'package:safe_ship/widgets/custom_text_field.dart';
import 'package:safe_ship/widgets/custom_button.dart';
import 'package:safe_ship/screens/customer/customer_dashboard.dart';

class CustomerSignup extends StatefulWidget {
  @override
  _CustomerSignupState createState() => _CustomerSignupState();
}

class _CustomerSignupState extends State<CustomerSignup> {
  final _formKey = GlobalKey<FormState>();
  String _email = '', _password = '', _name = '', _dob = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Customer Sign Up')),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: () => _submitForm(authProvider),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(AuthProvider authProvider) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      bool success = await authProvider.signUp(_email, _password, _name, _dob, 'customer');
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CustomerDashboard()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign up. Please try again.')),
        );
      }
    }
  }
}