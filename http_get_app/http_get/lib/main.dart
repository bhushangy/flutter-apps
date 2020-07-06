import 'package:flutter/material.dart';
import 'package:flutterapp/Space.dart';
import 'package:provider/provider.dart';

import 'MyHomePage.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => Space(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
