import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/reusable_buttons.dart';
import 'chat_screen.dart';
import 'package:flash_chat/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  String passHint = 'Enter your password';
  String emailHint = 'Enter your email';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  onTap: () => setState(() {
                        passHint = 'Enter your password';
                        emailHint = '';
                      }),
                  keyboardType: TextInputType.emailAddress,
                  style: new TextStyle(color: Colors.black),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: emailHint)),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  onTap: () => setState(() {
                        passHint = '';
                        emailHint = 'Enter your email';
                      }),
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: new TextStyle(color: Colors.black),
                  onChanged: (value) {
                    password = value;
                  },
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: passHint)),
              SizedBox(
                height: 24.0,
              ),
              reusableButtons(
                colour: Colors.lightBlueAccent,
                txt: 'Log In',
                onPressed: () async {
                  if (email == null || password == null) {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Error",
                      desc: "Email or Password cannot be null",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Try Again",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                    ).show();
                    return;
                  }

                  setState(() {
                    showSpinner = true;
                  });

                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                    String err = e.toString();
                    List<String> errList = err.split(',');
                    print(errList);
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "ERROR",
                      desc: errList[1],
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Try Again",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                        )
                      ],
                    ).show();
                    setState(() {
                      showSpinner = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
