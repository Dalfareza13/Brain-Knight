import 'package:flutter/material.dart';
import 'mtk.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedAvatar = 'assets/karakter/Ksatria_1.png';

  final List<String> _avatarList = [
    'assets/karakter/Ksatria_1.png',
    'assets/karakter/Ksatria_2.png',
    'assets/karakter/Ksatria_3.png',
    'assets/karakter/Ksatria_4.png',
    'assets/karakter/Ksatria_5.png',
  ];

  // ✅ PERBAIKAN: Ganti showDialog → Navigator.push ke halaman baru full screen
  void _showFullPageAvatarSelection() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvatarSelectionPage(
          avatarList: _avatarList,
          selectedAvatar: _selectedAvatar,
          onAvatarSelected: (String avatar) {
            setState(() {
              _selectedAvatar = avatar;
            });
          },
        ),
      ),
    );
  }

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

          // LAPISAN ATAS: Konten Halaman Utama
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _showFullPageAvatarSelection,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.asset(
                              _selectedAvatar,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person, color: Colors.orange);
                              },
                            ),
                          ),
                        ),
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

  Widget _buildMenuButton({
    required String title,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
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
              offset: const Offset(0, 3),
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
              style: const TextStyle(
                  color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// ✅ HALAMAN BARU: AvatarSelectionPage — tampil full screen, pakai latar game sendiri
class AvatarSelectionPage extends StatefulWidget {
  final List<String> avatarList;
  final String selectedAvatar;
  final Function(String) onAvatarSelected;

  const AvatarSelectionPage({
    super.key,
    required this.avatarList,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  @override
  State<AvatarSelectionPage> createState() => _AvatarSelectionPageState();
}

class _AvatarSelectionPageState extends State<AvatarSelectionPage> {
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.avatarList.indexOf(widget.selectedAvatar);
    if (_currentPage == -1) _currentPage = 0;
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ✅ KUNCI: Tidak ada backgroundColor gelap — pakai latar dari asset game
      body: Stack(
        children: [
          // ── LATAR BELAKANG: Gambar game penuh ──────────────────────────
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Brain_Knight_1.png'), // Latar sama dengan halaman utama
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ── OVERLAY TIPIS agar teks lebih terbaca (opsional, bisa dihapus) ──
          Container(
            color: Colors.black.withOpacity(0.25), // Sangat tipis, tidak gelap
          ),

          // ── KONTEN UTAMA ─────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // Header: Tombol kembali + Judul
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Expanded(
                        child: Text(
                          "PILIH KARAKTER",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3,
                            shadows: [Shadow(color: Colors.black54, blurRadius: 6)],
                          ),
                        ),
                      ),
                      // Placeholder agar judul benar-benar di tengah
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                // ── Slider Gambar ──────────────────────────────────────
                Expanded(
                  child: Row(
                    children: [
                      // Tombol kiri
                      _NavArrow(
                        icon: Icons.chevron_left,
                        enabled: _currentPage > 0,
                        onTap: () => _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                      ),

                      // PageView gambar — memenuhi sisa ruang
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: widget.avatarList.length,
                          onPageChanged: (index) {
                            setState(() => _currentPage = index);
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: ClipRRect(
                                // ✅ Gambar penuh tanpa card/kotak — langsung full
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  widget.avatarList[index],
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.broken_image, color: Colors.red, size: 60),
                                        const SizedBox(height: 12),
                                        Text(
                                          "Gagal memuat:\nKsatria_${index + 1}.png",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(color: Colors.white70),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Tombol kanan
                      _NavArrow(
                        icon: Icons.chevron_right,
                        enabled: _currentPage < widget.avatarList.length - 1,
                        onTap: () => _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Dots Indicator ─────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(widget.avatarList.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 8,
                      width: _currentPage == index ? 28 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.orange
                            : Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 24),

                // ── Tombol Gunakan Karakter ────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 6,
                      ),
                      onPressed: () {
                        widget.onAvatarSelected(widget.avatarList[_currentPage]);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "GUNAKAN KARAKTER",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Widget tombol navigasi kiri/kanan ──────────────────────────────────────
class _NavArrow extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _NavArrow({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 44,
        height: 44,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: enabled
              ? Colors.orange.withOpacity(0.85)
              : Colors.white.withOpacity(0.15),
          shape: BoxShape.circle,
          boxShadow: enabled
              ? [BoxShadow(color: Colors.orange.withOpacity(0.4), blurRadius: 8)]
              : [],
        ),
        child: Icon(
          icon,
          color: enabled ? Colors.white : Colors.white30,
          size: 30,
        ),
      ),
    );
  }
}