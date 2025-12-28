import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart'; // Import ini agar kita bisa pindah ke MainNavigation

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Status apakah sedang di mode "Masuk" atau "Daftar"
  bool isLogin = true; 
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          // LAYER 1: Background Hijau (Setengah Atas)
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            color: const Color(0xFF2E8B57),
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                // Tombol Back (Hiasan saja sesuai desain)
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "E-Pasar",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Pasar tradisional dalam genggaman",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          // LAYER 2: Kartu Putih (Floating Card)
          Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TOGGLE SWITCH (Masuk / Daftar)
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          _buildToggleButton("Masuk", true),
                          _buildToggleButton("Daftar", false),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // FORM INPUT
                    if (!isLogin) ...[
                      _buildInputLabel("Nama Lengkap"),
                      _buildTextField(hint: "Masukkan nama lengkap", icon: Icons.person_outline),
                      const SizedBox(height: 16),
                    ],

                    _buildInputLabel("Email"),
                    _buildTextField(hint: "nama@email.com", icon: Icons.email_outlined),
                    const SizedBox(height: 16),

                    _buildInputLabel("Password"),
                    _buildTextField(
                      hint: "Minimal 6 karakter", 
                      icon: Icons.lock_outline,
                      isPassword: true
                    ),
                    const SizedBox(height: 24),

                    // TOMBOL AKSI (Masuk/Daftar)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // Aksi sementara: Langsung masuk ke Dashboard
                          Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (context) => const MainNavigation()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2E8B57),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          isLogin ? "Masuk" : "Daftar",
                          style: GoogleFonts.poppins(
                            fontSize: 16, 
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
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
                              isLogin = !isLogin; // Ubah mode
                            });
                          },
                          child: Text(
                            isLogin ? "Daftar sekarang" : "Masuk",
                            style: const TextStyle(
                              color: Color(0xFF2E8B57),
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                         Navigator.pushReplacement(
                            context, 
                            MaterialPageRoute(builder: (context) => const MainNavigation()),
                          );
                      },
                      child: Text(
                        "Lanjutkan tanpa akun →",
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
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

  // WIDGET HELPER: Tombol Toggle (Masuk/Daftar)
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
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4),
                  ],
                )
              : null,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // WIDGET HELPER: Label Input
  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ),
    );
  }

  // WIDGET HELPER: TextField Custom
  Widget _buildTextField({required String hint, required IconData icon, bool isPassword = false}) {
    return TextFormField(
      obscureText: isPassword ? !isPasswordVisible : false,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
        prefixIcon: Icon(icon, color: Colors.grey, size: 20),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.grey[50],
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2E8B57)),
        ),
      ),
    );
  }
}