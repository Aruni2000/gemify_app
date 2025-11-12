import 'package:flutter/material.dart';

class BottomBarView extends StatelessWidget {
  /// Current selected index (0-4)
  final int currentIndex;

  /// Callback function when tab is tapped
  final Function(int) onTap;

  const BottomBarView({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Container(
          height: 65,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNavItem(icon: Icons.home_rounded, label: 'Home', index: 0),
              _buildNavItem(
                icon: Icons.inventory_2_rounded,
                label: 'Inventory',
                index: 1,
              ),
              _buildCenterButton(),
              _buildNavItem(
                icon: Icons.shopping_bag_rounded,
                label: 'Shop',
                index: 3,
              ),
              _buildNavItem(
                icon: Icons.campaign_rounded,
                label: 'Offers',
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build minimalist navigation item with label
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color.fromARGB(255, 28, 31, 112).withOpacity(0.15)
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: isSelected
                      ? const Color.fromARGB(255, 34, 16, 99)
                      : const Color(0xFF2D3142).withOpacity(0.4),
                  size: 22,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? const Color.fromARGB(255, 20, 18, 94)
                    : const Color(0xFF2D3142).withOpacity(0.5),
                letterSpacing: 0,
                height: 1.0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Build featured center button
  Widget _buildCenterButton() {
    final isSelected = currentIndex == 2;

    return GestureDetector(
      onTap: () => onTap(2),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 172, 188, 255),
              const Color.fromARGB(255, 142, 162, 250),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 155, 132, 234).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
      ),
    );
  }
}
