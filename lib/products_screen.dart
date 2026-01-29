import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cart_service.dart';
import 'dart:async'; // Import untuk Timer

class AllProductsScreen extends StatefulWidget {
  final String? initialSearch;
  final String? initialCategory;

  const AllProductsScreen({
    super.key, 
    this.initialSearch, 
    this.initialCategory
  });

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  int _selectedCategoryIndex = 0;
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Semua', 'icon': null},
    {'name': 'Sayuran', 'icon': Icons.eco},
    {'name': 'Buah-buahan', 'icon': Icons.apple},
    {'name': 'Daging', 'icon': Icons.set_meal},
    {'name': 'Ikan', 'icon': Icons.water_drop},
    {'name': 'Bumbu', 'icon': Icons.local_fire_department},
  ];

  final List<Map<String, dynamic>> _allProducts = [
    {'name': 'Sayur Kangkung', 'shop': 'Pak Tani Jaya', 'price': 'Rp 5.000', 'image': 'assets/kangkung.jpg', 'category': 'Sayuran', 'isPromo': false},
    {'name': 'Buah Tomat', 'shop': 'Bu Sari Tani', 'price': 'Rp 12.000', 'image': 'assets/tomat.jpg', 'category': 'Sayuran', 'isPromo': false},
    {'name': 'Buah Apel', 'shop': 'Toko Buah Makmur', 'price': 'Rp 35.000', 'image': 'assets/apel.jpg', 'category': 'Buah-buahan', 'isPromo': true},
    {'name': 'Buah Pisang', 'shop': 'Kebun Pisang', 'price': 'Rp 18.000', 'image': 'assets/pisang.jpg', 'category': 'Buah-buahan', 'isPromo': false},
    {'name': 'Daging Sapi', 'shop': 'Daging Mantap', 'price': 'Rp 120.000', 'image': 'assets/daging.jpg', 'category': 'Daging', 'isPromo': false},
    {'name': 'Daging Ayam', 'shop': 'Daging Ayam Sehat', 'price': 'Rp 45.000', 'image': 'assets/ayam.jpg', 'category': 'Daging', 'isPromo': false},
    {'name': 'Daging Ikan', 'shop': 'Daging Ikan Segar', 'price': 'Rp 40.000', 'image': 'assets/ikan.jpg', 'category': 'Ikan', 'isPromo': false},
    {'name': 'Telur Ayam', 'shop': 'Telur Ayam Besar', 'price': 'Rp 25.000', 'image': 'assets/telur.jpg', 'category': 'Daging', 'isPromo': false},
    {'name': 'Bawang Merah', 'shop': 'Bawang Merah Segar', 'price': 'Rp 15.000', 'image': 'assets/bawmer.jpg', 'category': 'Bumbu', 'isPromo': false},
    {'name': 'Bawang Putih', 'shop': 'Bawang Putih Segar', 'price': 'Rp 12.000', 'image': 'assets/bawput.jpg', 'category': 'Bumbu', 'isPromo': false},
    {'name': 'Cabai Merah', 'shop': 'Cabai Merah Segar', 'price': 'Rp 20.000', 'image': 'assets/cabmer.jpg', 'category': 'Bumbu', 'isPromo': false},
    {'name': 'Cabai Hijau', 'shop': 'Cabai Hijau Segar', 'price': 'Rp 20.000', 'image': 'assets/cabhijau.jpg', 'category': 'Bumbu', 'isPromo': false},
    {'name': 'Cengkeh', 'shop': 'Cengkeh Berkualitas', 'price': 'Rp 25.000', 'image': 'assets/cengkeh.jpg', 'category': 'Bumbu', 'isPromo': false},
    {'name': 'Daun Bawang', 'shop': 'Daun Bawang Segar', 'price': 'Rp 10.000', 'image': 'assets/daunbaw.jpg', 'category': 'Bumbu', 'isPromo': false},
    {'name': 'Jagung', 'shop': 'Jagung Segar', 'price': 'Rp 15.000', 'image': 'assets/jagung.jpg', 'category': 'Buah-buahan', 'isPromo': false},
    {'name': 'Jahe', 'shop': 'Jahe Segar', 'price': 'Rp 20.000', 'image': 'assets/jahe.jpg', 'category': 'Bumbu', 'isPromo': false},
    {'name': 'Jamur', 'shop': 'Jamur Segar', 'price': 'Rp 25.000', 'image': 'assets/jamur.jpg', 'category': 'Sayuran', 'isPromo': false},
    {'name': 'Kayu Manis', 'shop': 'Kayu Manis Segar', 'price': 'Rp 30.000', 'image': 'assets/kayumanis.jpg', 'category': 'Bumbu', 'isPromo': false},
    {'name': 'Kecap', 'shop': 'Kecap Bango', 'price': 'Rp 15.000', 'image': 'assets/kecap.jpg', 'category': 'Bumbu', 'isPromo': false},
    {'name': 'Kelapa', 'shop': 'Kelapa Segar', 'price': 'Rp 7.000', 'image': 'assets/kelapa.jpg', 'category': 'Buah-buahan', 'isPromo': false},
    {'name': 'Kentang', 'shop': 'Kentang Segar', 'price': 'Rp 10.000', 'image': 'assets/kentang.jpg', 'category': 'Sayuran', 'isPromo': false},
    {'name': 'Minyak Goreng', 'shop': 'Minyak Goreng Kelapa', 'price': 'Rp 20.000', 'image': 'assets/minyakgor.jpg', 'category': 'Bumbu', 'isPromo': false},
    {'name': 'Sambal', 'shop': 'Sambal ABC Segar', 'price': 'Rp 6.000', 'image': 'assets/sambal.jpg', 'category': 'Bumbu', 'isPromo': false},
    {'name': 'Serai', 'shop': 'Serai Segar', 'price': 'Rp 4.000', 'image': 'assets/serai.jpg', 'category': 'Bumbu', 'isPromo': false},
    {'name': 'Terong', 'shop': 'Terong Segar', 'price': 'Rp 15.000', 'image': 'assets/terong.jpg', 'category': 'Sayuran', 'isPromo': false},
  ];

  List<Map<String, dynamic>> _foundProducts = [];

  @override
  void initState() {
    super.initState();
    _foundProducts = _allProducts;

    if (widget.initialSearch != null && widget.initialSearch!.isNotEmpty) {
      _searchController.text = widget.initialSearch!;
      _runSearchFilter(widget.initialSearch!);
    }

    if (widget.initialCategory != null) {
      final index = _categories.indexWhere((cat) => cat['name'] == widget.initialCategory);
      if (index != -1) {
        setState(() {
          _selectedCategoryIndex = index;
        });
        _runCategoryFilter(widget.initialCategory!);
      }
    }
  }

  void _runSearchFilter(String keyword) {
    List<Map<String, dynamic>> results = [];
    if (keyword.isEmpty) {
      results = _allProducts;
    } else {
      results = _allProducts
          .where((product) => product['name'].toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() => _foundProducts = results);
  }

  void _runCategoryFilter(String categoryName) {
    List<Map<String, dynamic>> results = [];
    if (categoryName == 'Semua') {
      results = _allProducts;
    } else {
      results = _allProducts
          .where((product) => product['category'] == categoryName)
          .toList();
    }
    setState(() => _foundProducts = results);
  }

  void _showTopNotification(String productName) {
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: "$productName masuk keranjang",
        onDismissed: () {
          overlayEntry.remove();
        },
      ),
    );

    Overlay.of(context).insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text("Semua Produk", style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [ ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => _runSearchFilter(value),
              decoration: InputDecoration(
                hintText: "Cari produk...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),
          
          const SizedBox(height: 16),

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
                        _searchController.clear();
                        _runCategoryFilter(cat['name']);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF2E8B57) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        cat['name'],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[600],
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${_foundProducts.length} produk ditemukan",
                style: TextStyle(color: Colors.grey[600], fontSize: 13),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: _foundProducts.isEmpty 
              ? Center(child: Text("Produk tidak ditemukan", style: GoogleFonts.poppins(color: Colors.grey)))
              : GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemCount: _foundProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final product = _foundProducts[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                    image: DecorationImage(
                                      image: AssetImage(product['image']), 
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
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
                                      onPressed: () {
                                        CartService().addToCart(product);
                                        // Ganti SnackBar biasa dengan Custom Toast
                                        _showTopNotification(product['name']);
                                      },
                                      
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                                Text(product['shop'], style: const TextStyle(color: Colors.grey, fontSize: 10)),
                                const SizedBox(height: 6),
                                Text(product['price'], style: const TextStyle(color: Color(0xFF2E8B57), fontWeight: FontWeight.bold)),
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

// ==========================================================
// KELAS KHUSUS UNTUK ANIMASI NOTIFIKASI (TOAST)
// ==========================================================
class _ToastWidget extends StatefulWidget {
  final String message;
  final VoidCallback onDismissed;

  const _ToastWidget({required this.message, required this.onDismissed});

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000), // Durasi animasi muncul (Smooth)
      vsync: this,
    );

    // Animasi Slide dari Kanan ke Kiri
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.2, 0.0), // Mulai dari luar layar kanan
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack, // Efek mental sedikit (Bouncy smooth)
    ));

    // Animasi Opasitas (Fade In)
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Jalankan animasi masuk setelah jeda sedikit (sesuai request)
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.forward();
    });

    // Timer untuk menghilangkannya setelah 2.5 detik
    _timer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted) {
        _controller.reverse().then((value) {
          widget.onDismissed();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 110, // Jarak dari atas (supaya tidak menutupi Status Bar)
      right: 16, // Jarak dari kanan
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _offsetAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF2E8B57), // Warna Hijau Tema
                borderRadius: BorderRadius.circular(30), // Rounded banget
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    widget.message,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}