import 'package:flutter/material.dart';

/// dashboard.dart
/// Light-themed dashboard with:
/// - Square rounded user image
/// - Editable user profile (dialog)
/// - Family grid with reduced padding and detailed cards
/// - Functional Edit + Delete (dialogs)
/// - Bottom navigation that routes to other pages (replace with your routes)
///
/// Paste into lib/pages/ or lib/ and import/navigate accordingly.

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 1;

  // Demo user info stored locally
  Map<String, String> userInfo = {
    'name': 'Kushagra Pandey',
    'email': 'kushagra@example.com',
    'phone': '+91 98765 43210',
    'gotra': 'Bharadwaj',
    'rashi': 'Leo',
    'city': 'Lucknow',
    'image': 'https://i.pravatar.cc/300?img=10', // square rounded image
  };

  // Demo family members
  List<Map<String, String>> familyMembers = [
    {
      'name': 'Aarav Pandey',
      'relation': 'Brother',
      'gotra': 'Kashyap',
      'rashi': 'Leo',
      'dob': '12 Jul 1998',
      'image': 'https://i.pravatar.cc/300?img=1',
    },
    {
      'name': 'Riya Pandey',
      'relation': 'Sister',
      'gotra': 'Kashyap',
      'rashi': 'Virgo',
      'dob': '22 Sep 2000',
      'image': 'https://i.pravatar.cc/300?img=2',
    },
    {
      'name': 'Ananya Pandey',
      'relation': 'Cousin',
      'gotra': 'Kashyap',
      'rashi': 'Gemini',
      'dob': '03 Jun 2001',
      'image': 'https://i.pravatar.cc/300?img=3',
    },
  ];

  // Navigation tap handler: replace the named routes with your app routes
  void _onNavTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        // Home / Discovery
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        // Dashboard - already here
        break;
      case 2:
        // Likes / Notifications
        Navigator.pushReplacementNamed(context, '/likes');
        break;
      case 3:
        // Settings
        Navigator.pushReplacementNamed(context, '/settings');
        break;
    }
  }

  // ==========================
  // Helper UI pieces
  // ==========================

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            const Color(0xFFF7F9FF),
            const Color(0xFFEFF6FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  // Subtle "glass" card wrapper
  Widget _glassCard({required Widget child, EdgeInsetsGeometry? padding}) {
    return Container(
      padding: padding ?? const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.98),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.08)),
      ),
      child: child,
    );
  }

  // ==========================
  // Edit profile dialog (inline pop-up)
  // ==========================
  void _showEditProfileDialog() {
    final controllers = {
      'name': TextEditingController(text: userInfo['name']),
      'email': TextEditingController(text: userInfo['email']),
      'phone': TextEditingController(text: userInfo['phone']),
      'gotra': TextEditingController(text: userInfo['gotra']),
      'rashi': TextEditingController(text: userInfo['rashi']),
      'city': TextEditingController(text: userInfo['city']),
      'image': TextEditingController(text: userInfo['image']),
    };

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.78,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Edit Profile',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  ...controllers.entries.map((e) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextField(
                        controller: e.value,
                        decoration: InputDecoration(
                          labelText: _labelFromKey(e.key),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel')),
                      const SizedBox(width: 8),
                      ElevatedButton(
                          onPressed: () {
                            // save values
                            setState(() {
                              userInfo['name'] = controllers['name']!.text;
                              userInfo['email'] = controllers['email']!.text;
                              userInfo['phone'] = controllers['phone']!.text;
                              userInfo['gotra'] = controllers['gotra']!.text;
                              userInfo['rashi'] = controllers['rashi']!.text;
                              userInfo['city'] = controllers['city']!.text;
                              // optional: image URL
                              userInfo['image'] = controllers['image']!.text;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Save')),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _labelFromKey(String key) {
    switch (key) {
      case 'name':
        return 'Name';
      case 'email':
        return 'Email';
      case 'phone':
        return 'Phone';
      case 'gotra':
        return 'Gotra';
      case 'rashi':
        return 'Rashi';
      case 'city':
        return 'City';
      case 'image':
        return 'Image URL';
      default:
        return key;
    }
  }

  // ==========================
  // Add Family Member dialog
  // ==========================
  void _showAddFamilyDialog() {
    final name = TextEditingController();
    final relation = TextEditingController();
    final gotra = TextEditingController();
    final rashi = TextEditingController();
    final dob = TextEditingController();
    final image = TextEditingController(text: 'https://i.pravatar.cc/300?img=5');

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.78,
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Add Family Member',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    _buildField('Name', name),
                    _buildField('Relation', relation),
                    _buildField('Gotra', gotra),
                    _buildField('Rashi', rashi),
                    _buildField('DOB', dob),
                    _buildField('Image URL', image),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel')),
                        ElevatedButton(
                            onPressed: () {
                              if (name.text.trim().isEmpty ||
                                  relation.text.trim().isEmpty) {
                                // simple validation
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please provide name & relation')));
                                return;
                              }
                              setState(() {
                                familyMembers.add({
                                  'name': name.text.trim(),
                                  'relation': relation.text.trim(),
                                  'gotra': gotra.text.trim(),
                                  'rashi': rashi.text.trim(),
                                  'dob': dob.text.trim(),
                                  'image': image.text.trim(),
                                });
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Add')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  // ==========================
  // Edit Family Member dialog
  // ==========================
  void _showEditFamilyDialog(int index) {
    final member = Map<String, String>.from(familyMembers[index]);
    final controllers = {
      'name': TextEditingController(text: member['name']),
      'relation': TextEditingController(text: member['relation']),
      'gotra': TextEditingController(text: member['gotra']),
      'rashi': TextEditingController(text: member['rashi']),
      'dob': TextEditingController(text: member['dob']),
      'image': TextEditingController(text: member['image']),
    };

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.78,
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Edit Family Member',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    _buildField('Name', controllers['name']!),
                    _buildField('Relation', controllers['relation']!),
                    _buildField('Gotra', controllers['gotra']!),
                    _buildField('Rashi', controllers['rashi']!),
                    _buildField('DOB', controllers['dob']!),
                    _buildField('Image URL', controllers['image']!),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel')),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                familyMembers[index] = {
                                  'name': controllers['name']!.text.trim(),
                                  'relation':
                                      controllers['relation']!.text.trim(),
                                  'gotra': controllers['gotra']!.text.trim(),
                                  'rashi': controllers['rashi']!.text.trim(),
                                  'dob': controllers['dob']!.text.trim(),
                                  'image': controllers['image']!.text.trim(),
                                };
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Save')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ==========================
  // Delete confirmation
  // ==========================
  void _confirmDeleteFamily(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Member'),
          content: Text(
              'Are you sure you want to remove ${familyMembers[index]['name']} from family?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: const Text('No')),
            TextButton(
                onPressed: () {
                  setState(() => familyMembers.removeAt(index));
                  Navigator.pop(context);
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.red),
                )),
          ],
        );
      },
    );
  }

  // ==========================
  // Build UI
  // ==========================
  @override
  Widget build(BuildContext context) {
    // Responsive widths
    final width = MediaQuery.of(context).size.width;
    final isLarge = width > 600;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          _buildBackground(),
          // Gentle top-left and bottom-right accents
          Positioned(
            left: -80,
            top: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  const Color(0xFFEEF2FF).withOpacity(0.9),
                  const Color(0xFFEEF2FF).withOpacity(0.3),
                ]),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -60,
            bottom: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                gradient: RadialGradient(colors: [
                  const Color(0xFFFFF0F6).withOpacity(0.9),
                  const Color(0xFFFFF0F6).withOpacity(0.3),
                ]),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
              // Using LayoutBuilder to tune heights and sizes based on available height
              final maxHeight = constraints.maxHeight;
              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Title + Add Family Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Dashboard',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF102A43)),
                        ),
                        ElevatedButton.icon(
                          onPressed: _showAddFamilyDialog,
                          icon: const Icon(Icons.add),
                          label: const Text('Add Family'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6C63FF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 6,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 14),

                    // User header card
                    _glassCard(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          // User image: square with cyclic (rounded) corners
                          Container(
                            width: isLarge ? 120 : 88,
                            height: isLarge ? 120 : 88,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.18),
                                    blurRadius: 12,
                                    offset: const Offset(0, 8)),
                              ],
                              border:
                                  Border.all(color: Colors.grey.withOpacity(0.12)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                userInfo['image'] ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, err, st) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.person,
                                        size: 48, color: Colors.grey),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          // Info
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(userInfo['name'] ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF102A43))),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          size: 14, color: Colors.grey.shade600),
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(userInfo['city'] ?? '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.grey.shade700)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 6,
                                    children: [
                                      _infoPill('Gotra', userInfo['gotra'] ?? ''),
                                      _infoPill('Rashi', userInfo['rashi'] ?? ''),
                                      _infoPill('Phone', userInfo['phone'] ?? ''),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: _showEditProfileDialog,
                                        icon: const Icon(Icons.edit, size: 16),
                                        label: const Text('Edit Profile'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF6C63FF),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton.icon(
                                        onPressed: () {
                                          _showProfilePreview();
                                        },
                                        icon: const Icon(Icons.visibility,
                                            size: 16, color: Colors.black54),
                                        label: const Text(
                                          'Preview',
                                          style: TextStyle(color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Family section title
                    const Padding(
                      padding: EdgeInsets.only(left: 6.0, bottom: 6.0),
                      child: Text('Family Members',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF102A43))),
                    ),

                    // Family grid with reduced padding and detailed cards
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: familyMembers.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isLarge ? 3 : 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: isLarge ? 0.78 : 0.68,
                      ),
                      itemBuilder: (context, index) {
                        final mem = familyMembers[index];
                        return _buildFamilyCard(mem, index);
                      },
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              );
            }),
          ),
        ],
      ),

      // Floating / soft bottom navigation
      bottomNavigationBar: Container(
        height: 78,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white, // Changed to solid white background
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 14,
                offset: const Offset(0, 8))
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.06)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(icon: Icons.home, label: 'Home', index: 0),
            _navItem(icon: Icons.dashboard, label: 'Dashboard', index: 1),
            _navItem(icon: Icons.favorite, label: 'Likes', index: 2),
            _navItem(icon: Icons.settings, label: 'Settings', index: 3),
          ],
        ),
      ),
    );
  }

  // ==========================
  // Family card
  // ==========================
  Widget _buildFamilyCard(Map<String, String> mem, int index) {
    return GestureDetector(
      onTap: () {
        // detail preview
        showDialog(
            context: context,
            builder: (ctx) {
              return Dialog(
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(ctx).size.height * 0.78,
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(mem['image'] ?? '',
                                height: 140, width: double.infinity, fit: BoxFit.cover,
                                errorBuilder: (c, e, s) {
                              return Container(
                                height: 140,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.person, size: 56),
                              );
                            }),
                          ),
                          const SizedBox(height: 10),
                          Text(mem['name'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.black)),
                          const SizedBox(height: 6),
                          Text(mem['relation'] ?? '',
                              style: TextStyle(color: Colors.grey.shade700)),
                          const SizedBox(height: 8),
                          Text('Gotra: ${mem['gotra'] ?? ''}',
                              style: TextStyle(color: Colors.grey.shade600)),
                          Text('Rashi: ${mem['rashi'] ?? ''}',
                              style: TextStyle(color: Colors.grey.shade600)),
                          Text('DOB: ${mem['dob'] ?? ''}',
                              style: TextStyle(color: Colors.grey.shade600)),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                    _showEditFamilyDialog(index);
                                  },
                                  child: const Text('Edit')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                    _confirmDeleteFamily(index);
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      },
      child: Container(
        margin: EdgeInsets.zero, // reduced outer padding as requested
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 6))
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // image: rounded rectangle (not circle)
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14), topRight: Radius.circular(14)),
              child: Image.network(
                mem['image'] ?? '',
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.person, size: 44, color: Colors.grey),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mem['name'] ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black)),
                  const SizedBox(height: 4),
                  Text(mem['relation'] ?? '',
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                  const SizedBox(height: 6),
                  Text('Gotra: ${mem['gotra'] ?? ''}',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  Text('Rashi: ${mem['rashi'] ?? ''}',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  Text('DOB: ${mem['dob'] ?? ''}',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        splashRadius: 20,
                        onPressed: () => _showEditFamilyDialog(index),
                        icon: const Icon(Icons.edit, size: 18),
                        color: Colors.blueGrey,
                      ),
                      IconButton(
                        splashRadius: 20,
                        onPressed: () => _confirmDeleteFamily(index),
                        icon: const Icon(Icons.delete_outline, size: 18),
                        color: Colors.redAccent,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // small labeled pill used in user card
  Widget _infoPill(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$label: ',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
          Text(value, style: const TextStyle(fontSize: 12, color: Colors.black87)),
        ],
      ),
    );
  }

  // nav item widget
  Widget _navItem({required IconData icon, required String label, required int index}) {
    final selected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onNavTapped(index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF6C63FF).withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: selected ? const Color(0xFF6C63FF) : Colors.grey.shade700),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 12, color: selected ? const Color(0xFF6C63FF) : Colors.grey.shade700)),
          ],
        ),
      ),
    );
  }

  // ==========================
  // Profile preview (light background + show user image)
  // ==========================
  void _showProfilePreview() {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(ctx).size.height * 0.7,
              maxWidth: MediaQuery.of(ctx).size.width * 0.9,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    // image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(userInfo['image'] ?? '',
                          height: 160, width: double.infinity, fit: BoxFit.cover,
                          errorBuilder: (c, e, s) {
                        return Container(
                          height: 160,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.person, size: 64),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),
                    Text(userInfo['name'] ?? '',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                    const SizedBox(height: 8),
                    Text('${userInfo['city'] ?? ''} • Gotra: ${userInfo['gotra'] ?? ''}',
                        style: TextStyle(color: Colors.grey.shade700)),
                    const SizedBox(height: 8),
                    Text('Rashi: ${userInfo['rashi'] ?? ''}',
                        style: TextStyle(color: Colors.grey.shade700)),
                    const SizedBox(height: 12),
                    // other details
                    Row(
                      children: [
                        const Icon(Icons.email, size: 18, color: Colors.black54),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(userInfo['email'] ?? '',
                              style: const TextStyle(color: Colors.black87)),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.phone, size: 18, color: Colors.black54),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(userInfo['phone'] ?? '',
                              style: const TextStyle(color: Colors.black87)),
                        )
                      ],
                    ),
                    const SizedBox(height: 14),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Close')),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}