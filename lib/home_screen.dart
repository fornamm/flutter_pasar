import 'package:flutter/material.dart';
import 'products_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Background agak abu sedikit biar kontras
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BAGIAN HEADER (Hijau)
            _buildHeader(),

            // BAGIAN KATEGORI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildSectionTitle("Kategori", onTap: () {}),
                  const SizedBox(height: 10),
                  _buildCategories(),
                ],
              ),
            ),

            // BAGIAN BANNER PROMO
            _buildPromoBanner(),

            // BAGIAN PRODUK TERLARIS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                 _buildSectionTitle("Produk Terlaris", onTap: () {
              Navigator.push(
                context, 
              MaterialPageRoute(builder: (context) => const AllProductsScreen()) );
                  }),
                ],
              ),
            ),
            
            const SizedBox(height: 20), // Spacer bawah
          ],
        ),
      ),
    );
  }

  // Widget Header Hijau
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
      decoration: const BoxDecoration(
        color: Color(0xFF2E8B57),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Selamat datang,", style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text("Tamu", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: const [
              Icon(Icons.location_on, color: Colors.white, size: 14),
              SizedBox(width: 4),
              Text("Padang, Indonesia", style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 20),
          // Search Bar
          TextField(
            decoration: InputDecoration(
              hintText: "Cari sayur, buah, daging...",
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Judul Section (Lihat Semua)
  Widget _buildSectionTitle(String title, {required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onTap,
          child: const Text("Lihat Semua >", style: TextStyle(color: Color(0xFF2E8B57), fontSize: 12)),
        ),
      ],
    );
  }

  // Widget List Kategori Horizontal
  Widget _buildCategories() {
    final categories = [
      {'icon': Icons.eco, 'label': 'Sayuran', 'color': Colors.green[100]},
      {'icon': Icons.apple, 'label': 'Buah', 'color': Colors.red[100]},
      {'icon': Icons.set_meal, 'label': 'Daging', 'color': Colors.red[50]},
      {'icon': Icons.water_drop, 'label': 'Ikan', 'color': Colors.blue[100]},
      {'icon': Icons.local_fire_department, 'label': 'Bumbu', 'color': Colors.orange[100]},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((cat) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
              ),
              child: Icon(cat['icon'] as IconData, color: const Color(0xFF2E8B57)),
            ),
            const SizedBox(height: 8),
            Text(cat['label'] as String, style: const TextStyle(fontSize: 12)),
          ],
        );
      }).toList(),
    );
  }

  // Widget Banner Promo (Orange)
  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9F43), // Warna Orange Promo
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(4)),
                  child: const Text("PROMO", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                const Text("Diskon 20%", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const Text("Untuk pembelian pertama", style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFFF9F43),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("Belanja Sekarang"),
                )
              ],
            ),
          ),
          const Icon(Icons.shopping_basket, size: 80, color: Colors.white24),
        ],
      ),
    );
  }

  // Widget Grid Produk
  Widget _buildProductGrid() {
    // Data Dummy Produk
    final products = [
      {'name': 'Kangkung Segar', 'shop': 'Pak Tani Jaya', 'price': 'Rp 5.000', 'unit': '/ikat', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Tomat Merah', 'shop': 'Bu Sari Tani', 'price': 'Rp 12.000', 'unit': '/kg', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Apel Fuji', 'shop': 'Toko Buah Makmur', 'price': 'Rp 35.000', 'unit': '/kg', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Pisang Cavendish', 'shop': 'Kebun Pisang', 'price': 'Rp 18.000', 'unit': '/sisir', 'image': 'https://via.placeholder.com/150'},
    ];

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true, // Agar bisa discroll di dalam SingleChildScrollView
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75, // Mengatur rasio tinggi/lebar kartu
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar Produk (Placeholder)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  width: double.infinity,
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
              ),
              // Detail Produk
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(product['shop']!, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product['price']!, style: const TextStyle(color: Color(0xFF2E8B57), fontWeight: FontWeight.bold)),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Color(0xFF2E8B57), shape: BoxShape.circle),
                          child: const Icon(Icons.add, color: Colors.white, size: 16),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}