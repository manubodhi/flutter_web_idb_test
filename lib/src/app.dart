import 'package:flutter/material.dart';
import 'package:flutter_web_test/src/store/dbProvider.dart';
import 'package:flutter_web_test/src/ui/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final DBProvider dbProvider;

  const MyApp({Key key, this.dbProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Breweries',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(dbProvider: dbProvider,),
    );
  }
}