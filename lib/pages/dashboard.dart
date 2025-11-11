import 'package:flutter/material.dart';
import '../components/navbar.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // --- USER PROFILE ---
  // --- USER PROFILE ---
Map<String, String> userProfile = {
  'name': 'Rohan Sharma',
  'age': '28',
  'city': 'Jaipur',
  'bio': 'Flutter enthusiast and creative thinker who loves designing clean, user-friendly mobile apps.',
  'occupation': 'UI/UX Designer',
  'gotra': 'Bharadwaj',
  'rashi': 'Virgo',
  'imageUrl': 'https://cdn-icons-png.flaticon.com/512/4333/4333609.png',
};

// --- FAMILY MEMBERS ---
List<Map<String, String>> familyMembers = [
  {
    'name': 'Ankit Sharma',
    'relation': 'Brother',
    'age': '31',
    'occupation': 'Civil Engineer',
    'gotra': 'Bharadwaj',
    'rashi': 'Aries',
    'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2202/2202112.png',
  },
  {
    'name': 'Priya Sharma',
    'relation': 'Sister',
    'age': '25',
    'occupation': 'Graphic Designer',
    'gotra': 'Bharadwaj',
    'rashi': 'Libra',
    'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2922/2922561.png',
  },
  {
    'name': 'Meera Sharma',
    'relation': 'Mother',
    'age': '52',
    'occupation': 'Teacher',
    'gotra': 'Bharadwaj',
    'rashi': 'Cancer',
    'imageUrl': 'https://cdn-icons-png.flaticon.com/512/921/921071.png',
  },
  {
    'name': 'Rajesh Sharma',
    'relation': 'Father',
    'age': '56',
    'occupation': 'Bank Manager',
    'gotra': 'Bharadwaj',
    'rashi': 'Sagittarius',
    'imageUrl': 'https://cdn-icons-png.flaticon.com/512/236/236832.png',
  },
  {
    'name': 'Sneha Sharma',
    'relation': 'Cousin',
    'age': '22',
    'occupation': 'Medical Student',
    'gotra': 'Bharadwaj',
    'rashi': 'Aquarius',
    'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2922/2922561.png',
  },
  {
    'name': 'Aditya Sharma',
    'relation': 'Uncle',
    'age': '48',
    'occupation': 'Businessman',
    'gotra': 'Bharadwaj',
    'rashi': 'Leo',
    'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2202/2202112.png',
  },
  {
    'name': 'Nidhi Sharma',
    'relation': 'Aunt',
    'age': '45',
    'occupation': 'Homemaker',
    'gotra': 'Bharadwaj',
    'rashi': 'Pisces',
    'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2922/2922506.png',
  },
  {
    'name': 'Kavya Sharma',
    'relation': 'Cousin Sister',
    'age': '18',
    'occupation': 'High School Student',
    'gotra': 'Bharadwaj',
    'rashi': 'Gemini',
    'imageUrl': 'https://cdn-icons-png.flaticon.com/512/2922/2922561.png',
  },
];

  // --- MOCK IMAGE PICKER (simulates picking or deleting) ---
  Future<String?> _mockImagePickerDialog(String currentUrl) async {
    String newUrl = currentUrl;
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Profile Picture"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(currentUrl, width: 80, height: 80),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(
                  context,
                  'https://cdn-icons-png.flaticon.com/512/4333/4333609.png',
                ); // mock new pic
              },
              icon: const Icon(Icons.upload),
              label: const Text("Upload New"),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context, ''); // delete image
              },
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  // --- EDIT USER PROFILE ---
  void _editUserProfile() async {
    final nameController = TextEditingController(text: userProfile['name']);
    final ageController = TextEditingController(text: userProfile['age']);
    final cityController = TextEditingController(text: userProfile['city']);
    final bioController = TextEditingController(text: userProfile['bio']);
    final occupationController = TextEditingController(
      text: userProfile['occupation'],
    );
    final gotraController = TextEditingController(text: userProfile['gotra']);
    final rashiController = TextEditingController(text: userProfile['rashi']);

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final newUrl = await _mockImagePickerDialog(
                      userProfile['imageUrl']!,
                    );
                    if (newUrl != null) {
                      setDialogState(() => userProfile['imageUrl'] = newUrl);
                    }
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: userProfile['imageUrl']!.isEmpty
                        ? null
                        : NetworkImage(userProfile['imageUrl']!),
                    child: userProfile['imageUrl']!.isEmpty
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: 'City'),
                ),
                TextField(
                  controller: occupationController,
                  decoration: const InputDecoration(labelText: 'Occupation'),
                ),
                TextField(
                  controller: gotraController,
                  decoration: const InputDecoration(labelText: 'Gotra'),
                ),
                TextField(
                  controller: rashiController,
                  decoration: const InputDecoration(labelText: 'Rashi'),
                ),
                TextField(
                  controller: bioController,
                  decoration: const InputDecoration(labelText: 'Bio'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  userProfile['name'] = nameController.text;
                  userProfile['age'] = ageController.text;
                  userProfile['city'] = cityController.text;
                  userProfile['bio'] = bioController.text;
                  userProfile['occupation'] = occupationController.text;
                  userProfile['gotra'] = gotraController.text;
                  userProfile['rashi'] = rashiController.text;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  // --- ADD OR EDIT FAMILY MEMBER ---
  void _addOrEditFamilyMember({Map<String, String>? member, int? index}) async {
    final nameController = TextEditingController(text: member?['name'] ?? '');
    final relationController = TextEditingController(
      text: member?['relation'] ?? '',
    );
    final ageController = TextEditingController(text: member?['age'] ?? '');
    final occupationController = TextEditingController(
      text: member?['occupation'] ?? '',
    );
    final gotraController = TextEditingController(text: member?['gotra'] ?? '');
    final rashiController = TextEditingController(text: member?['rashi'] ?? '');
    String imageUrl =
        member?['imageUrl'] ??
        'https://cdn-icons-png.flaticon.com/512/2202/2202112.png';

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            member == null ? 'Add Family Member' : 'Edit Family Member',
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final newUrl = await _mockImagePickerDialog(imageUrl);
                    if (newUrl != null) setDialogState(() => imageUrl = newUrl);
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: imageUrl.isEmpty
                        ? null
                        : NetworkImage(imageUrl),
                    child: imageUrl.isEmpty
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: relationController,
                  decoration: const InputDecoration(labelText: 'Relation'),
                ),
                TextField(
                  controller: ageController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: occupationController,
                  decoration: const InputDecoration(labelText: 'Occupation'),
                ),
                TextField(
                  controller: gotraController,
                  decoration: const InputDecoration(labelText: 'Gotra'),
                ),
                TextField(
                  controller: rashiController,
                  decoration: const InputDecoration(labelText: 'Rashi'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newMember = {
                  'name': nameController.text,
                  'relation': relationController.text,
                  'age': ageController.text,
                  'occupation': occupationController.text,
                  'gotra': gotraController.text,
                  'rashi': rashiController.text,
                  'imageUrl': imageUrl,
                };
                setState(() {
                  if (member == null) {
                    familyMembers.add(newMember);
                  } else {
                    familyMembers[index!] = newMember;
                  }
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text(member == null ? 'Add' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }

  // --- DELETE MEMBER ---
  void _deleteMember(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Member?'),
        content: Text(
          'Are you sure you want to delete ${familyMembers[index]['name']}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => familyMembers.removeAt(index));
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // --- UI ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        title: const Text('Dashboard',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        actions: [
          TextButton(
            onPressed: () => _addOrEditFamilyMember(),
            child: const Text(
              '+ Family Member',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserProfileCard(),
            const SizedBox(height: 20),
            _buildFamilySection(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 2),
    );
  }

  // --- USER PROFILE CARD ---
  Widget _buildUserProfileCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                userProfile['imageUrl']!,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProfile['name']!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${userProfile['age']} yrs • ${userProfile['city']} • ${userProfile['occupation']}',
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Gotra: ${userProfile['gotra']} | Rashi: ${userProfile['rashi']}',
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userProfile['bio']!,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _editUserProfile,
                        icon: const Icon(Icons.edit, size: 16),
                        label: const Text('Edit'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- FAMILY SECTION ---
  Widget _buildFamilySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Family Members',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: familyMembers
              .asMap()
              .entries
              .map((entry) => _buildFamilyCard(entry.value, entry.key))
              .toList(),
        ),
      ],
    );
  }

  // --- FAMILY CARD ---
  Widget _buildFamilyCard(Map<String, String> member, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.network(
                member['imageUrl']!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member['name']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '${member['relation']} • ${member['age']} yrs • ${member['occupation']}',
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  Text(
                    'Gotra: ${member['gotra']} | Rashi: ${member['rashi']}',
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _addOrEditFamilyMember(
                          member: member,
                          index: index,
                        ),
                        icon: const Icon(Icons.edit, color: Colors.deepPurple),
                      ),
                      IconButton(
                        onPressed: () => _deleteMember(index),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
    );
  }
}
