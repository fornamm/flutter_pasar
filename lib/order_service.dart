// lib/order_service.dart

class OrderService {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  // List untuk menyimpan riwayat pesanan
  // Struktur: [{ 'id': 'ORD-001', 'date': '...', 'total': 50000, 'items': [...] }]
  final List<Map<String, dynamic>> _orders = [];

  // Getter
  List<Map<String, dynamic>> get orders => _orders;

  // Fungsi Tambah Pesanan (Dipanggil saat Checkout)
  void placeOrder(List<Map<String, dynamic>> cartItems, int totalPrice) {
    // Kita buat ID Pesanan acak berdasarkan waktu
    String orderId = "ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}";
    
    // Simpan Tanggal Hari Ini
    DateTime now = DateTime.now();
    String date = "${now.day}/${now.month}/${now.year}";

    _orders.insert(0, { // insert(0) agar pesanan terbaru ada di paling atas
      'id': orderId,
      'date': date,
      'total': totalPrice,
      'status': 'Dikemas', // Status awal
      // PENTING: Gunakan List.from() untuk menyalin data (bukan cuma referensi)
      // Kalau tidak, saat keranjang dihapus, riwayat juga ikut terhapus.
      'items': List<Map<String, dynamic>>.from(cartItems), 
    });
  }
}