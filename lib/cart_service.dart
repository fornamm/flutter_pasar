// lib/cart_service.dart

class CartService {
  // Membuat Singleton (Agar data tetap tersimpan meski pindah halaman)
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  // List untuk menyimpan barang belanjaan
  final List<Map<String, dynamic>> _items = [];

  // Getter untuk mengambil data
  List<Map<String, dynamic>> get items => _items;

  // Fungsi Tambah Barang
  void addToCart(Map<String, dynamic> product) {
    _items.add(product);
  }

  // Fungsi Hapus Barang (Opsional untuk nanti)
  void removeFromCart(Map<String, dynamic> product) {
    _items.remove(product);
  }
  
  // Fungsi Hitung Total Harga
  int getTotalPrice() {
    int total = 0;
    for (var item in _items) {
      // Membersihkan string harga "Rp 5.000" menjadi integer 5000
      String priceString = item['price'].toString()
          .replaceAll('Rp ', '')
          .replaceAll('.', '');
      total += int.parse(priceString);
    }
    return total;
  }

  // Fungsi Bersihkan Keranjang
  void clearCart() {
    _items.clear();
  }
}