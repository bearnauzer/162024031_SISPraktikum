import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D253A),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420, maxHeight: 880),
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(45),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF8DA1).withOpacity(0.3),
                blurRadius: 35,
                spreadRadius: 8,
              ),
            ],
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(37),
            child: Scaffold(
              backgroundColor: const Color(0xFFFFF0F5),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/bang.jpg', 
                      width: 150,
                      height: 150,
                      errorBuilder: (ctx, err, stack) => const Icon(Icons.pets, size: 100, color: Color(0xFFFF8DA1)),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Denimalz Store',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF8DA1)
                      ),
                    ),
                    const SizedBox(height: 10),
                    const CircularProgressIndicator(color: Color(0xFFFF8DA1)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}