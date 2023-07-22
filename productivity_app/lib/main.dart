import 'package:flutter/material.dart';
import 'package:productivity_app/utils/bottom_bar.dart';

void main() async {
  // await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Productivity',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const BottomBar(),
    );
  }
}
