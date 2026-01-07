import 'package:flutter/material.dart';

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


const Color primaryOrange = Color(0xFFFF7A1A);
const Color textDark = Color(0xFF1F2937);
const Color textGrey = Color(0xFF6B7280);
const Color fieldBg = Color(0xFFF9FAFB);
const Color borderColor = Color(0xFFD1D5DB);

InputDecoration inputDecoration(String hint, {Widget? suffix}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: textGrey, fontSize: 14),
    filled: true,
    fillColor: fieldBg,
    suffixIcon: suffix,
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: borderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: primaryOrange, width: 1.5),
    ),
  );
}

Widget labeledField({
  required String label,
  required Widget field,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textDark,
          ),
        ),
        const SizedBox(height: 6),
        field,
      ],
    ),
  );
}

Widget orangeButton(String text, VoidCallback onTap) {
  return SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Basic Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 24),

              labeledField(
                label: "Full Name",
                field: TextField(
                  decoration: inputDecoration("Shoaib Chaudhary"),
                ),
              ),

              labeledField(
                label: "Date of Birth",
                field: TextField(
                  readOnly: true,
                  decoration: inputDecoration(
                    dob == null
                        ? "Choose Date"
                        : "${dob!.day}/${dob!.month}/${dob!.year}",
                    suffix: const Icon(Icons.calendar_month,
                        color: textGrey),
                  ),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1970),
                      lastDate: DateTime.now(),
                      initialDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() => dob = picked);
                    }
                  },
                ),
              ),

              dropdownField(
                label: "Religion",
                value: religion,
                items: const ["Hindu", "Muslim", "Christian"],
                onChanged: (v) => setState(() => religion = v),
              ),

              dropdownField(
                label: "Caste",
                value: caste,
                items: const ["General", "OBC", "SC", "ST"],
                onChanged: (v) => setState(() => caste = v),
              ),

              dropdownField(
                label: "Family Status",
                value: familyStatus,
                items: const ["Middle Class", "Upper Middle", "Rich"],
                onChanged: (v) => setState(() => familyStatus = v),
              ),

              dropdownField(
                label: "Hobbies",
                value: hobbies,
                items: const ["Music", "Sports", "Reading"],
                onChanged: (v) => setState(() => hobbies = v),
              ),

              dropdownField(
                label: "Sub Caste",
                value: subCaste,
                items: const ["Sub 1", "Sub 2"],
                onChanged: (v) => setState(() => subCaste = v),
              ),

              const SizedBox(height: 32),

              orangeButton("Continue", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfessionalDetailsPage(),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}


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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Professional Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: textDark,
                ),
              ),
              const SizedBox(height: 24),

              labeledField(
                label: "Education",
                field: TextField(
                  decoration: inputDecoration("MCA"),
                ),
              ),

              dropdownField(
                label: "Employed In",
                value: employedIn,
                items: const ["Private", "Government", "Business"],
                onChanged: (v) => setState(() => employedIn = v),
              ),

              labeledField(
                label: "Occupation",
                field: TextField(
                  decoration: inputDecoration("Occupation"),
                ),
              ),

              labeledField(
                label: "Annual Income (Rs.)",
                field: TextField(
                  decoration: inputDecoration("Annual Income"),
                  keyboardType: TextInputType.number,
                ),
              ),

              dropdownField(
                label: "Work Location",
                value: workLocation,
                items: const ["Delhi", "Mumbai", "Pune"],
                onChanged: (v) => setState(() => workLocation = v),
              ),

              dropdownField(
                label: "State",
                value: state,
                items: const ["Delhi", "Maharashtra"],
                onChanged: (v) => setState(() => state = v),
              ),

              const SizedBox(height: 32),

              orangeButton("Continue", () {}),
            ],
          ),
        ),
      ),
    );
  }
}


Widget dropdownField({
  required String label,
  required List<String> items,
  String? value,
  required ValueChanged<String?> onChanged,
}) {
  return labeledField(
    label: label,
    field: DropdownButtonFormField<String>(
      value: value,
      decoration: inputDecoration("Select"),
      icon: const Icon(Icons.keyboard_arrow_down, color: textGrey),
      items: items
          .map(
            (e) => DropdownMenuItem(
              value: e,
              child: Text(e, style: const TextStyle(color: textDark)),
            ),
          )
          .toList(),
      onChanged: onChanged,
    ),
  );
}
