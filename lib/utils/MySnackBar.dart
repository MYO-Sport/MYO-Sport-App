

import 'package:flutter/material.dart';

class MySnackBar{
  static void showSnackBar (BuildContext context,String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}