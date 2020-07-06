import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends AnimatedWidget {
  const SplashScreen({width}) : super(listenable: width);

  Animation<double> get width => listenable;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width:double.infinity,
        child: Center(
          child: Text(
            'Sahaaya',
            style: TextStyle(fontSize: width.value*80,),

          ),
        ),
      ),
    );
  }
}
