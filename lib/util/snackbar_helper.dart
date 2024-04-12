import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, {required String myString}) {
  final err = SnackBar(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    duration: Duration(seconds: 1),
    content: Text(
      myString,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(err);
}

void shoeSucessMessage(BuildContext context, {required String myString}) {
  final status = SnackBar(
    content: Text(
      myString,
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.lightGreen,
    duration: Duration(seconds: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(20), topLeft: Radius.circular(20)),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(status);
}

