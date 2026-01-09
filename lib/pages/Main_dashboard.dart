import 'package:flutter/material.dart';
import '../components/main_nav.dart';

class MainDashboardPage extends StatelessWidget {
  const MainDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 12),
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          childAspectRatio: 0.95,
          children: [
            _HomeTile(
              icon: Icons.family_restroom,
              title: 'Family\nManagement',
              onTap: () => Navigator.pushNamed(context, '/see-member'),
            ),
            _HomeTile(
              icon: Icons.favorite_border,
              title: 'Matrimonial',
              onTap: () => Navigator.pushNamed(context, '/matches'),
            ),
            _HomeTile(
              icon: Icons.mail_outline,
              title: 'Requests &\nApprovals',
              onTap: () => Navigator.pushNamed(context, '/likes'),
            ),
            _HomeTile(
              icon: Icons.groups,
              title: 'Community',
              onTap: () => Navigator.pushNamed(context, '/community'),
            ),
          ],
        ),
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}

// ================= HOME TILE =================
class _HomeTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _HomeTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Container
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                size: 32,
                color: const Color(0xFFE91E63),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
