import 'package:flutter/material.dart';
// 1. IMPORT file mtk.dart agar bisa dikenali
import 'mtk.dart'; 

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // LAPISAN TERBAWAH: Gambar Latar Belakang
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Brain_Knight_1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // LAPISAN ATAS: Konten
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // HEADER SECTION
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.orange),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Halo,", style: TextStyle(fontSize: 14)),
                          Text("budi", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const Spacer(),
                      _buildTopIcon(Icons.emoji_events, Colors.orange),
                      _buildTopIcon(Icons.store, Colors.orange),
                      _buildDiamondCounter("0"),
                      _buildTopIcon(Icons.settings, Colors.blue),
                    ],
                  ),
                  
                  const Spacer(flex: 2),

                  // --- BUTTON SECTION ---
                  // Tombol Logika Matematika dengan fungsi Navigasi
                  _buildMenuButton(
                    title: "Logika Matematika",
                    color: Colors.orangeAccent,
                    icon: Icons.calculate,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MtkPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  // Tombol Susun Kata (onTap kosong untuk sekarang)
                  _buildMenuButton(
                    title: "Susun Kata",
                    color: Colors.purple,
                    icon: Icons.menu_book,
                    onTap: () {
                      print("Susun Kata diklik");
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          
          // Floating Icons Samping
          Positioned(
            right: 20,
            top: 100,
            child: Column(
              children: [
                _buildSideIcon(Icons.assignment, Colors.purple),
                const SizedBox(height: 10),
                _buildSideIcon(Icons.pets, Colors.teal),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- HELPER WIDGETS ---

  Widget _buildTopIcon(IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildDiamondCounter(String amount) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.diamond, color: Colors.blue, size: 16),
          const SizedBox(width: 5),
          Text(amount, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildSideIcon(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, color: Colors.white),
    );
  }

  // Perbaikan Helper Tombol agar bisa menerima fungsi klik (VoidCallback onTap)
  Widget _buildMenuButton({
    required String title, 
    required Color color, 
    required IconData icon,
    required VoidCallback onTap, // Tambahkan parameter ini
  }) {
    return GestureDetector(
      onTap: onTap, // Aksi saat tombol ditekan
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), 
              blurRadius: 5, 
              offset: const Offset(0, 3)
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}