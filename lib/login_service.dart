// lib/auth_service.dart

class AuthService {
  // Singleton (Agar data tetap ada selama aplikasi jalan)
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // 1. Database User Sementara (Simpan Nama, Email, Password)
  final List<Map<String, String>> _users = [];

  // 2. Data User yang sedang Login saat ini
  Map<String, String>? _currentUser;

  // Getter untuk mengambil user yang sedang login
  Map<String, String>? get currentUser => _currentUser;

  // --- FUNGSI DAFTAR (REGISTER) ---
  bool register(String name, String email, String password) {
    // Cek apakah email sudah terdaftar?
    bool emailExists = _users.any((user) => user['email'] == email);
    
    if (emailExists) {
      return false; // Gagal: Email sudah ada
    }

    // Simpan data user baru
    _users.add({
      'name': name,
      'email': email,
      'password': password, // Di aplikasi asli, password harus di-enkripsi!
    });
    
    return true; // Berhasil
  }

  // --- FUNGSI MASUK (LOGIN) ---
  bool login(String email, String password) {
    // Cari user yang email & password-nya cocok
    try {
      final user = _users.firstWhere(
        (u) => u['email'] == email && u['password'] == password
      );
      
      _currentUser = user; // Simpan user ini sebagai user aktif
      return true; // Login Berhasil
    } catch (e) {
      return false; // Login Gagal (User tidak ditemukan / Password salah)
    }
  }

  // --- FUNGSI KELUAR (LOGOUT) ---
  void logout() {
    _currentUser = null;
  }
}