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
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900,),
//          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0,color: Colors.grey,fontWeight: FontWeight.w900),
          subhead: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w900),
        ),

      ),
      home: Home(),
    );
  }
}


//TODO UI
