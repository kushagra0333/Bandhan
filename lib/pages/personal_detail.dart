import 'package:flutter/material.dart';

void main() {
  runApp(const PersonalDetailApp());
}

class PersonalDetailApp extends StatelessWidget {
  const PersonalDetailApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BasicDetailsPage(),
    );
  }
}

/* ---------------- BASIC DETAILS SCREEN ---------------- */

class BasicDetailsPage extends StatelessWidget {
  const BasicDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              const Text(
                "Basic Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),

              _textField(
                label: "Full Name",
                hint: "Shoaib Chaudhary",
                icon: Icons.person,
              ),
              _dateField(label: "Date of Birth"),
              _dropdown(label: "Religion"),
              _dropdown(label: "Caste"),
              _dropdown(label: "Family Status"),
              _dropdown(label: "Hobbies"),
              _dropdown(label: "Sub Caste"),

              const SizedBox(height: 40),

              _continueButton(
                text: "Continue",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfessionalDetailsPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------- PROFESSIONAL DETAILS SCREEN ---------------- */

class ProfessionalDetailsPage extends StatelessWidget {
  const ProfessionalDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              const Text(
                "Professional Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),

              _textField(label: "Education", hint: "MCA"),
              _dropdown(label: "Employed In"),
              _textField(label: "Occupation"),
              _textField(label: "Annual Income (Rs.)"),
              _dropdown(label: "Work Location", hint: "Delhi"),
              _dropdown(label: "State", hint: "Delhi"),

              const SizedBox(height: 40),

              _continueButton(
                text: "Continue",
                onTap: () {
                    Navigator.pushReplacementNamed(context, '/dashboard')
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------- COMMON WIDGETS ---------------- */

Widget _textField({
  required String label,
  String? hint,
  IconData? icon,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _labelStyle),
        const SizedBox(height: 6),
        TextField(
          decoration: _inputDecoration(
            hint: hint,
            prefixIcon: icon,
          ),
        ),
      ],
    ),
  );
}

Widget _dropdown({
  required String label,
  String? hint,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _labelStyle),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          decoration: _inputDecoration(
            hint: hint ?? "Select",
          ),
          items: const [],
          onChanged: (value) {},
        ),
      ],
    ),
  );
}

Widget _dateField({required String label}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: _labelStyle),
        const SizedBox(height: 6),
        TextField(
          readOnly: true,
          decoration: _inputDecoration(
            hint: "Choose Date",
            suffixIcon: Icons.calendar_month,
          ),
        ),
      ],
    ),
  );
}

Widget _continueButton({
  required String text,
  required VoidCallback onTap,
}) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFF26A21),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
  );
}

/* ---------------- STYLES ---------------- */

const _labelStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

InputDecoration _inputDecoration({
  String? hint,
  IconData? prefixIcon,
  IconData? suffixIcon,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.grey),
    prefixIcon:
        prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
    suffixIcon:
        suffixIcon != null ? Icon(suffixIcon, color: Colors.grey) : null,
    filled: true,
    fillColor: Colors.white,
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color(0xFFF26A21)),
    ),
  );
}
