import 'package:flutter/material.dart';
import 'package:safe_ship/screens/customer/customer_signup.dart';
import 'package:safe_ship/screens/employee/employee_signup.dart';
import 'package:safe_ship/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to Safe Ship')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              text: 'Customer Sign Up',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CustomerSignup()),
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Employee Sign Up',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EmployeeSignup()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}