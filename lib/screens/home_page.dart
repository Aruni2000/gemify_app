import 'package:flutter/material.dart';
import 'package:gemify/gems/gem_list_screen.dart';
import 'package:gemify/shop/gem_details_screen.dart';
import 'package:gemify/shop/shop_create.dart';
import 'dart:ui';
import '../theme/gemify_theme.dart';
import '../announcements/announcement_screen.dart';
import 'package:gemify/gems/add_gem_screen.dart';
import 'package:gemify/shop/shop_home_screen.dart';
import 'package:gemify/shop/gem_modal.dart';
import 'package:gemify/shop/gem_data.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';

/// Main Home Page with Bottom Navigation
/// This manages the overall app navigation and page switching
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Track current tab index
  int _currentIndex = 0;

  // List of pages for each tab
  final List<Widget> _pages = [
    const HomeContent(), // Home tab content
    const GemListScreen(), // Inventory tab
    const AddGemScreen(), // Add Gem tab
    const ShopCreateScreen(), // Shop tab now redirects to create shop
    const AnnouncementScreen(), // Announcement tab
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      // Display current page based on selected tab
      body: _pages[_currentIndex],

      // 🔹 Using the separated Bottom Navigation Bar component
      bottomNavigationBar: BottomBarView(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

/// Home Content Widget (Your existing home page content)
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String selectedCategory = "All";
  final List<String> categories = [
    "All",
    "Sapphire",
    "Ruby",
    "Emerald",
    "Diamond",
  ];

  // 🎯 PageController for announcement slider
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // 📋 List of announcement banners
  final List<Map<String, String>> announcements = [
    {'image': 'assets/announcements/banner1.png', 'title': 'Special Offer'},
    {'image': 'assets/announcements/banner2.png', 'title': 'New Arrivals'},
    {
      'image': 'assets/announcements/banner3.png',
      'title': 'Premium Collection',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // 🔹 Header Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipOval(
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.purple.shade300,
                                      Colors.blue.shade300,
                                    ],
                                  ),
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Good Morning!",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2D3142),
                                  ),
                                ),
                                const Text(
                                  "Gemify Explorer",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2D3142),
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      iconSize: 26,
                      color: const Color(0xFF2D3142),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Search Bar with Filter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search gems...",
                                hintStyle: TextStyle(
                                  color: Color(0xFF2D3142).withOpacity(0.4),
                                  fontSize: 14,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Color(0xFF2D3142).withOpacity(0.5),
                                  size: 22,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D3142),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.tune,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 4),

              // 🔹 RECOMMENDED SECTION WITH SLIDER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recommended",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D3142),
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 🎠 ANNOUNCEMENT SLIDER WITH DOTS
                    Column(
                      children: [
                        // PageView Slider
                        SizedBox(
                          height: 180,
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            itemCount: announcements.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AnnouncementScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 20,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Stack(
                                        children: [
                                          // Background Image
                                          Positioned.fill(
                                            child: Image.asset(
                                              announcements[index]['image']!,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                    return Container(
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                              colors: [
                                                                Colors
                                                                    .purple
                                                                    .shade300,
                                                                Colors
                                                                    .blue
                                                                    .shade300,
                                                              ],
                                                            ),
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons
                                                              .campaign_outlined,
                                                          size: 64,
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                            ),
                                          ),

                                          // Gradient Overlay
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.black.withOpacity(
                                                      0.3,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                          // View Details Button
                                          Positioned(
                                            bottom: 12,
                                            right: 12,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                  sigmaX: 10,
                                                  sigmaY: 10,
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 14,
                                                        vertical: 8,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                  child: const Text(
                                                    "View Details",
                                                    style: TextStyle(
                                                      color: Color(0xFF2D3142),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 12),

                        // 🔵 DOT INDICATORS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            announcements.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentPage == index ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? const Color(0xFF2D3142)
                                    : const Color(0xFF2D3142).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // 🔹 GEM COLLECTION WITH CATEGORIES
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Gem Collection",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2D3142),
                            letterSpacing: 0.3,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddGemScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "view all",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),

                    // Categories
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final isSelected = selectedCategory == category;
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = category;
                                });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF2D3142)
                                          : Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.06),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          _getCategoryIcon(category),
                                          size: 18,
                                          color: isSelected
                                              ? Colors.white
                                              : const Color(
                                                  0xFF2D3142,
                                                ).withOpacity(0.7),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          category,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: isSelected
                                                ? Colors.white
                                                : const Color(
                                                    0xFF2D3142,
                                                  ).withOpacity(0.7),
                                            letterSpacing: 0.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Gem Grid - Image Focused
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio:
                                0.85, // Adjusted for better image focus
                          ),
                      itemCount: gemsList.length > 1 ? gemsList.length - 1 : 0,
                      itemBuilder: (context, index) {
                        final gem = gemsList[index + 1];
                        return _buildImageFocusedGemCard(context, gem, index);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100), // Extra space for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  // 🎨 IMAGE-FOCUSED GEM CARD - Simplified & Clean
  Widget _buildImageFocusedGemCard(BuildContext context, Gem gem, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GemDetailsScreen(gem: gem)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // 🖼️ MAIN IMAGE - Takes full card space
              Positioned.fill(
                child: Image.asset(
                  gem.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.shade100,
                            Colors.blue.shade100,
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Subtle gradient at bottom only
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
              ),

              // ⭐ Top Right - Rating Badge (Small & Minimal)
              Positioned(
                top: 8,
                right: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 11),
                          const SizedBox(width: 2),
                          Text(
                            "${(4.5 + (index * 0.1)).toStringAsFixed(1)}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // ❤️ Top Left - Heart Icon (Small & Minimal)
              Positioned(
                top: 8,
                left: 8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ),

              // 📝 Bottom - Minimal Info
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Gem Name - Single line
                      Text(
                        gem.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),

                      // Price & Collection in one line
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price
                          Text(
                            gem.price,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          // Collection badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "Premium",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.95),
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Sapphire":
        return Icons.water_drop;
      case "Ruby":
        return Icons.favorite;
      case "Emerald":
        return Icons.eco;
      case "Diamond":
        return Icons.diamond;
      default:
        return Icons.grid_view;
    }
  }
}

// Placeholder for Inventory Page
class InventoryPlaceholder extends StatelessWidget {
  const InventoryPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [const Color(0xFFE8EAF6), const Color(0xFFF3E5F5)],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 80,
              color: Color(0xFF2D3142),
            ),
            SizedBox(height: 16),
            Text(
              "Inventory Page",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D3142),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Your gem inventory will appear here",
              style: TextStyle(fontSize: 14, color: Color(0xFF2D3142)),
            ),
          ],
        ),
      ),
    );
  }
}
