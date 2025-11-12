import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gemify/gems/gem_list_screen.dart';
import '../../../models/gem.dart';

class GemDetailScreen extends StatelessWidget {
  final Gem gem;

  const GemDetailScreen({super.key, required this.gem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFE8EAF6),
              const Color(0xFFF3E5F5),
              const Color(0xFFE1F5FE),
              const Color(0xFFFCE4EC),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xFF2D3142),
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gem.gemName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D3142),
                              letterSpacing: 0.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            gem.gemVariety,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF2D3142).withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.more_vert,
                            color: Color(0xFF2D3142),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gem Image with Enhanced Design
                      _buildImageCard(),
                      const SizedBox(height: 24),

                      // Quick Stats Cards
                      Row(
                        children: [
                          Expanded(
                            child: _buildQuickStatCard(
                              icon: Icons.attach_money,
                              label: "Total Cost",
                              value: "\$${gem.totalCost.toStringAsFixed(0)}",
                              gradient: [
                                Colors.green.shade300,
                                Colors.teal.shade300,
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildQuickStatCard(
                              icon: Icons.monitor_weight,
                              label: "Final Weight",
                              value: "${gem.weightAfterCutAndPolish} ct",
                              gradient: [
                                Colors.purple.shade300,
                                Colors.blue.shade300,
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Gem Information
                      _buildSectionTitle("Gem Information", Icons.diamond),
                      const SizedBox(height: 12),
                      _buildInfoCard([
                        _buildInfoRow("Code", gem.gemCode, Icons.qr_code),
                        _buildInfoRow(
                          "Variety",
                          gem.gemVariety,
                          Icons.category,
                        ),
                        _buildInfoRow("Holder", gem.gemHolder, Icons.person),
                        _buildInfoRow(
                          "Previous Owner",
                          gem.previousOwner,
                          Icons.history,
                        ),
                      ]),

                      const SizedBox(height: 20),

                      // Weights & Dimensions
                      _buildSectionTitle(
                        "Weights & Dimensions",
                        Icons.straighten,
                      ),
                      const SizedBox(height: 12),
                      _buildInfoCard([
                        _buildInfoRow(
                          "Rough Weight",
                          "${gem.roughWeight} ct",
                          Icons.scale,
                        ),
                        _buildInfoRow(
                          "Weight After Perform",
                          "${gem.weightAfterPerform} ct",
                          Icons.build_circle,
                        ),
                        _buildInfoRow(
                          "Weight After Cut & Polish",
                          "${gem.weightAfterCutAndPolish} ct",
                          Icons.auto_awesome,
                        ),
                        _buildInfoRow(
                          "Width After Cut & Polish",
                          "${gem.widthAfterCutPolish} mm",
                          Icons.swap_horiz,
                        ),
                        _buildInfoRow(
                          "Height After Cut & Polish",
                          "${gem.heightAfterCutPolish} mm",
                          Icons.height,
                        ),
                      ]),

                      const SizedBox(height: 20),

                      // Pricing & Charges
                      _buildSectionTitle("Pricing & Charges", Icons.payments),
                      const SizedBox(height: 12),
                      _buildInfoCard([
                        _buildInfoRow(
                          "Purchased Price",
                          "\$${gem.purchasedPrice.toStringAsFixed(2)}",
                          Icons.shopping_bag,
                        ),
                        _buildInfoRow(
                          "Performing Charges",
                          "\$${gem.performingCharges.toStringAsFixed(2)}",
                          Icons.build,
                        ),
                        _buildInfoRow(
                          "Cutting Charges",
                          "\$${gem.cuttingCharges.toStringAsFixed(2)}",
                          Icons.content_cut,
                        ),
                        _buildDivider(),
                        _buildInfoRow(
                          "Total Cost",
                          "\$${gem.totalCost.toStringAsFixed(2)}",
                          Icons.calculate,
                          isHighlight: true,
                        ),
                        _buildInfoRow(
                          "Purchased Date",
                          "${gem.purchasedDate.toLocal()}".split(" ")[0],
                          Icons.calendar_today,
                        ),
                      ]),

                      const SizedBox(height: 20),

                      // View Gem Inventory Button - Small Version
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GemListScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.purple.shade100,
                                  Colors.blue.shade100,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.shade100.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.inventory_2,
                                  color: const Color(0xFF2D3142),
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'View Gem Inventory',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(
                                      0xFF2D3142,
                                    ).withOpacity(0.8),
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Edit and Delete Buttons
                      Row(
                        children: [
                          Expanded(
                            child: _buildActionButton(
                              context: context,
                              label: "Edit",
                              icon: Icons.edit,
                              gradient: [
                                Colors.blue.shade400,
                                Colors.blue.shade600,
                              ],
                              onTap: () {
                                // TODO: Navigate to edit screen
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Edit functionality coming soon',
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildActionButton(
                              context: context,
                              label: "Delete",
                              icon: Icons.delete,
                              gradient: [
                                Colors.red.shade400,
                                Colors.red.shade600,
                              ],
                              onTap: () {
                                _showDeleteConfirmation(context);
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard() {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Background Image or Placeholder
            if (gem.gemImage != null && gem.gemImage!.isNotEmpty)
              Positioned.fill(
                child: Image.file(File(gem.gemImage!), fit: BoxFit.cover),
              )
            else
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.purple.shade100, Colors.blue.shade100],
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.diamond,
                      size: 80,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                ),
              ),

            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                  ),
                ),
              ),
            ),

            // Favorite Icon
            Positioned(
              top: 12,
              right: 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),

            // Gem Code Badge
            Positioned(
              bottom: 12,
              left: 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.qr_code,
                          size: 16,
                          color: Color(0xFF2D3142),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          gem.gemCode,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2D3142),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatCard({
    required IconData icon,
    required String label,
    required String value,
    required List<Color> gradient,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2D3142).withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D3142),
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required List<Color> gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.red.shade600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Delete Gem?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete "${gem.gemName}"? This action cannot be undone.',
            style: const TextStyle(fontSize: 14, color: Color(0xFF2D3142)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                // TODO: Implement delete functionality
                Navigator.pop(context); // Go back to previous screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${gem.gemName} deleted successfully'),
                    backgroundColor: Colors.red.shade600,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade100, Colors.blue.shade100],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF2D3142)),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D3142),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    IconData icon, {
    bool isHighlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isHighlight
                  ? const Color(0xFF2D3142).withOpacity(0.1)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 16,
              color: isHighlight
                  ? const Color(0xFF2D3142)
                  : Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isHighlight ? FontWeight.w700 : FontWeight.w600,
                color: const Color(0xFF2D3142).withOpacity(0.7),
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isHighlight
                  ? const Color(0xFF2D3142)
                  : const Color(0xFF2D3142).withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        color: const Color(0xFF2D3142).withOpacity(0.1),
        thickness: 1.5,
      ),
    );
  }
}
