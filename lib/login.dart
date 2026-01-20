import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_service.dart'; // 1. Import Service

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true; 
  bool isPasswordVisible = false;

  // 2. Tambahkan Controller untuk mengambil teks inputan user
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Fungsi untuk menangani tombol aksi
  void _handleAuthAction() {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Validasi sederhana
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email dan Password tidak boleh kosong!")),
      );
      return;
    }

    if (isLogin) {
      // --- LOGIKA LOGIN ---
      bool success = AuthService().login(email, password);
      if (success) {
        // Login Sukses -> Kirim sinyal 'true' ke ProfileScreen
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email atau Password salah!"), backgroundColor: Colors.red),
        );
      }
    } else {
      // --- LOGIKA DAFTAR ---
      if (name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nama Lengkap harus diisi!")),
        );
        return;
      }

      bool success = AuthService().register(name, email, password);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pendaftaran Berhasil! Silakan Login."), backgroundColor: Colors.green),
        );
        // Otomatis pindah ke tab Login
        setState(() {
          isLogin = true;
          _passwordController.clear(); // Bersihkan password biar aman
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Email sudah terdaftar!"), backgroundColor: Colors.orange),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          // LAYER 1: Background Hijau
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            color: const Color(0xFF2E8B57),
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text("E-Pasar", style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                Text("Pasar tradisional dalam genggaman", style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70)),
              ],
            ),
          ),

          // LAYER 2: Kartu Putih
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TOGGLE SWITCH
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        children: [
                          _buildToggleButton("Masuk", true),
                          _buildToggleButton("Daftar", false),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // FORM INPUT (Sambungkan Controller)
                    if (!isLogin) ...[
                      _buildInputLabel("Nama Lengkap"),
                      _buildTextField(
                        controller: _nameController, // <--- Sambungkan
                        hint: "Masukkan nama lengkap", 
                        icon: Icons.person_outline
                      ),
                      const SizedBox(height: 16),
                    ],

                    _buildInputLabel("Email"),
                    _buildTextField(
                      controller: _emailController, // <--- Sambungkan
                      hint: "nama@email.com", 
                      icon: Icons.email_outlined
                    ),
                    const SizedBox(height: 16),

                    _buildInputLabel("Password"),
                    _buildTextField(
                      controller: _passwordController, // <--- Sambungkan
                      hint: "Minimal 6 karakter", 
                      icon: Icons.lock_outline,
                      isPassword: true
                    ),
                    const SizedBox(height: 24),

                    // TOMBOL AKSI UTAMA
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _handleAuthAction, // Panggil fungsi di atas
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E8B57),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        ),
                        child: Text(
                          isLogin ? "Masuk" : "Daftar",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Footer Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isLogin ? "Belum punya akun? " : "Sudah punya akun? ",
                          style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isLogin = !isLogin;
                              // Bersihkan input saat ganti mode
                              _nameController.clear();
                              _emailController.clear();
                              _passwordController.clear();
                            });
                          },
                          child: Text(
                            isLogin ? "Daftar sekarang" : "Masuk",
                            style: const TextStyle(color: Color(0xFF2E8B57), fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    
                    GestureDetector(
                      onTap: () => Navigator.pop(context, false),
                      child: Text("Lanjutkan tanpa akun →", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool isLoginMode) {
    bool isActive = isLogin == isLoginMode;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isLogin = isLoginMode;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: isActive
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
                )
              : null,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, color: isActive ? Colors.black : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _buildTextField({
      required String hint, 
      required IconData icon, 
      required TextEditingController controller, // Wajibkan Controller
      bool isPassword = false
    }) {
    return TextFormField(
      controller: controller, // Pasang Controller
      obscureText: isPassword ? !isPasswordVisible : false,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
        prefixIcon: Icon(icon, color: Colors.grey, size: 20),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey, size: 20),
                onPressed: () {
                  setState(() => isPasswordVisible = !isPasswordVisible);
                },
              )
            : null,
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2E8B57))),
      ),
    );
  }
}