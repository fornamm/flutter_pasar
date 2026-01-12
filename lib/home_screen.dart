import 'package:flutter/material.dart';
import 'products_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // BAGIAN HEADER (Hijau)
            _buildHeader(),

            // BAGIAN KATEGORI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                children: [
                  _buildSectionTitle("Kategori", onTap: () {}),
                  const SizedBox(height: 20),
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
                    // Navigasi ke halaman All Products
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const AllProductsScreen()) 
                    );
                  }),
                  const SizedBox(height: 20),
                  // Memanggil Grid Produk di sini
                  _buildProductGrid(), 
                ],
              ),
            ),
            
            const SizedBox(height: 20), // Spacer bawah
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---

  // Widget Header Hijau
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 46, 139, 87),
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
                  Text("Selamat datang,", style: TextStyle(color: Colors.white70, fontSize: 18)),
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
              Text("Padang, Indonesia", style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: "Cari sayur, buah, dan lainnya...",
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

  // Widget Judul Section
  Widget _buildSectionTitle(String title, {required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onTap,
          child: const Text("Lihat Semua >", style: TextStyle(color: Color(0xFF2E8B57), fontSize: 15)),
        ),
      ],
    );
  }

  // Widget List Kategori
  Widget _buildCategories() {
    final categories = [
      {'icon': Icons.eco, 'label': 'Sayuran', 'color': Colors.green[100]},
      {'icon': Icons.apple, 'label': 'Buah', 'color': Colors.red[100]},
      {'icon': Icons.set_meal, 'label': 'Daging', 'color': Colors.red[100]},
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

  // Widget Banner Promo
  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 46, 139, 87),
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
                const Text("Untuk pembelian pertama", style: TextStyle(color: Color.fromARGB(190, 255, 255, 255), fontSize: 14)),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color.fromARGB(255, 46, 139, 87),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text("Belanja Sekarang"),
                )
              ],
            ),
          ),
          const Icon(Icons.shopping_basket, size: 80, color: Color.fromARGB(120, 255, 255, 255)),
        ],
      ),
    );
  }

  // Widget Grid Produk (YANG BARU DITAMBAHKAN)
  Widget _buildProductGrid() {
    final products = [
      {'name': 'Sayur Kangkung', 'shop': 'Pak Tani Jaya', 'price': 'Rp 5.000', 'image': 'assets/kangkung.jpg'},
      {'name': 'Buah Tomat', 'shop': 'Bu Sari Tani', 'price': 'Rp 12.000', 'image': 'assets/tomat.jpg'},
      {'name': 'Buah Apel', 'shop': 'Toko Buah Makmur', 'price': 'Rp 35.000', 'image': 'assets/apel.jpg'},
      {'name': 'Buah Pisang', 'shop': 'Kebun Pisang', 'price': 'Rp 18.000', 'image': 'assets/pisang.jpg'},
      {'name': 'Daging Sapi', 'shop': 'Daging Segar', 'price': 'Rp 120.000', 'image': 'assets/daging.jpg'},
      {'name': 'Daging Ayam', 'shop': 'Ayam Kampung', 'price': 'Rp 45.000', 'image': 'assets/ayam.jpg'},
    ];

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true, // PENTING: Agar tidak crash
      physics: const NeverScrollableScrollPhysics(), // Scroll ikut halaman utama
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(
                      image: NetworkImage(product['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name']!, 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      product['shop']!, 
                      style: const TextStyle(color: Colors.grey, fontSize: 10)
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product['price']!, 
                          style: const TextStyle(color: Color(0xFF2E8B57), fontWeight: FontWeight.bold)
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Color(0xFF2E8B57), 
                            shape: BoxShape.circle
                          ),
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