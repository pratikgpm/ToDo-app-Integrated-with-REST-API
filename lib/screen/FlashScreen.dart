import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_app/screen/homeScreen.dart';

class flashScreen extends StatefulWidget {
  const flashScreen({super.key});

  @override
  State<flashScreen> createState() => _flashScreenState();
}

class _flashScreenState extends State<flashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
    },

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Daily Routine",
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'myFont',
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Text("  Pvt. Ltd."),
          ],
        ),
      ),
    );
  }
}
