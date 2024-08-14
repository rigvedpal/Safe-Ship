import 'package:flutter/material.dart';
import 'package:safe_ship/services/location_service.dart';

class EmployeeDashboard extends StatefulWidget {
  @override
  _EmployeeDashboardState createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  final LocationService _locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee Dashboard')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, Employee!'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Start Delivering'),
              onPressed: () async {
                // Start updating location
                await _locationService.getCurrentLocation();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Location tracking started')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}