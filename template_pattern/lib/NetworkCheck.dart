import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class NetworkCheck{

  Future<void> checkInternetStatus();
  Widget showAlert();

}


class CheckStatus extends NetworkCheck{

  @override
  Future<void> checkInternetStatus() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
      showAlert();
    }
  }
  
  Widget showAlert() {
    return Scaffold(
      appBar: AppBar(
        title: Text('No Internet'),
      ),
      body: Center(
        child: Container(
            height: 100,
            width: 100,
            child: Text('No Active Internet Connection!!'),
            decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: Colors.red)
        ),
      ),
    );
  }

}

















































/*
Center(
        child: Container(
          height: 100,
          width: 200,
          child: Center(child: Text('No Active Internet Connection!!')),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(color: Colors.red)
          ),
        ),
      ),
 */





