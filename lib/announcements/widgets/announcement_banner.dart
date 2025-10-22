import 'package:flutter/material.dart';

class AnnouncementBanner extends StatelessWidget {
  const AnnouncementBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final banners = [
      "assets/announcements/banner1.png",
      "assets/announcements/banner2.png",
      "assets/announcements/banner3.png",
    ];

    return SizedBox(
      height: 160,
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(banners[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
