// lib/history_screen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'order_service.dart'; // Import Service

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = OrderService().orders; // Ambil data pesanan

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Riwayat Pesanan",
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  Text("Belum ada riwayat pesanan", style: GoogleFonts.poppins(color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _buildOrderCard(context, order);
              },
            ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Kartu (ID & Status)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Belanja: ${order['date']}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  Text(order['id'], style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E8B57).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  order['status'], 
                  style: const TextStyle(color: Color(0xFF2E8B57), fontSize: 12, fontWeight: FontWeight.bold)
                ),
              )
            ],
          ),
          const Divider(height: 20),
          
          // List Barang (Preview 2 barang pertama saja biar rapi)
          ...List.generate(
            (order['items'] as List).length > 2 ? 2 : (order['items'] as List).length, 
            (index) {
              final item = order['items'][index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(image: AssetImage(item['image']), fit: BoxFit.cover),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['name'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text("${item['price']} x 1", style: const TextStyle(fontSize: 10, color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              );
            }
          ),
          
          // Jika barang lebih dari 2, tampilkan "+X barang lainnya"
          if ((order['items'] as List).length > 2)
             Text(
              "+ ${(order['items'] as List).length - 2} barang lainnya",
              style: const TextStyle(fontSize: 10, color: Colors.grey),
             ),

          const Divider(height: 20),
          
          // Total Harga & Tombol
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Belanja", style: TextStyle(fontSize: 10, color: Colors.grey)),
                  Text(
                    "Rp ${order['total']}", 
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF2E8B57)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("Beli Lagi", style: TextStyle(color: Color(0xFF2E8B57), fontSize: 12)),
              )
            ],
          )
        ],
      ),
    );
  }
}