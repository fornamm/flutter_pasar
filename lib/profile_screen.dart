import 'dart:io'; // Untuk membaca file foto
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:flutter/foundation.dart';
import 'login.dart'; 
import 'login_service.dart';
import 'history_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoggedIn = false; 

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    final currentUser = AuthService().currentUser;
    if (currentUser != null) {
      setState(() {
        isLoggedIn = true;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  // --- FUNGSI POPUP EDIT PROFIL (LENGKAP DENGAN GANTI FOTO) ---
  void _showEditProfileDialog() {
    final user = AuthService().currentUser;
    final TextEditingController nameController = TextEditingController(text: user?['name']);
    final TextEditingController emailController = TextEditingController(text: user?['email']);
    
    // Variabel sementara untuk menampung path foto baru (sebelum disimpan)
    String? tempImagePath = user?['image']; 

    showDialog(
      context: context,
      builder: (context) {
        // StatefulBuilder PENTING agar dialog bisa refresh tampilan (ganti foto) secara real-time
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              title: Text("Edit Profil", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // --- 1. BAGIAN GANTI FOTO (DI DALAM DIALOG) ---
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: () {
                          if (tempImagePath != null) {
                             if (kIsWeb) return NetworkImage(tempImagePath!);
                             return FileImage(File(tempImagePath!));
                          }
                          if (user?['image'] != null) {
                             if (kIsWeb) return NetworkImage(user!['image']!);
                             return FileImage(File(user!['image']!));
                          }
                          return const NetworkImage('https://via.placeholder.com/150');
                        }() as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
                            // Logic ambil foto dari Galeri
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                            
                            if (image != null) {
                              // Update tampilan DI DALAM DIALOG saja (Preview)
                              setStateDialog(() {
                                tempImagePath = image.path;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2E8B57),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),

                  // --- 2. INPUT FIELD ---
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Nama Lengkap",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFF2E8B57)), borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFF2E8B57)), borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context), 
                  child: const Text("Batal", style: TextStyle(color: Colors.grey)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // --- 3. PROSES SIMPAN DATA ---
                    
                    // Simpan Nama & Email
                    AuthService().updateProfile(nameController.text, emailController.text);
                    
                    // Simpan Foto (Jika ada perubahan)
                    if (tempImagePath != null) {
                      AuthService().updatePhoto(tempImagePath!);
                    }

                    // Refresh Halaman ProfileScreen Utama (Parent)
                    setState(() {});
                    
                    Navigator.pop(context); // Tutup Dialog

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profil berhasil diperbarui!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E8B57)),
                  child: const Text("Simpan", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          // Header Hijau
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF2E8B57),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Column(
              children: [
                Text("Profil", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),

          // Konten Utama
          Padding(
            padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
            child: isLoggedIn ? _buildLoggedInView() : _buildGuestView(),
          ),
        ],
      ),
    );
  }

  // --- TAMPILAN USER (SUDAH LOGIN) ---
  Widget _buildLoggedInView() {
    final user = AuthService().currentUser;
    
    // Logic Gambar untuk Tampilan Utama (Read Only)
ImageProvider imageProvider;
    
    if (user != null && user['image'] != null) {
      if (kIsWeb) {
        imageProvider = NetworkImage(user['image']!);
      } else {
        imageProvider = FileImage(File(user['image']!));
      }
    } else {
      imageProvider = const NetworkImage('https://via.placeholder.com/150');
    }
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: Row(
            children: [
              // --- AVATAR POLOS (TANPA IKON KAMERA) ---
              CircleAvatar(
                radius: 35,
                backgroundImage: imageProvider,
                backgroundColor: Colors.grey[200],
              ),
              // ----------------------------------------
              
              const SizedBox(width: 16),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?['name'] ?? "User E-Pasar", 
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      user?['email'] ?? "user@epasar.com",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // TOMBOL EDIT (Ini yang akan membuka Dialog)
              IconButton(
                icon: const Icon(Icons.edit, color: Color(0xFF2E8B57)),
                onPressed: _showEditProfileDialog, 
              )
            ],
          ),
        ),
        
        const SizedBox(height: 24),

        // Menu Pilihan
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              _buildMenuItem(Icons.shopping_bag_outlined, "Riwayat Pesanan", () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen()));
              }),
              _buildMenuItem(Icons.logout, "Keluar", () {
                AuthService().logout(); 
                setState(() => isLoggedIn = false);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil keluar")));
              }, isRed: true),
            ],
          ),
        ),
      ],
    );
  }

  // --- TAMPILAN TAMU ---
  Widget _buildGuestView() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.grey[100], shape: BoxShape.circle),
            child: const Icon(Icons.person_outline, size: 40, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          Text("Masuk ke Akun Anda", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 8),
          Text("Dapatkan pengalaman belanja yang lebih personal", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity, height: 45,
            child: ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthScreen()));
                if (!mounted) return;
                if (result == true) {
                  setState(() => isLoggedIn = true);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil masuk!"), backgroundColor: Color(0xFF2E8B57)));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2E8B57), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
              child: Text("Masuk / Daftar", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {
              AuthService().loginDev(); 
              _checkLoginStatus(); 
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Mode Admin Aktif")));
            },
            style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF2E8B57)), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)), minimumSize: const Size(double.infinity, 45)),
            child: Text("Simulasi Login (Admin)", style: GoogleFonts.poppins(color: const Color(0xFF2E8B57))),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isRed = false}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: isRed ? Colors.red[50] : Colors.green[50], shape: BoxShape.circle),
        child: Icon(icon, color: isRed ? Colors.red : const Color(0xFF2E8B57), size: 20),
      ),
      title: Text(title, style: GoogleFonts.poppins(fontSize: 14, color: isRed ? Colors.red : Colors.black87)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
      onTap: onTap,
    );
  }
}