class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addToCart(Map<String, dynamic> product) {
    _items.add(product);
  }

  void removeFromCart(Map<String, dynamic> product) {
    _items.remove(product);
  }

  void clearCart() {
    _items.clear();
  }

  String getTotalPrice() {
    double total = 0;
    for (var item in _items) {
      try {
        String cleanPrice = item['price'].toString().replaceAll('Rp ', '').replaceAll('.', '');
        total += double.parse(cleanPrice);
      } catch (e) {
        print("Error parsing price: $e");
      }
    }
    String result = total.toStringAsFixed(0);
    String formatted = "";
    int count = 0;
    for (int i = result.length - 1; i >= 0; i--) {
      count++;
      formatted = result[i] + formatted;
      if (count % 3 == 0 && i != 0) formatted = ".$formatted";
    }
    return formatted;
  }
}