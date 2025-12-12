import 'package:flutter/material.dart';
import 'liked_listings_screen.dart';
import 'gem_history_screen.dart';
import 'advanced_settings_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
          'Settings',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D3142),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Profile Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8EAF6),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 32,
                            color: Color(0xFF9FA8DA),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Aruni Nethmini',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Free Plan',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tap to edit profile',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Unlock Pro Features Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D3142),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.diamond,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Unlock Pro Features',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D3142),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Unlimited scans, enhanced accuracy & more',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D3142),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Upgrade',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Account & Subscription Section
            _buildSection(
              title: 'ACCOUNT & SUBSCRIPTION',
              items: [
                _SettingsItem(
                  icon: Icons.favorite,
                  iconColor: Colors.red,
                  title: 'Liked Listings',
                  subtitle: 'View your saved listings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LikedListingsScreen(),
                      ),
                    );
                  },
                ),
                _SettingsItem(
                  icon: Icons.access_time,
                  iconColor: Colors.red,
                  title: 'Gem History',
                  subtitle: 'View your scanned rock history',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GemHistoryScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Help & Support Section
            _buildSection(
              title: 'HELP & SUPPORT',
              items: [
                _SettingsItem(
                  icon: Icons.headset_mic,
                  iconColor: Colors.purple,
                  title: 'Contact Support',
                  subtitle: 'Get help from our team',
                  onTap: () {
                    // TODO: Navigate to contact support
                  },
                ),
                _SettingsItem(
                  icon: Icons.help_outline,
                  iconColor: Colors.teal,
                  title: 'FAQs',
                  subtitle: 'Find answers to common questions',
                  onTap: () {
                    // TODO: Navigate to FAQs
                  },
                ),
                _SettingsItem(
                  icon: Icons.lightbulb_outline,
                  iconColor: Colors.purple,
                  title: 'Help Us Improve',
                  subtitle: 'Share feedback, report bugs, or suggest features',
                  onTap: () {
                    // TODO: Navigate to feedback
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Community Section
            _buildSection(
              title: 'COMMUNITY',
              items: [
                _SettingsItem(
                  icon: Icons.star,
                  iconColor: Colors.orange,
                  title: 'Rate Gemify',
                  subtitle: 'Share your experience',
                  onTap: () {
                    // TODO: Open app store rating
                  },
                ),
                _SettingsItem(
                  icon: Icons.share,
                  iconColor: Colors.pink,
                  title: 'Share with Friends',
                  subtitle: 'Spread the word about Gemify',
                  onTap: () {
                    // TODO: Share app
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Legal & Privacy Section
            _buildSection(
              title: 'LEGAL & PRIVACY',
              items: [
                _SettingsItem(
                  icon: Icons.description,
                  iconColor: Colors.grey,
                  title: 'Privacy Policy',
                  subtitle: '',
                  onTap: () {
                    // TODO: Navigate to privacy policy
                  },
                ),
                _SettingsItem(
                  icon: Icons.settings,
                  iconColor: Colors.orange,
                  title: 'Advanced Settings',
                  subtitle: '',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdvancedSettingsScreen(),
                      ),
                    );
                  },
                ),
                _SettingsItem(
                  icon: Icons.info_outline,
                  iconColor: Colors.blue,
                  title: 'About Gemify',
                  subtitle: '',
                  onTap: () {
                    // TODO: Navigate to about page
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Account Actions Section
            _buildSection(
              title: 'ACCOUNT ACTIONS',
              items: [
                _SettingsItem(
                  icon: Icons.logout,
                  iconColor: Colors.red,
                  title: 'Sign Out',
                  subtitle: '',
                  onTap: () {
                    _showSignOutDialog(context);
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Version Number
            const Center(
              child: Text(
                '3.6.0 (53)',
                style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<_SettingsItem> items,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF6B7280),
                letterSpacing: 0.5,
              ),
            ),
          ),
          Container(
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
            child: Column(
              children: items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return Column(
                  children: [
                    _buildSettingsItem(item),
                    if (index < items.length - 1)
                      Padding(
                        padding: const EdgeInsets.only(left: 72),
                        child: Divider(
                          height: 1,
                          color: const Color(0xFFE8EAF6),
                        ),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(_SettingsItem item) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: item.iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(item.icon, color: item.iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  if (item.subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF), size: 20),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Sign Out?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          content: const Text(
            'Are you sure you want to sign out?',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // TODO: Implement sign out logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signed out successfully')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SettingsItem {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  _SettingsItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}
