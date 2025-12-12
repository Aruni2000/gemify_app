import 'package:flutter/material.dart';

class LikedListingsScreen extends StatefulWidget {
  const LikedListingsScreen({super.key});

  @override
  State<LikedListingsScreen> createState() => _LikedListingsScreenState();
}

class _LikedListingsScreenState extends State<LikedListingsScreen> {
  // Simulated liked items - replace with actual data
  final List<Map<String, dynamic>> likedItems = [
    // Empty list for empty state
    // Uncomment below to show actual listings
    /*
    {
      'name': 'Ruby',
      'quality': 'Premium',
      'price': '\$1,250',
      'image': Icons.diamond,
      'color': Colors.red,
    },
    {
      'name': 'Sapphire',
      'quality': 'High Quality',
      'price': '\$890',
      'image': Icons.diamond,
      'color': Colors.blue,
    },
    */
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
          'Liked Listings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D3142),
          ),
        ),
      ),
      body: likedItems.isEmpty ? _buildEmptyState() : _buildListingsList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EAF6),
                borderRadius: BorderRadius.circular(60),
              ),
              child: const Icon(
                Icons.favorite_border,
                size: 60,
                color: Color(0xFF9FA8DA),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No Liked Listings Yet',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D3142),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Start exploring gems and save your favorites here. Tap the heart icon on any listing to add it to your collection.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _navigateToHome(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D3142),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Explore Gems',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListingsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: likedItems.length,
      itemBuilder: (context, index) {
        final item = likedItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                // Navigate to gem details
              },
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: item['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        item['image'],
                        size: 40,
                        color: item['color'],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['quality'],
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['price'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          likedItems.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Navigate to home screen
  void _navigateToHome(BuildContext context) {
    // Option 1: Pop until home (if home is the first page in navigator)
    Navigator.of(context).popUntil((route) => route.isFirst);

    // Option 2: Use named route (if you have route names set up)
    // Navigator.of(context).pushReplacementNamed('/home');

    // Option 3: Pop back to settings, then to home
    // Navigator.pop(context);
  }
}
