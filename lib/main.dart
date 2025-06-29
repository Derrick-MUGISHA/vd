import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VidarPay',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'SF Pro Display',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}