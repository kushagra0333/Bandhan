import 'package:flutter/material.dart';
import '../components/navbar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _showProfileOptions = false;

  void _showProfilePopup() {
    setState(() {
      _showProfileOptions = true;
    });
  }

  void _hideProfilePopup() {
    setState(() {
      _showProfileOptions = false;
    });
  }

  void _handleOptionClick(String option) {
  _hideProfilePopup();

  switch (option) {
    case 'edit_personal':
      Navigator.pushReplacementNamed(context, '/edit-details');
      break;

    case 'add_family':
      Navigator.pushReplacementNamed(context, '/add-member');
      break;

    case 'see_family':
      Navigator.pushReplacementNamed(context, '/see-member');
      break;
  }
}


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              onPressed: _showProfilePopup,
              icon: const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.35,
                      child:
                          Image.asset('assets/profile.jpg', fit: BoxFit.cover),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.verified,
                                color: Colors.orange, size: 16),
                            SizedBox(width: 4),
                            Text(
                              'Verified',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // ================== USER INFO SECTION ==================
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Rohan Kumar, 30',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Color(0xFFE91E63),
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Bangalore, Karnataka',
                            style: TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          Icon(Icons.work, color: Color(0xFFE91E63), size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Senior Software Engineer',
                            style: TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          Icon(Icons.school,
                              color: Color(0xFFE91E63), size: 18),
                          SizedBox(width: 6),
                          Text(
                            'B.Tech from IIT Delhi',
                            style: TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ================== ABOUT ME ==================
                      const Text(
                        'About Me',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Passionate software engineer who loves building innovative products. Enjoy fitness, traveling, and spending time with family. Looking for a life partner to share adventures with.',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.4,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // ================== INTERESTS ==================
                      const Text(
                        'Interests',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),

                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Technology',
                              style: TextStyle(
                                color: Color(0xFFE91E63),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Fitness',
                              style: TextStyle(
                                color: Color(0xFFE91E63),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Travel',
                              style: TextStyle(
                                color: Color(0xFFE91E63),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Cricket',
                              style: TextStyle(
                                color: Color(0xFFE91E63),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'Music',
                              style: TextStyle(
                                color: Color(0xFFE91E63),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // ================== PERSONAL DETAILS ==================
                      const SizedBox(height: 30),
                      const Text(
                        'Personal Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 14),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Height',
                            style: TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                          Text(
                            "5'10\"",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Religion',
                            style: TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                          Text(
                            'Hindu',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Mother Tongue',
                            style: TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                          Text(
                            'Hindi',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      // ================== FAMILY DETAILS ==================
                      const SizedBox(height: 26),
                      Row(
                        children: const [
                          Icon(
                            Icons.family_restroom,
                            color: Color(0xFFE91E63),
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Family Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Father's Occupation",
                            style: TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                          Text(
                            'Software developer',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Mother's Occupation",
                            style: TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                          Text(
                            'Teacher',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Siblings",
                            style: TextStyle(
                                fontSize: 15, color: Colors.black87),
                          ),
                          Text(
                            '1 Sister (Younger)',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      const SizedBox(height: 28),

                      // ================== PARTNER EXPECTATIONS ==================
                      Row(
                        children: const [
                          Icon(
                            Icons.favorite_border,
                            color: Color(0xFFE91E63),
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Partner Expectations',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      const Text(
                        'Looking for an educated, caring partner who values family and has similar life goals.',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),

                      // ================== MY PHOTOS ==================
                      const SizedBox(height: 28),
                      const Text(
                        'My Photos',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // GRID VIEW FOR PHOTOS
                      GridView.count(
                        crossAxisCount: 3, // 3 photos per row
                        shrinkWrap: true,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        physics:
                            const NeverScrollableScrollPhysics(), // avoid nested scroll issues
                        children: [
                          'assets/profile.jpg',
                          'assets/profile1.jpg',
                          'assets/profile2.webp',
                          'assets/profile3.jpg',
                        ].map((path) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(path, fit: BoxFit.cover),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ================== PROFILE OPTIONS POPUP ==================
          if (_showProfileOptions)
            GestureDetector(
              onTap: _hideProfilePopup,
              child: Container(
                width: screenWidth,
                height: screenHeight,
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: GestureDetector(
                    onTap: () {}, // Prevent closing when clicking on card
                    child: Container(
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black12,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: const Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      AssetImage('assets/profile.jpg'),
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rohan Kumar',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'View and manage profile',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Options
                          _buildOptionItem(
                            icon: Icons.edit,
                            title: 'Edit Personal Details',
                            subtitle: 'Update your personal information',
                            onTap: () => _handleOptionClick('edit_personal'),
                          ),
                          _buildOptionItem(
                            icon: Icons.person_add,
                            title: 'Add Family Members',
                            subtitle: 'Add new family members to your profile',
                            onTap: () => _handleOptionClick('add_family'),
                          ),
                          _buildOptionItem(
                            icon: Icons.group,
                            title: 'See Family Members',
                            subtitle: 'View all family members',
                            onTap: () => _handleOptionClick('see_family'),
                            showDivider: false,
                          ),

                          // Close Button
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _hideProfilePopup,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                      color: Colors.black26,
                                      width: 1,
                                    ),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: const Text(
                                  'Close',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
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
              ),
            ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFFE91E63),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
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
                      const SizedBox(height: 2),
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
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black45,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 1,
              color: Colors.black12,
            ),
          ),
      ],
    );
  }
}