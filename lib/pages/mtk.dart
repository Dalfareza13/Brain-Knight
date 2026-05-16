import 'package:flutter/material.dart';

class MtkPage extends StatelessWidget {
  const MtkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar agar latar belakang memenuhi layar sampai ke atas
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          "Logika Matematika",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent, // AppBar transparan
        elevation: 0, // Hapus bayangan AppBar
        iconTheme: const IconThemeData(color: Colors.black), // Tombol back jadi hitam
      ),
      body: Stack(
        children: [
          // 1. LAPISAN TERBAWAH: Gambar Latar Belakang (Brain_Knight_0)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Brain_Knight_0.png'),
                // Menggunakan opacity agar gambar tidak terlalu terang dan teks terbaca
                opacity: 0.3, 
                fit: BoxFit.contain, // contain agar logo utuh terlihat di tengah
              ),
              color: Color(0xFFF5F5DC), // Warna krem sebagai dasar latar belakang
            ),
          ),

          // 2. LAPISAN ATAS: Konten Halaman
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange, width: 2),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.calculate, size: 80, color: Colors.orange),
                        SizedBox(height: 20),
                        Text(
                          "Halaman Matematika",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Siapkan logikamu, Ksatria!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}