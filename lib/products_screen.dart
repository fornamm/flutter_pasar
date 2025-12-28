import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  // Index kategori yang sedang dipilih (0 = Semua)
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Semua', 'icon': null},
    {'name': 'Sayuran', 'icon': Icons.eco},
    {'name': 'Buah-buahan', 'icon': Icons.apple},
    {'name': 'Daging', 'icon': Icons.set_meal},
    {'name': 'Ikan', 'icon': Icons.water_drop},
  ];

  // Data Dummy Produk
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Kangkung Segar',
      'shop': 'Pak Tani Jaya',
      'price': 'Rp 5.000',
      'unit': '/ikat',
      'rating': '4.8',
      'image': 'https://via.placeholder.com/150', // Ganti dengan aset gambar kamu nanti
      'isPromo': false,
    },
    {
      'name': 'Tomat Merah',
      'shop': 'Bu Sari Tani',
      'price': 'Rp 12.000',
      'unit': '/kg',
      'rating': '4.5',
      'image': 'https://via.placeholder.com/150',
      'isPromo': false,
    },
    {
      'name': 'Apel Fuji',
      'shop': 'Toko Buah Makmur',
      'price': 'Rp 35.000',
      'unit': '/kg',
      'rating': '4.9',
      'image': 'https://via.placeholder.com/150',
      'isPromo': true,
    },
    {
      'name': 'Pisang Cavendish',
      'shop': 'Kebun Pisang',
      'price': 'Rp 18.000',
      'unit': '/sisir',
      'rating': '4.7',
      'image': 'https://via.placeholder.com/150',
      'isPromo': false,
    },
  ];

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
            // Logika back jika dibuka dari "Lihat Semua"
            // Jika di tab bar, tombol ini mungkin tidak diperlukan atau fungsinya lain
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
        title: Text(
          "Semua Produk",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black), // Ikon Filter
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari produk...",
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Color(0xFF2E8B57)),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),

          // 2. Kategori Chips (Horizontal Scroll)
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final cat = _categories[index];
                final isSelected = _selectedCategoryIndex == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2E8B57) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          if (cat['icon'] != null) ...[
                            Icon(
                              cat['icon'], 
                              size: 16, 
                              color: isSelected ? Colors.white : Colors.grey[600]
                            ),
                            const SizedBox(width: 4),
                          ],
                          Text(
                            cat['name'],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey[600],
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // 3. Info Jumlah Produk
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${_products.length} produk ditemukan",
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 4. Grid Produk
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: _products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 Kolom
                childAspectRatio: 0.7, // Rasio tinggi/lebar kartu (diatur agar muat info)
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final product = _products[index];
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
                      // Gambar Produk & Rating
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                image: DecorationImage(
                                  image: NetworkImage(product['image']),
                                  fit: BoxFit.cover, // Ganti ini nanti dengan AssetImage jika pakai aset lokal
                                ),
                              ),
                            ),
                            // Rating Badge
                            Positioned(
                              bottom: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 12),
                                    const SizedBox(width: 4),
                                    Text(
                                      product['rating'],
                                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Tombol Tambah (+) Hijau
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2E8B57),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.add, color: Colors.white, size: 20),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Informasi Teks
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'],
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold, 
                                fontSize: 14,
                                color: Colors.black87
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              product['shop'],
                              style: TextStyle(color: Colors.grey[500], fontSize: 10),
                            ),
                            const SizedBox(height: 6),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: product['price'], 
                                    style: const TextStyle(
                                      color: Color(0xFF2E8B57), 
                                      fontWeight: FontWeight.bold, 
                                      fontSize: 14
                                    ),
                                  ),
                                  TextSpan(
                                    text: " ${product['unit']}",
                                    style: TextStyle(color: Colors.grey[400], fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}