import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cart_service.dart'; // Import service
import 'main.dart'; // Import main agar bisa reset ke Home
import 'order_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  
  // --- LOGIC CHECKOUT SIMULASI ---
  void _handleCheckout() async {
    // 1. Tampilkan Dialog Loading
    showDialog(
      context: context,
      barrierDismissible: false, // User gabisa klik luar untuk tutup
      builder: (context) => const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF2E8B57),
        ),
      ),
    );

    // 2. Simulasi Delay Network (2 Detik)
    await Future.delayed(const Duration(seconds: 2));

    // 3. Tutup Dialog Loading
    if (!mounted) return;
    Navigator.pop(context); 

    // 4. Tampilkan Dialog Sukses
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF2E8B57), size: 80),
              const SizedBox(height: 20),
              Text(
                "Pembayaran Berhasil!",
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Pesanan Anda sedang diproses dan akan segera dikirim.",
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final items = CartService().items;
                    final total = CartService().getTotalPrice();

                    OrderService().placeOrder(items, total);
                    CartService().clearCart(); // Kosongkan data
                    
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainNavigation()),
                      (route) => false, // Hapus semua riwayat halaman sebelumnya
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E8B57),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  child: const Text("Kembali ke Beranda", style: TextStyle(color: Colors.white)),
                ),
              )
            ],
          ),
        );
      },
    );
  }
  // ------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // Ambil data terbaru dari CartService
    final cartItems = CartService().items;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Keranjang Belanja",
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      // Cek: Jika kosong tampilkan UI Kosong, Jika ada isi tampilkan List
      body: cartItems.isEmpty 
          ? _buildEmptyCart() 
          : _buildCartList(cartItems),
      
      // Bottom Bar Total Harga (Hanya muncul jika ada barang)
      bottomNavigationBar: cartItems.isEmpty ? null : _buildBottomSummary(),
    );
  }

  // Tampilan Jika Kosong
  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(color: Colors.green[50], shape: BoxShape.circle),
              child: const Icon(Icons.shopping_bag_outlined, size: 50, color: Color(0xFF2E8B57)),
            ),
            const SizedBox(height: 24),
            Text("Keranjang Kosong", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Ayo mulai belanja produk segar!", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // Tampilan Jika Ada Barang (List Belanja)
  Widget _buildCartList(List<Map<String, dynamic>> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
            border: Border.all(color: Colors.grey[100]!),
          ),
          child: Row(
            children: [
              // Gambar Kecil
              Container(
                width: 60, height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(item['image']), 
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Detail
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['name'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    Text(item['price'], style: TextStyle(color: const Color(0xFF2E8B57), fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              // Tombol Hapus
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  setState(() {
                  });
                },
              )
            ],
          ),
        );
      },
    );
  }

  // Bagian Bawah (Total Harga)
  Widget _buildBottomSummary() {
    // Format Rupiah sederhana
    final total = CartService().getTotalPrice();
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total Harga", style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text("Rp $total", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            ],
          ),
          ElevatedButton(
            // Panggil Fungsi Checkout di sini
            onPressed: _handleCheckout, 
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E8B57),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            child: const Text("Checkout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}