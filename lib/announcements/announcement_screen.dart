import 'package:flutter/material.dart';
import 'data/announcement_data.dart';
import 'widgets/announcement_card.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  final List<String> banners = [
    "assets/announcements/banner1.png",
    "assets/announcements/banner2.png",
    "assets/announcements/banner3.png",
  ];

  int currentBanner = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announcements"),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu actions here
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "settings", child: Text("Settings")),
              const PopupMenuItem(value: "about", child: Text("About")),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting text
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ), // reduced vertical padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi Aruni,",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 2), // tighter spacing between lines
                  Text(
                    "Find your best solutions!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Banner slider with dots
            SizedBox(
              height: 160,
              child: PageView.builder(
                controller: _pageController,
                itemCount: banners.length,
                onPageChanged: (index) {
                  setState(() {
                    currentBanner = index;
                  });
                },
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
            ),

            const SizedBox(height: 8),

            // Dot indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentBanner == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentBanner == index ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // "All Announcements" section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "All Announcements",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            // List of announcements
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: announcements.length,
              itemBuilder: (context, index) {
                final event = announcements[index];
                return AnnouncementCard(
                  title: event["title"],
                  date: event["date"],
                  price: event["price"],
                  location: event["location"],
                  image: event["image"],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
