import 'package:flutter/material.dart';
import '../components/main_nav.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Community',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),

      // ================= BODY =================
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        children: [
          // ================= COMMUNITY HEADER =================
          _CommunityHeader(),

          const SizedBox(height: 16),

          // ================= ANNOUNCEMENTS =================
          _CommunityTile(
            icon: Icons.campaign_outlined,
            title: 'Announcements',
            subtitle: 'Official community updates',
            onTap: () {
              Navigator.pushNamed(context, '/announcements');
            },
          ),

          const Divider(height: 32),

          // ================= GROUPS TITLE =================
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Groups',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ================= GROUP LIST =================
          _CommunityTile(
            icon: Icons.groups,
            title: 'Marriage Discussions',
            subtitle: '120 members',
            onTap: () {
              Navigator.pushNamed(context, '/group-marriage');
            },
          ),

          _CommunityTile(
            icon: Icons.event,
            title: 'Upcoming Events',
            subtitle: '5 events scheduled',
            onTap: () {
              Navigator.pushNamed(context, '/events');
            },
          ),

          _CommunityTile(
            icon: Icons.family_restroom,
            title: 'Family Network',
            subtitle: 'Connect with families',
            onTap: () {
              Navigator.pushNamed(context, '/family-network');
            },
          ),

          _CommunityTile(
            icon: Icons.favorite_border,
            title: 'Matrimonial Support',
            subtitle: 'Help & guidance',
            onTap: () {
              Navigator.pushNamed(context, '/support');
            },
          ),

          const SizedBox(height: 24),
        ],
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }
}

// ================= COMMUNITY HEADER (WhatsApp Style) =================
class _CommunityHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.groups,
              color: Color(0xFFE91E63),
              size: 30,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Community Connect',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Stay connected with your community',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= COMMUNITY LIST TILE =================
class _CommunityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _CommunityTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            // ICON
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFE91E63),
                size: 24,
              ),
            ),

            const SizedBox(width: 14),

            // TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // ARROW
            const Icon(
              Icons.chevron_right,
              color: Colors.black45,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
