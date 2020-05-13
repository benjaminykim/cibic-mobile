import 'package:flutter/material.dart';
import 'src/onboard/app.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => App(),
      }
    )
  );
}