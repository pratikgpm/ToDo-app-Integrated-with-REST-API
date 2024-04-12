import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/screen/FlashScreen.dart';
import 'package:todo_app/screen/homeScreen.dart';

void main(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: flashScreen(),
    );
  }
}
