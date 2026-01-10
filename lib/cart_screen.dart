import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Untuk navigasi ke HomeScreen

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Karena ini di dalam BottomNav, biasanya tombol back 
            // akan membawa user kembali ke tab Beranda
             // Namun untuk sekarang kita biarkan default atau kosongkan dulu
          },
        ),
        title: Text(
          "Keranjang Belanja",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ikon Tas Belanja dengan Lingkaran Background
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green[50], // Warna hijau sangat muda
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 50,
                  color: Color(0xFF2E8B57), // Hijau utama
                ),
              ),
              const SizedBox(height: 24),
              
              // Teks Judul
              Text(
                "Keranjang Kosong",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              
              // Teks Deskripsi
              Text(
                "Ayo mulai belanja produk segar!",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Tombol Mulai Belanja
              SizedBox(
                width: 160,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // Logika: Pindah ke tab Beranda (index 0)
                    // Kita akan bahas cara pindah tab nanti
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E8B57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Mulai Belanja",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}