import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async'; // Import Timer untuk Notifikasi

import 'products_screen.dart';
import 'cart_service.dart'; // Import Cart Service
import 'login_service.dart'; // Import Auth Service

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  // --- LOGIC NOTIFIKASI TOAST (TETAP ADA) ---
  void _showTopNotification(String productName) {
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: "$productName masuk keranjang",
        onDismissed: () => overlayEntry.remove(),
      ),
    );
    Overlay.of(context).insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context), // Panggil Header

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                children: [
                  _buildSectionTitle(context, "Kategori", onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProductsScreen()));
                  }),
                  const SizedBox(height: 20),
                  _buildCategories(context),
                ],
              ),
            ),

            _buildPromoBanner(context),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildSectionTitle(context, "Produk Terlaris", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProductsScreen()));
                  }),
                  const SizedBox(height: 20),
                  _buildProductGrid(),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HEADER (LOKASI MANUAL & NAMA USER) ---
  Widget _buildHeader(BuildContext context) {
    // 1. AMBIL DATA USER DARI SERVICE
    final user = AuthService().currentUser;
    
    // 2. DEFINISIKAN NAMA (Jika tidak ada user, pakai "Tamu")
    String displayName = user != null ? user['name']! : "Tamu";

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
              Expanded( 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Selamat datang,", style: TextStyle(color: Colors.white70, fontSize: 18)),
                    
                    // NAMA USER
                    Text(
                      displayName, 
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 5),
          
          // LOKASI (MANUAL / STATIS)
          Row(
            children: const [
              Icon(Icons.location_on, color: Colors.white, size: 14),
              SizedBox(width: 4),
              Text(
                "Padang, Indonesia", // Lokasi manual
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          TextField(
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AllProductsScreen(initialSearch: value)));
              }
            },
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: "Cari sayur, buah, dan lainnya...",
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET LAINNYA ---
  Widget _buildSectionTitle(BuildContext context, String title, {required VoidCallback onTap}) {
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

  Widget _buildCategories(BuildContext context) {
    final categories = [
      {'icon': Icons.eco, 'label': 'Sayuran'},
      {'icon': Icons.apple, 'label': 'Buah-buahan'},
      {'icon': Icons.set_meal, 'label': 'Daging'},
      {'icon': Icons.water_drop, 'label': 'Ikan'},
      {'icon': Icons.local_fire_department, 'label': 'Bumbu'},
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((cat) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AllProductsScreen(initialCategory: cat['label'] as String)));
          },
          child: Column(
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
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllProductsScreen()));
                  },
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

  Widget _buildProductGrid() {
    final products = [
      {'name': 'Sayur Kangkung', 'shop': 'Pak Tani Jaya', 'price': 'Rp 5.000', 'image': 'assets/kangkung.jpg'},
      {'name': 'Buah Tomat', 'shop': 'Bu Sari Tani', 'price': 'Rp 12.000', 'image': 'assets/tomat.jpg'},
      {'name': 'Buah Apel', 'shop': 'Toko Buah Makmur', 'price': 'Rp 35.000', 'image': 'assets/apel.jpg'},
      {'name': 'Buah Pisang', 'shop': 'Kebun Pisang', 'price': 'Rp 18.000', 'image': 'assets/pisang.jpg'},
    ];

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 16, mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(image: AssetImage(product['image']!), fit: BoxFit.cover),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(product['shop']!, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product['price']!, style: const TextStyle(color: Color(0xFF2E8B57), fontWeight: FontWeight.bold)),
                        Container(
                          width: 30, height: 30,
                          decoration: const BoxDecoration(color: Color(0xFF2E8B57), shape: BoxShape.circle),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.add, color: Colors.white, size: 16),
                            onPressed: () {
                                CartService().addToCart(product);
                                _showTopNotification(product['name']!);
                            },
                          ),
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

// Widget Toast (Animasi Notifikasi)
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
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _offsetAnimation = Tween<Offset>(begin: const Offset(1.2, 0.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.forward();
    });

    _timer = Timer(const Duration(milliseconds: 2500), () {
      if (mounted) _controller.reverse().then((value) => widget.onDismissed());
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
      top: 60, right: 16,
      child: Material(
        color: Colors.transparent,
        child: SlideTransition(
          position: _offsetAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF2E8B57),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Text(widget.message, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}