import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:voter_grievance_redressal/Picker.dart';
import 'package:voter_grievance_redressal/Map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

final databaseReference = Firestore.instance;
FirebaseUser loggedInUser;

class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String categ;
  String desc;


  void initState() {

    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        // print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }

    String collecName = loggedInUser.email.toString();
    List<String> docNames = ["bbmp", "bwssb", "roads"];

    try{
      await databaseReference
          .collection(collecName)
          .document(docNames[0])
          .collection(docNames[0]+"Grievances").document().setData({
        'Category': '',
        'Description': ''
      });
      await databaseReference
          .collection(collecName)
          .document(docNames[1])
          .collection(docNames[1]+"Grievances").document().setData({
        'Category': '',
        'Description': ''
      });

      await databaseReference
          .collection(collecName)
          .document(docNames[2])
          .collection(docNames[2]+"Grievances").document().setData({
        'Category': '',
        'Description': ''
      });
    }catch(e){
      print(e);
    }

  }

  void createRecord() async {

    try {
      await databaseReference
          .collection(loggedInUser.email.toString())
          .document("bwssb").collection("bwssbGrievances").document()// by default it goes to bbmp document...but this can be changed
          .setData({
        'Category': 'loudebmbmn',
        'Description': 'maadarchodjhv'
      });
    }catch(e){
      print(e);
    }
  }

  void getData() {

    databaseReference
        .collection(loggedInUser.email).document("bbmp").collection("bbmpGrievances")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => print('${f.data}}'));
    });
  }


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: SafeArea(
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Enter your Grievance Category',
                        labelText: 'Category',
                        contentPadding: EdgeInsets.all(15),
                        labelStyle: TextStyle(
                          fontSize: 24.0,
                        )),
                    maxLines: 2,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      categ = value;
                      if (value.isEmpty) {
                        return 'Please enter grievance category';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Enter your Grievance ',
                        labelText: 'Description',
                        contentPadding: EdgeInsets.all(15),
                        labelStyle: TextStyle(
                          fontSize: 24.0,
                        )),
                    maxLines: 7,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      desc = value;
                      if (value.isEmpty) {
                        return 'Please enter grievance ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: FlatButton(
                      child: Icon(
                        Icons.add_a_photo,
                        size: 75,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MyApp();
                        }));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  Container(
                    child: FlatButton(
                      child: Icon(
                        Icons.map,
                        size: 75,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return MyMap();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  FlatButton(
                    child: Text('Submit'),
                    textTheme: ButtonTextTheme.accent,
                    onPressed: () {
                      createRecord();
                    },
                  ),
                  FlatButton(
                    child: Text('Retrieve'),
                    textTheme: ButtonTextTheme.accent,
                    onPressed: () {
                      getData();
                    },
                  ),
                  // Add TextFormFields and RaisedButton here.
                ],
              ),
            )),
      ),
    );
  }
}
