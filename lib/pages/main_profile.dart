import 'package:flutter/material.dart';
import '../components/main_nav.dart';

class MainProfilePage extends StatefulWidget {
  const MainProfilePage({super.key});

  @override
  State<MainProfilePage> createState() => _MainProfilePageState();
}

class _MainProfilePageState extends State<MainProfilePage> {
  bool _showProfileOptions = false;

  // ================= COLORS =================
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF374151);
  static const Color textMuted = Color(0xFF6B7280);
  static const Color accentPink = Color(0xFFE91E63);

  // ================= DUMMY USER DATA =================
  final user = {
    'name': 'Rohan Kumar',
    'age': '30',
    'location': 'Bangalore, Karnataka',
    'profession': 'Senior Software Engineer',
    'education': 'B.Tech from IIT Delhi',
    'about':
        'Passionate software engineer who loves building innovative products. Enjoy fitness, traveling, and spending time with family.',
    'height': "5'10\"",
    'religion': 'Hindu',
    'motherTongue': 'Hindi',
    'image': 'assets/profile.jpg',
  };

  final List<Map<String, String>> familyMembers = [
    {
      'name': 'Rajesh Kumar',
      'relation': 'Father',
      'age': '55',
      'phone': '9876543210',
      'profession': 'Retired Govt. Officer',
    },
    {
      'name': 'Sunita Kumar',
      'relation': 'Mother',
      'age': '50',
      'phone': '9876543222',
      'profession': 'Teacher',
    },
    {
      'name': 'Amit Kumar',
      'relation': 'Brother',
      'age': '25',
      'phone': '9876543333',
      'profession': 'Software Engineer',
    },
  ];

  final List<Map<String, String>> matches = [
    {
      'name': 'Priya Sharma',
      'status': 'Liked',
      'image': 'assets/girl_profile.jpg',
    },
    {
      'name': 'Neha Verma',
      'status': 'Matched',
      'image': 'assets/girl2_profile.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => _showProfileOptions = true),
            icon: CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage(user['image']!),
            ),
          ),
          const SizedBox(width: 8),
        ],
        iconTheme: const IconThemeData(color: textPrimary),
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ================= HEADER IMAGE =================
                Stack(
                  children: [
                    SizedBox(
                      height: h * 0.35,
                      width: double.infinity,
                      child: Image.asset(user['image']!, fit: BoxFit.cover),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: _verifiedBadge(),
                    ),
                  ],
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _title('${user['name']}, ${user['age']}'),
                      const SizedBox(height: 12),

                      _iconText(Icons.location_on, user['location']!),
                      _iconText(Icons.work, user['profession']!),
                      _iconText(Icons.school, user['education']!),

                      const SizedBox(height: 24),

                      _section('About Me'),
                      _body(user['about']!),

                      const SizedBox(height: 28),

                      _section('Personal Details'),
                      _kv('Height', user['height']!),
                      _kv('Religion', user['religion']!),
                      _kv('Mother Tongue', user['motherTongue']!),

                      const SizedBox(height: 30),

                      // ================= FAMILY =================
                      _sectionHeader(
                        'Family Members',
                        () => Navigator.pushNamed(context, '/see-member'),
                      ),
                      const SizedBox(height: 14),

                      SizedBox(
                        height: 190,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: familyMembers.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (_, i) =>
                              _familyCard(familyMembers[i]),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ================= MATCHES =================
                      _sectionHeader(
                        'My Matches',
                        () => Navigator.pushNamed(context, '/matches'),
                      ),
                      const SizedBox(height: 14),

                      SizedBox(
                        height: 170,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: matches.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 12),
                          itemBuilder: (_, i) => _matchCard(matches[i]),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (_showProfileOptions)
            GestureDetector(
              onTap: () => setState(() => _showProfileOptions = false),
              child: Container(
                width: w,
                height: h,
                color: Colors.black.withOpacity(0.4),
                child: Center(child: _popup(w)),
              ),
            ),
        ],
      ),

      bottomNavigationBar: const BottomNavBar(selectedIndex: 4),
    );
  }

  // ================= UI HELPERS =================
  Widget _verifiedBadge() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            Icon(Icons.verified, color: Colors.orange, size: 16),
            SizedBox(width: 4),
            Text(
              'Verified',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: textSecondary,
              ),
            ),
          ],
        ),
      );

  Widget _title(String t) => Text(
        t,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
      );

  Widget _section(String t) => Text(
        t,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
      );

  Widget _sectionHeader(String title, VoidCallback onTap) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _section(title),
          TextButton(
            onPressed: onTap,
            child: const Text(
              'View All',
              style: TextStyle(
                color: accentPink,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );

  Widget _iconText(IconData i, String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Icon(i, size: 18, color: accentPink),
            const SizedBox(width: 6),
            Text(
              t,
              style: const TextStyle(
                fontSize: 15,
                color: textSecondary,
              ),
            ),
          ],
        ),
      );

  Widget _body(String t) => Text(
        t,
        style: const TextStyle(
          fontSize: 15,
          height: 1.4,
          color: textMuted,
        ),
      );

  Widget _kv(String k, String v) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              k,
              style: const TextStyle(fontSize: 15, color: textMuted),
            ),
            Text(
              v,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: textSecondary,
              ),
            ),
          ],
        ),
      );

  Widget _familyCard(Map<String, String> f) => SizedBox(
        width: 260,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      f['name']!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      f['relation']!,
                      style: const TextStyle(
                        color: accentPink,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _detail(Icons.cake, 'Age', f['age']!),
              _detail(Icons.work, 'Profession', f['profession']!),
              _detail(Icons.phone, 'Phone', f['phone']!),
            ],
          ),
        ),
      );

  Widget _detail(IconData i, String l, String v) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            Icon(i, size: 16, color: accentPink),
            const SizedBox(width: 8),
            Text(
              '$l:',
              style: const TextStyle(fontSize: 14, color: textMuted),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                v,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textSecondary,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _matchCard(Map<String, String> m) => SizedBox(
        width: 120,
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(m['image']!, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              m['name']!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textSecondary,
              ),
            ),
            Text(
              m['status']!,
              style: TextStyle(
                fontSize: 12,
                color:
                    m['status'] == 'Matched' ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
      );

  Widget _popup(double w) => Container(
        width: w * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            ListTile(title: Text('Edit Profile')),
            Divider(height: 1),
            ListTile(title: Text('Add Family Member')),
            Divider(height: 1),
            ListTile(title: Text('Logout')),
          ],
        ),
      );
}
