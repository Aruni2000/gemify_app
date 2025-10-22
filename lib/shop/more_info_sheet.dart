import 'package:flutter/material.dart';

class MoreInfoSheet extends StatelessWidget {
  const MoreInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Center(
              child: Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const Text(
              "Contact Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ContactRow(icon: Icons.phone, text: "+94 77 123 4567"),
                SizedBox(height: 6),
                ContactRow(icon: Icons.email, text: "sapphire@gems.lk"),
                SizedBox(height: 6),
                ContactRow(
                  icon: Icons.message,
                  text: "+94 77 987 6543 (WhatsApp)",
                ),
                SizedBox(height: 6),
                ContactRow(icon: Icons.web, text: "www.sapphiregems.lk"),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              "About Store",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Sapphire Gem Store has been serving the finest quality gemstones "
              "for over 20 years. Visit us for a wide selection of sapphires, "
              "rubies, and other precious gems. Our friendly staff are ready "
              "to assist you with your perfect gem purchase.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Implement call functionality
                },
                icon: const Icon(Icons.call),
                label: const Text("Call Outlet"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Reuse the ContactRow widget
class ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const ContactRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
