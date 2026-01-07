import 'package:flutter/material.dart';

class FamilyDetailsScreen extends StatelessWidget {
  const FamilyDetailsScreen({Key? key}) : super(key: key);

  static const Color borderGrey = Color(0xFFBDBDBD);
  static const Color primaryOrange = Color(0xFFFF7A1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: const Text(
          'Family Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        )
    ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      _label('Name'),
                      _textField(hint: 'MCA'),

                      const SizedBox(height: 12),

                      _label('Relation'),
                      _dropdown(),

                      const SizedBox(height: 12),

                      _label('Age'),
                      _textField(keyboardType: TextInputType.number),

                      const SizedBox(height: 12),

                      _label('Profession'),
                      _textField(),

                      const SizedBox(height: 12),

                      _label('Phone Number'),
                      _textField(keyboardType: TextInputType.phone),

                      const SizedBox(height: 12),

                      _label('E-mail'),
                      _textField(hint: 'Delhi'),

                      const SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: const Text(
                              'Add More',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/dashboard');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Widgets ----------

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _textField({
    String? hint,
    TextInputType? keyboardType,
  }) {
    return TextField(
      keyboardType: keyboardType,
      cursorColor: primaryOrange, // 👈 Orange cursor
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      decoration: _inputDecoration(hint),
    );
  }

  Widget _dropdown() {
    return DropdownButtonFormField<String>(
      value: null,
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
      dropdownColor: Colors.white,
      hint: const Text(
        'Select',
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      items: const [
        DropdownMenuItem(value: 'Father', child: Text('Father')),
        DropdownMenuItem(value: 'Mother', child: Text('Mother')),
        DropdownMenuItem(value: 'Brother', child: Text('Brother')),
        DropdownMenuItem(value: 'Sister', child: Text('Sister')),
      ],
      onChanged: (value) {},
      decoration: _inputDecoration(null),
    );
  }

  InputDecoration _inputDecoration(String? hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Colors.black54,
        fontSize: 14,
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: borderGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: primaryOrange, // 👈 Orange border on focus
          width: 1.5,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
