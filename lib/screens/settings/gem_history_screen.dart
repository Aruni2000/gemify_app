import 'dart:io';
import 'package:flutter/material.dart';

class GemHistoryScreen extends StatefulWidget {
  const GemHistoryScreen({super.key});

  @override
  State<GemHistoryScreen> createState() => _GemHistoryScreenState();
}

class _GemHistoryScreenState extends State<GemHistoryScreen> {
  // Sample gem history data
  final List<GemRecord> gemHistory = [
    GemRecord(
      gemName: 'Ruby',
      category: 'Precious',
      scannedDate: DateTime.now().subtract(const Duration(days: 1)),
      confidence: 95,
      imageUrl: 'assets/images/gem_sample.png',
    ),
    GemRecord(
      gemName: 'Sapphire',
      category: 'Precious',
      scannedDate: DateTime.now().subtract(const Duration(days: 2)),
      confidence: 92,
      imageUrl: 'assets/images/gem_sample_2.png',
    ),
    GemRecord(
      gemName: 'Emerald',
      category: 'Precious',
      scannedDate: DateTime.now().subtract(const Duration(days: 3)),
      confidence: 88,
      imageUrl: 'assets/images/gem_sample_3.png',
    ),
    GemRecord(
      gemName: 'Amethyst',
      category: 'Semi-Precious',
      scannedDate: DateTime.now().subtract(const Duration(days: 5)),
      confidence: 85,
      imageUrl: 'assets/images/gem_sample_4.png',
    ),
    GemRecord(
      gemName: 'Diamond',
      category: 'Precious',
      scannedDate: DateTime.now().subtract(const Duration(days: 7)),
      confidence: 98,
      imageUrl: 'assets/images/gem_sample.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3142)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Gem History',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D3142),
          ),
        ),
      ),
      body: gemHistory.isEmpty ? _buildEmptyState() : _buildGemsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.diamond_outlined,
              size: 80,
              color: const Color(0xFF2D3142).withOpacity(0.3),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No Gems Scanned Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2D3142).withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start scanning gems to build your history',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF2D3142).withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGemsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: gemHistory.length,
      itemBuilder: (context, index) {
        final gem = gemHistory[index];
        return _buildGemCard(gem);
      },
    );
  }

  Widget _buildGemCard(GemRecord gem) {
    return GestureDetector(
      onTap: () {
        // Navigate to gem detail if needed
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              // Gem Image
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.purple.shade100, Colors.blue.shade100],
                  ),
                ),
                child: gem.imageUrl.isNotEmpty
                    ? (gem.imageUrl.startsWith('assets/')
                          ? Image.asset(gem.imageUrl, fit: BoxFit.cover)
                          : Image.file(File(gem.imageUrl), fit: BoxFit.cover))
                    : const Icon(
                        Icons.diamond,
                        size: 45,
                        color: Color(0xFF2D3142),
                      ),
              ),

              // Gem Info
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Gem Name
                      Text(
                        gem.gemName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D3142),
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Category Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(
                            gem.category,
                          ).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          gem.category,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: _getCategoryColor(gem.category),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Confidence and Date
                      Row(
                        children: [
                          Icon(
                            Icons.verified,
                            size: 14,
                            color: const Color(0xFF10B981),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${gem.confidence}%',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF10B981),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.schedule,
                            size: 14,
                            color: const Color(0xFF2D3142).withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatDate(gem.scannedDate),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF2D3142).withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Delete Button
              Padding(
                padding: const EdgeInsets.all(12),
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: const Color(0xFF2D3142).withOpacity(0.4),
                  ),
                  onPressed: () {
                    _showDeleteDialog(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Precious':
        return const Color(0xFFDC2626);
      case 'Semi-Precious':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6B7280);
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Record'),
          content: const Text(
            'Are you sure you want to delete this gem record?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Record deleted')));
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}

class GemRecord {
  final String gemName;
  final String category;
  final DateTime scannedDate;
  final int confidence;
  final String imageUrl;

  GemRecord({
    required this.gemName,
    required this.category,
    required this.scannedDate,
    required this.confidence,
    required this.imageUrl,
  });
}
