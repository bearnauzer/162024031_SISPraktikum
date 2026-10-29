import 'dart:ui';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFAAC3), Color(0xFFFFD1DC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/register.png', 
                            height: 200,
                            fit: BoxFit.contain,
                            errorBuilder: (ctx, err, stack) => const Icon(Icons.pets, size: 80, color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          const Text("Buat Akun", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          const Text("Daftar MyDay baru di sini!", style: TextStyle(color: Colors.white70, fontSize: 16)),
                          const SizedBox(height: 30),
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _nameController,
                                      decoration: const InputDecoration(labelText: 'Nama Lengkap', prefixIcon: Icon(Icons.person_outline, color: Color(0xFFFF8DA1)), border: OutlineInputBorder()),
                                      validator: (value) => (value == null || value.isEmpty) ? 'Nama tidak boleh kosong' : null,
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(labelText: 'Email', hintText: 'contoh: myday@email.com', prefixIcon: Icon(Icons.email_outlined, color: Color(0xFFFF8DA1)), border: OutlineInputBorder()),
                                      validator: (value) => (value == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) ? 'Format email tidak valid' : null,
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: _phoneController,
                                      decoration: const InputDecoration(labelText: 'Nomor HP', prefixIcon: Icon(Icons.phone_android, color: Color(0xFFFF8DA1)), border: OutlineInputBorder()),
                                      validator: (value) => (value == null || value.length < 10) ? 'Nomor HP minimal 10 digit' : null,
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline, color: Color(0xFFFF8DA1)), border: OutlineInputBorder()),
                                      validator: (value) => (value == null || value.length < 6) ? 'Password minimal 6 karakter' : null,
                                    ),
                                    const SizedBox(height: 20),
                                    TextFormField(
                                      controller: _confirmPasswordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(labelText: 'Konfirmasi Password', prefixIcon: Icon(Icons.lock_reset, color: Color(0xFFFF8DA1)), border: OutlineInputBorder()),
                                      validator: (value) => (value != _passwordController.text) ? 'Password tidak sama' : null,
                                    ),
                                    const SizedBox(height: 30),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF8DA1), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                        onPressed: () {
                                          if (_formKey.currentState!.validate()) {
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registrasi berhasil!'), backgroundColor: Color(0xFFFF8DA1)));
                                          }
                                        },
                                        child: const Text('Daftar', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Sudah punya akun? Masuk di sini', style: TextStyle(color: Color(0xFFFF8DA1))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}