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

class BasicDetailsPage extends StatefulWidget {
  const BasicDetailsPage({super.key});

  @override
  State<BasicDetailsPage> createState() => _BasicDetailsPageState();
}

class _BasicDetailsPageState extends State<BasicDetailsPage> {
  String? religion;
  String? caste;
  String? familyStatus;
  String? hobbies;
  String? subCaste;
  DateTime? dob;

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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),

              textField(label: "Full Name", hint: "Shoaib Chaudhary"),

              dateField(
                label: "Date of Birth",
                date: dob,
                onPicked: (value) => setState(() => dob = value),
              ),

              dropdown(
                label: "Religion",
                value: religion,
                items: const ["Hindu", "Muslim", "Christian"],
                onChanged: (v) => setState(() => religion = v),
              ),

              dropdown(
                label: "Caste",
                value: caste,
                items: const ["General", "OBC", "SC", "ST"],
                onChanged: (v) => setState(() => caste = v),
              ),

              dropdown(
                label: "Family Status",
                value: familyStatus,
                items: const ["Middle Class", "Upper Middle", "Rich"],
                onChanged: (v) => setState(() => familyStatus = v),
              ),

              dropdown(
                label: "Hobbies",
                value: hobbies,
                items: const ["Music", "Sports", "Reading"],
                onChanged: (v) => setState(() => hobbies = v),
              ),

              dropdown(
                label: "Sub Caste",
                value: subCaste,
                items: const ["Sub 1", "Sub 2"],
                onChanged: (v) => setState(() => subCaste = v),
              ),

              const SizedBox(height: 40),

              continueButton(
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

class ProfessionalDetailsPage extends StatefulWidget {
  const ProfessionalDetailsPage({super.key});

  @override
  State<ProfessionalDetailsPage> createState() =>
      _ProfessionalDetailsPageState();
}

class _ProfessionalDetailsPageState extends State<ProfessionalDetailsPage> {
  String? employedIn;
  String? workLocation;
  String? state;

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
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 24),

              textField(label: "Education", hint: "MCA"),
              dropdown(
                label: "Employed In",
                value: employedIn,
                items: const ["Private", "Government", "Business"],
                onChanged: (v) => setState(() => employedIn = v),
              ),
              textField(label: "Occupation"),
              textField(label: "Annual Income (Rs.)"),
              dropdown(
                label: "Work Location",
                value: workLocation,
                items: const ["Delhi", "Mumbai", "Pune"],
                onChanged: (v) => setState(() => workLocation = v),
              ),
              dropdown(
                label: "State",
                value: state,
                items: const ["Delhi", "Maharashtra"],
                onChanged: (v) => setState(() => state = v),
              ),

              const SizedBox(height: 40),

              continueButton(
                text: "Continue",
                onTap: () {},
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------- REUSABLE WIDGETS ---------------- */

Widget textField({required String label, String? hint}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 6),
        TextField(
          cursorColor: primaryOrange,
          decoration: inputDecoration(hint: hint),
        ),
      ],
    ),
  );
}

Widget dropdown({
  required String label,
  required List<String> items,
  String? value,
  required ValueChanged<String?> onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          decoration: inputDecoration(hint: "Select"),
          items: items
              .map(
                (e) => DropdownMenuItem(value: e, child: Text(e)),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    ),
  );
}

Widget dateField({
  required String label,
  DateTime? date,
  required ValueChanged<DateTime> onPicked,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 6),
        TextField(
          readOnly: true,
          decoration: inputDecoration(
            hint: date == null
                ? "Choose Date"
                : "${date.day}/${date.month}/${date.year}",
            suffixIcon: Icons.calendar_month,
          ),
          onTap: () async {
            final picked = await showDatePicker(
              context: navigatorKey.currentContext!,
              firstDate: DateTime(1970),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
            );
            if (picked != null) onPicked(picked);
          },
        ),
      ],
    ),
  );
}

Widget continueButton({
  required String text,
  required VoidCallback onTap,
}) {
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryOrange,
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

final navigatorKey = GlobalKey<NavigatorState>();

const Color primaryOrange = Color(0xFFF26A21);

const labelStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
);

InputDecoration inputDecoration({
  String? hint,
  IconData? suffixIcon,
}) {
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    suffixIcon:
        suffixIcon != null ? Icon(suffixIcon, color: Colors.grey) : null,
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: primaryOrange, width: 1.5),
    ),
  );
}
