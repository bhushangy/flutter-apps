import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:templatepattern/SplashScreen.dart';
import 'package:templatepattern/NetworkCheck.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  @override
  void initState() {
    CheckStatus().checkInternetStatus();
    super.initState();
    _controller = AnimationController(
        duration: Duration(seconds: 2), vsync: this, upperBound: 1);
    animation = CurvedAnimation(parent: _controller, curve: Curves.decelerate);
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    void dispose() {
      super.dispose();
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sahaaya'),
        centerTitle: true,
      ),
        body: SplashScreen(width:_controller));
  }
}
