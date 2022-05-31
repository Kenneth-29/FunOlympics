import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  static const String route = '/dashboard';
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Dashboard'),
      ),
    );
  }
}
