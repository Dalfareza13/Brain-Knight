import 'package:flutter/material.dart';
import 'package:brain_knight/pages/home_screen.dart'; // Sesuaikan dengan nama package Anda

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain Knight',
      // --- BARIS UNTUK MENGHAPUS LABEL DEBUG ---
      debugShowCheckedModeBanner: false, 
      // -----------------------------------------
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Brain Knight Home'),
    );
  }
}