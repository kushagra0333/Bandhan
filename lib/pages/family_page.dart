import 'package:flutter/material.dart';

class FamilyDetailsScreen extends StatelessWidget {
  const FamilyDetailsScreen({Key? key}) : super(key: key);

  static const Color primaryOrange = Color(0xFFFF7A1A);
  static const Color textDark = Color(0xFF1F2937);
  static const Color textGrey = Color(0xFF6B7280);
  static const Color fieldBg = Color(0xFFF9FAFB);
  static const Color borderColor = Color(0xFFD1D5DB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        titleSpacing: 0,
        iconTheme: const IconThemeData(color: textDark),
        title: const Text(
          'Family Details',
          style: TextStyle(
            color: textDark,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      labeledField(
                        label: 'Name',
                        field: TextField(
                          decoration: inputDecoration('MCA'),
                        ),
                      ),

                      labeledField(
                        label: 'Relation',
                        field: DropdownButtonFormField<String>(
                          value: null,
                          dropdownColor: Colors.white, // ✅ FIX
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: textGrey,
                          ),
                          decoration: inputDecoration('Select'),
                          style: const TextStyle(
                            color: textDark,
                            fontSize: 14,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'Father',
                              child: Text(
                                'Father',
                                style: TextStyle(color: textDark),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Mother',
                              child: Text(
                                'Mother',
                                style: TextStyle(color: textDark),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Brother',
                              child: Text(
                                'Brother',
                                style: TextStyle(color: textDark),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Sister',
                              child: Text(
                                'Sister',
                                style: TextStyle(color: textDark),
                              ),
                            ),
                          ],
                          onChanged: (value) {},
                        ),
                      ),

                      labeledField(
                        label: 'Age',
                        field: TextField(
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration(''),
                        ),
                      ),

                      labeledField(
                        label: 'Profession',
                        field: TextField(
                          decoration: inputDecoration(''),
                        ),
                      ),

                      labeledField(
                        label: 'Phone Number',
                        field: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: inputDecoration(''),
                        ),
                      ),

                      labeledField(
                        label: 'E-mail',
                        field: TextField(
                          decoration: inputDecoration('Delhi'),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: textDark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Add More',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
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

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ---------------- SHARED UI (SIGNUP STYLE) ---------------- */

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
            color: FamilyDetailsScreen.textDark,
          ),
        ),
        const SizedBox(height: 6),
        field,
      ],
    ),
  );
}

InputDecoration inputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(
      color: FamilyDetailsScreen.textGrey,
      fontSize: 14,
    ),
    filled: true,
    fillColor: FamilyDetailsScreen.fieldBg,
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide:
          const BorderSide(color: FamilyDetailsScreen.borderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide:
          const BorderSide(color: FamilyDetailsScreen.borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: FamilyDetailsScreen.primaryOrange,
        width: 1.5,
      ),
    ),
  );
}
