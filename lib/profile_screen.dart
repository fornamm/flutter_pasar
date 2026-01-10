import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart'; // Import halaman Login yang sudah kita buat

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Simulasi status login (Ubah jadi true untuk melihat tampilan sesudah login)
  bool isLoggedIn = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          // LAYER 1: Header Hijau (Background)
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF2E8B57),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Center title
                  children: [
                    Text(
                      "Profil",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // LAYER 2: Konten Utama (Mengambang)
          Padding(
            padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
            child: isLoggedIn ? _buildLoggedInView() : _buildGuestView(),
          ),
        ],
      ),
    );
  }

  // TAMPILAN 1: Jika Belum Login (Sesuai Screenshot Kamu)
  Widget _buildGuestView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person_outline, size: 40, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Text(
            "Masuk ke Akun Anda",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Dapatkan pengalaman belanja yang lebih personal",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          
          // Tombol Masuk / Daftar
          SizedBox(
            width: double.infinity,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                // Arahkan ke halaman AuthScreen
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const AuthScreen())
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E8B57),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              ),
              child: Text(
                "Masuk / Daftar",
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Tombol Simulasi Login (Hanya untuk demo development)
          OutlinedButton(
            onPressed: () {
              setState(() {
                isLoggedIn = true; // Ubah state jadi login
              });
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF2E8B57)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              minimumSize: const Size(double.infinity, 45),
            ),
            child: Text(
              "Simulasi Login (Dev Only)", 
              style: GoogleFonts.poppins(color: const Color(0xFF2E8B57)),
            ),
          ),
        ],
      ),
    );
  }

  // TAMPILAN 2: Jika Sudah Login (Menu Profil Lengkap)
  Widget _buildLoggedInView() {
    return Column(
      children: [
        // Kartu Profil
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'), // Ganti foto profil
                backgroundColor: Colors.grey,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User E-Pasar",
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "user@epasar.com",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.edit, color: Color(0xFF2E8B57)),
              )
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Menu Pilihan
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              _buildMenuItem(Icons.shopping_bag_outlined, "Riwayat Pesanan", () {}),
              _buildMenuItem(Icons.location_on_outlined, "Alamat Saya", () {}),
              _buildMenuItem(Icons.favorite_border, "Wishlist", () {}),
              _buildMenuItem(Icons.help_outline, "Bantuan", () {}),
              const Divider(height: 1),
              _buildMenuItem(Icons.logout, "Keluar", () {
                setState(() {
                  isLoggedIn = false; // Kembali ke mode tamu
                });
              }, isRed: true),
            ],
          ),
        ),
      ],
    );
  }

  // Widget Helper untuk Menu Item
  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isRed = false}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isRed ? Colors.red[50] : Colors.green[50],
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: isRed ? Colors.red : const Color(0xFF2E8B57), size: 20),
      ),
      title: Text(
        title, 
        style: GoogleFonts.poppins(
          fontSize: 14, 
          color: isRed ? Colors.red : Colors.black87
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
      onTap: onTap,
    );
  }
}