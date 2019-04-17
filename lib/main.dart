import 'package:flutter/material.dart';
import 'ui/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Heroes Library',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //Set theme
        primaryColor: Colors.white,
        accentColor: Colors.black12,
        //Set font
        fontFamily: 'Marvel',
        //Set text theme optional
//        textTheme: TextTheme(
//          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold,fontStyle: ),
//          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//          body1: TextStyle(fontSize: 14.0),
//        ),

      ),
      home: Home(),
    );
  }
}


//TODO UI
//TODO proper sensitive data
//TODO as per fluttio networking rules like mode calls outside
//TODO font
//TODO apptheme
//TODO use computes
