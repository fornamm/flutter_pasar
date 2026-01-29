

class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addToCart(Map<String, dynamic> product) {
    _items.add(product);
  }
  
  // Fungsi Hitung Total Harga
  int getTotalPrice() {
    int total = 0;
    for (var item in _items) {
      String priceString = item['price'].toString()
          .replaceAll('Rp ', '')
          .replaceAll('.', '');
      total += int.parse(priceString);
    }
    return total;
  }

  void clearCart() {
    _items.clear();
  }
}