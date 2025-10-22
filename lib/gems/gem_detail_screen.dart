import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/gem.dart';

class GemDetailScreen extends StatelessWidget {
  final Gem gem;

  const GemDetailScreen({super.key, required this.gem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(gem.gemName),
        backgroundColor: Colors.blue.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // --- Gem Image ---
            if (gem.gemImage != null && gem.gemImage!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(gem.gemImage!),
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.diamond, size: 100, color: Colors.blue),
              ),
            const SizedBox(height: 24),

            // --- Gem Information Card ---
            _buildSectionCard(
              title: "Gem Information",
              children: [
                _buildInfoRow("Code", gem.gemCode),
                _buildInfoRow("Variety", gem.gemVariety),
                _buildInfoRow("Holder", gem.gemHolder),
                _buildInfoRow("Previous Owner", gem.previousOwner),
              ],
            ),

            const SizedBox(height: 16),

            // --- Weights & Dimensions Card ---
            _buildSectionCard(
              title: "Weights & Dimensions",
              children: [
                _buildInfoRow("Rough Weight", "${gem.roughWeight} g"),
                _buildInfoRow(
                  "Weight After Perform",
                  "${gem.weightAfterPerform} g",
                ),
                _buildInfoRow(
                  "Weight After Cut & Polish",
                  "${gem.weightAfterCutAndPolish} g",
                ),
                _buildInfoRow(
                  "Width After Cut & Polish",
                  "${gem.widthAfterCutPolish} mm",
                ),
                _buildInfoRow(
                  "Height After Cut & Polish",
                  "${gem.heightAfterCutPolish} mm",
                ),
              ],
            ),

            const SizedBox(height: 16),

            // --- Pricing & Charges Card ---
            _buildSectionCard(
              title: "Pricing & Charges",
              children: [
                _buildInfoRow(
                  "Purchased Price",
                  "\$${gem.purchasedPrice.toStringAsFixed(2)}",
                ),
                _buildInfoRow(
                  "Performing Charges",
                  "\$${gem.performingCharges.toStringAsFixed(2)}",
                ),
                _buildInfoRow(
                  "Cutting Charges",
                  "\$${gem.cuttingCharges.toStringAsFixed(2)}",
                ),
                _buildInfoRow(
                  "Total Cost",
                  "\$${gem.totalCost.toStringAsFixed(2)}",
                ),
                _buildInfoRow(
                  "Purchased Date",
                  "${gem.purchasedDate.toLocal()}".split(" ")[0],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Card Section Builder ---
  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade700,
              ),
            ),
            const Divider(color: Colors.grey, thickness: 1.2),
            ...children,
          ],
        ),
      ),
    );
  }

  // --- Row Builder with Label on Left & Value Right-aligned ---
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "$label:",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
