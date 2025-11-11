import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class FamilyMembersPage extends StatefulWidget {
  final List<Map<String, String>> familyMembers;

  const FamilyMembersPage({super.key, required this.familyMembers});

  @override
  State<FamilyMembersPage> createState() => _FamilyMembersPageState();
}

class _FamilyMembersPageState extends State<FamilyMembersPage> {
  final ImagePicker _picker = ImagePicker();
  late List<Map<String, String>> members;

  @override
  void initState() {
    super.initState();
    members = List.from(widget.familyMembers);
  }

  // --- Add New Member ---
  Future<void> _addMember() async {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController relationCtrl = TextEditingController();
    TextEditingController ageCtrl = TextEditingController();
    TextEditingController occupationCtrl = TextEditingController();
    TextEditingController gotraCtrl = TextEditingController();
    TextEditingController rashiCtrl = TextEditingController();
    XFile? pickedImage;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add Family Member'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    pickedImage = await _picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 75,
                    );
                    setDialogState(() {});
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: pickedImage != null
                        ? FileImage(File(pickedImage!.path))
                        : const NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/149/149071.png')
                            as ImageProvider,
                    child: pickedImage == null
                        ? const Icon(Icons.add_a_photo, color: Colors.white70)
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
                TextField(controller: relationCtrl, decoration: const InputDecoration(labelText: 'Relation')),
                TextField(controller: ageCtrl, decoration: const InputDecoration(labelText: 'Age')),
                TextField(controller: occupationCtrl, decoration: const InputDecoration(labelText: 'Occupation')),
                TextField(controller: gotraCtrl, decoration: const InputDecoration(labelText: 'Gotra')),
                TextField(controller: rashiCtrl, decoration: const InputDecoration(labelText: 'Rashi')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (nameCtrl.text.isNotEmpty && pickedImage != null) {
                  setState(() {
                    members.add({
                      'name': nameCtrl.text,
                      'relation': relationCtrl.text,
                      'age': ageCtrl.text,
                      'occupation': occupationCtrl.text,
                      'gotra': gotraCtrl.text,
                      'rashi': rashiCtrl.text,
                      'imageUrl': pickedImage!.path,
                    });
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  // --- Delete Member ---
  void _deleteMember(int index) {
    setState(() {
      members.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background for full page
      appBar: AppBar(
        title: const Text('All Family Members'),
        backgroundColor: Colors.deepPurple,
      ),
      body: members.isEmpty
          ? const Center(
              child: Text(
                'No family members added yet.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return Card(
                  color: Colors.white,
                  elevation: 4,
                  shadowColor: Colors.deepPurple.withOpacity(0.2),
                  margin: const EdgeInsets.only(bottom: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 38,
                          backgroundImage: member['imageUrl']!.startsWith('http')
                              ? NetworkImage(member['imageUrl']!)
                              : FileImage(File(member['imageUrl']!)) as ImageProvider,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member['name'] ?? 'Unknown',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text("Relation: ${member['relation'] ?? '-'}",
                                  style: const TextStyle(color: Colors.black54)),
                              Text("Age: ${member['age'] ?? '-'}",
                                  style: const TextStyle(color: Colors.black54)),
                              Text("Occupation: ${member['occupation'] ?? '-'}",
                                  style: const TextStyle(color: Colors.black54)),
                              Text("Gotra: ${member['gotra'] ?? '-'}",
                                  style: const TextStyle(color: Colors.black54)),
                              Text("Rashi: ${member['rashi'] ?? '-'}",
                                  style: const TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _deleteMember(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMember,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
