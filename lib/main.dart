import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/intro_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 12, 1, 1)
      ),
      home: const IntroPage(),
    );
  }
}