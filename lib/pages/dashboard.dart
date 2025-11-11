import 'package:flutter/material.dart';
import '../components/navbar.dart';
import './family_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // --- USER PROFILE ---
  Map<String, String> userProfile = {
    'name': 'Kushagra Pandey',
    'age': '22',
    'city': 'Delhi',
    'bio':
        'Flutter Developer passionate about creating smooth UI experiences and innovative mobile apps.',
    'occupation': 'App Developer',
    'gotra': 'Kashyap',
    'rashi': 'Leo',
    'imageUrl': 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
  };

  // --- FAMILY MEMBERS ---
  List<Map<String, String>> familyMembers = [
    {
      'name': 'Aarav Pandey',
      'relation': 'Brother',
      'age': '25',
      'occupation': 'Software Engineer',
      'gotra': 'Kashyap',
      'rashi': 'Leo',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2202/2202112.png',
    },
    {
      'name': 'Sakshi Pandey',
      'relation': 'Sister',
      'age': '20',
      'occupation': 'Student',
      'gotra': 'Kashyap',
      'rashi': 'Capricorn',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2922/2922561.png',
    },
    {
      'name': 'Rajesh Pandey',
      'relation': 'Father',
      'age': '52',
      'occupation': 'Businessman',
      'gotra': 'Kashyap',
      'rashi': 'Taurus',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/236/236831.png',
    },
    {
      'name': 'Pooja Pandey',
      'relation': 'Mother',
      'age': '48',
      'occupation': 'Teacher',
      'gotra': 'Kashyap',
      'rashi': 'Cancer',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2922/2922565.png',
    },
    {
      'name': 'Ananya Pandey',
      'relation': 'Sister',
      'age': '18',
      'occupation': 'Student',
      'gotra': 'Kashyap',
      'rashi': 'Pisces',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2922/2922510.png',
    },
    {
      'name': 'Rohit Pandey',
      'relation': 'Cousin',
      'age': '24',
      'occupation': 'Engineer',
      'gotra': 'Kashyap',
      'rashi': 'Gemini',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2202/2202112.png',
    },
    {
      'name': 'Neha Pandey',
      'relation': 'Cousin',
      'age': '23',
      'occupation': 'Designer',
      'gotra': 'Kashyap',
      'rashi': 'Virgo',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2922/2922656.png',
    },
    {
      'name': 'Ramesh Pandey',
      'relation': 'Uncle',
      'age': '50',
      'occupation': 'Accountant',
      'gotra': 'Kashyap',
      'rashi': 'Sagittarius',
      'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2922/2922655.png',
    },
  ];

  // --- USER IMAGES SECTION ---
  final List<dynamic> _userImages = [
    'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
  ];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _userImages.add(File(picked.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        title: const Text('User Dashboard'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- USER PROFILE CARD ---
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      userProfile['imageUrl']!,
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProfile['name']!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.work, size: 18, color: Colors.deepPurple),
                            const SizedBox(width: 6),
                            Text(
                              userProfile['occupation']!,
                              style: const TextStyle(color: Colors.black87),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 18, color: Colors.redAccent),
                            const SizedBox(width: 6),
                            Text(userProfile['city']!,
                                style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.cake, size: 18, color: Colors.pinkAccent),
                            const SizedBox(width: 6),
                            Text('Age: ${userProfile['age']}',
                                style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 18, color: Colors.orange),
                            const SizedBox(width: 6),
                            Text('Rashi: ${userProfile['rashi']}',
                                style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.family_restroom,
                                size: 18, color: Colors.teal),
                            const SizedBox(width: 6),
                            Text('Gotra: ${userProfile['gotra']}',
                                style: const TextStyle(color: Colors.black87)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userProfile['bio']!,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- FAMILY MEMBERS SECTION ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Family Members',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              FamilyMembersPage(familyMembers: familyMembers)),
                    );
                  },
                  child: const Text('Show More',
                      style: TextStyle(color: Colors.deepPurple)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: familyMembers.length,
                itemBuilder: (context, index) {
                  final member = familyMembers[index];
                  return Container(
                    width: 90,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            member['imageUrl']!,
                            height: 60,
                            width: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          member['name']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 13, color: Colors.black87),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // --- USER PHOTOS SECTION ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Photos',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                IconButton(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.add_a_photo,
                      color: Colors.deepPurple, size: 26),
                ),
              ],
            ),
            const SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _userImages.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final img = _userImages[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: img is File
                      ? Image.file(img, fit: BoxFit.cover)
                      : Image.network(img, fit: BoxFit.cover),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }
}
