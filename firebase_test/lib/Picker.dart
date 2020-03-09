import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: Text('Pick Image From Camera or Gallery')
            ),
            body: Center(
                child: MyImagePicker()
            )
        )
    );
  }
}


class MyImagePicker extends StatefulWidget {
  @override
  MyImagePickerState createState() => MyImagePickerState();
}

class MyImagePickerState extends State {

  File imageURI;

  Future getImageFromCamera() async {

    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      imageURI = image;
    });
  }

  Future getImageFromGallery() async {

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageURI = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  imageURI == null
                      ? Text('No image selected.')
                      : Image.file(imageURI, width: 300, height: 200, fit: BoxFit.cover),

                  Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                      child: RaisedButton(
                        onPressed: () => getImageFromCamera(),
                        child: Text('Camera'),
                        textColor: Colors.white,
                        color: Colors.deepOrange,
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      )),

                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: RaisedButton(
                        onPressed: () => getImageFromGallery(),
                        child: Text('Gallery'),
                        textColor: Colors.white,
                        color: Colors.deepOrange,
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('SUBMIT'),
                        textColor: Colors.white,
                        color: Colors.deepOrange,
                        padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                      ))
                ]))
    );
  }
}