
import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const WarungISApp());
}

class WarungISApp extends StatelessWidget {
  const WarungISApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warung IS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
