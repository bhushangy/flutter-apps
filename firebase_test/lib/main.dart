
import 'package:flutter/material.dart';
import 'package:voter_grievance_redressal/Form.dart';
import 'package:voter_grievance_redressal/Register.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body:RegistrationScreen(),
      ),
    );
  }
}