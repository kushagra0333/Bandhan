import 'package:flutter/material.dart';

class SeeFamilyScreen extends StatelessWidget {
  const SeeFamilyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Family Members',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/add-member');
            },
            icon: const Icon(Icons.person_add, color: Color(0xFFE91E63)),
            label: const Text(
              'Add Member',
              style: TextStyle(
                color: Color(0xFFE91E63),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: const [
            FamilyMemberCard(
              name: 'Rajesh Kumar',
              relation: 'Father',
              age: '55',
              phone: '9876543210',
              profession: 'Retired Govt. Officer',
            ),
            FamilyMemberCard(
              name: 'Sunita Kumar',
              relation: 'Mother',
              age: '50',
              phone: '9876543222',
              profession: 'Teacher',
            ),
            FamilyMemberCard(
              name: 'Amit Kumar',
              relation: 'Brother',
              age: '25',
              phone: '9876543333',
              profession: 'Software Engineer',
            ),
          ],
        ),
      ),
    );
  }
}

// ================= FAMILY MEMBER CARD =================

class FamilyMemberCard extends StatelessWidget {
  final String name;
  final String relation;
  final String age;
  final String phone;
  final String profession;

  const FamilyMemberCard({
    Key? key,
    required this.name,
    required this.relation,
    required this.age,
    required this.phone,
    required this.profession,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + Relation
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  relation,
                  style: const TextStyle(
                    color: Color(0xFFE91E63),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Details
          _detailRow(Icons.cake, 'Age', age),
          const SizedBox(height: 6),
          _detailRow(Icons.work, 'Profession', profession),
          const SizedBox(height: 6),
          _detailRow(Icons.phone, 'Phone', phone),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: const Color(0xFFE91E63)),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
