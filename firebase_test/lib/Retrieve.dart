import 'package:flutter/material.dart';

class DisplayData extends StatefulWidget {

  String data;
  DisplayData({this.data});
  @override
  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(widget.data),
      ),
    );
  }
}
