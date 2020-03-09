import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voter_grievance_redressal/Form.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
              ),
            ),
            Container(
              child: TextField(
                keyboardType: TextInputType.visiblePassword,
                style: new TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            FlatButton(
              child: Text('Submit'),
              onPressed: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email, password: password);

                  if (newUser != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MyCustomForm();
                        },
                      ),
                    );
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
