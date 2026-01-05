import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  // 🎨 Colors
  final Color primaryOrange = const Color(0xFFFF7A1A);
  final Color textDark = const Color(0xFF1F2937);
  final Color textGrey = const Color(0xFF6B7280);
  final Color fieldBg = const Color(0xFFF9FAFB);
  final Color borderColor = const Color(0xFFD1D5DB);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // 🔥 Input Decoration
  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: textGrey, fontSize: 14),
      filled: true,
      fillColor: fieldBg,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primaryOrange, width: 1.5),
      ),
    );
  }

  // 🏷️ Labeled TextField (USED EVERYWHERE)
  Widget labeledTextField({
    required String label,
    required String hint,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textDark,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: TextStyle(color: textDark),
          decoration: inputDecoration(hint).copyWith(
            suffixIcon: suffixIcon,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // 🔽 Dropdown Field
  Widget dropdownField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textDark,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          items: [
            DropdownMenuItem(
              value: value,
              child: Text(value, style: TextStyle(color: textDark)),
            ),
          ],
          onChanged: (_) {},
          decoration: inputDecoration(label),
          icon: Icon(Icons.keyboard_arrow_down, color: textGrey),
          dropdownColor: Colors.white,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // 🟧 Button
  Widget orangeButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onTap,
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

  // 🔰 Header
  Widget logoHeader({String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Image.asset(
            'assets/logo.png',
            height: 60,
          ),
        ),
        const SizedBox(height: 24),
        RichText(
          text: TextSpan(
            text: 'Welcome ',
            style: TextStyle(
              color: textDark,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'Community',
                style: TextStyle(color: primaryOrange),
              ),
            ],
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(subtitle, style: TextStyle(color: textGrey)),
        ],
        const SizedBox(height: 24),
      ],
    );
  }

  // 📱 Responsive Wrapper
  Widget pageWrapper(Widget child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }

  // 📄 PAGE 1
  Widget pageBasicDetails() {
    return pageWrapper(
      Column(
        children: [
          logoHeader(subtitle: 'Please enter your sign up details.'),
          labeledTextField(label: 'Name', hint: 'Enter Name'),
          labeledTextField(
            label: 'Mobile Number',
            hint: 'Enter Mobile Number',
            keyboardType: TextInputType.phone,
          ),
          labeledTextField(
            label: 'Email',
            hint: 'thisand@that.com',
            keyboardType: TextInputType.emailAddress,
          ),
          dropdownField('Gender', 'Male'),
          dropdownField('Marital Status', 'Single'),
          orangeButton('Save and Continue', () {
            currentPage = 1;
            nextPage();
          }),
        ],
      ),
    );
  }

  // 📄 PAGE 2
  Widget pageCommunityDetails() {
    return pageWrapper(
      Column(
        children: [
          logoHeader(subtitle: 'Please enter your sign up details.'),
          dropdownField('Religion', 'Hindu'),
          dropdownField('Caste', 'XYZ'),
          dropdownField('Sub Caste', 'XYZ'),
          dropdownField('Family Status', 'Joint'),
          dropdownField('Family Type', 'Select'),
          orangeButton('Save and Continue', () {
            currentPage = 2;
            nextPage();
          }),
        ],
      ),
    );
  }

  // 📄 PAGE 3
  Widget pageSetPassword() {
    return pageWrapper(
      Column(
        children: [
          logoHeader(
            subtitle:
                'Setting your initial password is key for security; choose wisely.',
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: primaryOrange),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text(
                  'Set a Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 16),
                labeledTextField(
                  label: 'New Password',
                  hint: 'Enter New Password',
                  obscureText: true,
                  suffixIcon:
                      Icon(Icons.visibility_off, color: textGrey),
                ),
                labeledTextField(
                  label: 'Confirm Password',
                  hint: 'Enter New Password',
                  obscureText: true,
                  suffixIcon:
                      Icon(Icons.visibility_off, color: textGrey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          orangeButton('Set Password', () {
            currentPage = 3;
            nextPage();
          }),
        ],
      ),
    );
  }

  // 📄 PAGE 4
 Widget pageOTP() {
  return pageWrapper(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            text: 'Enter ',
            style: TextStyle(
              color: textDark,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'OTP',
                style: TextStyle(color: primaryOrange),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Please enter the 4 digit OTP Code sent on\n+91826********',
          style: TextStyle(color: textGrey),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            4,
            (_) => SizedBox(
              width: 60,
              child: TextField(
                maxLength: 1,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration:
                    inputDecoration('').copyWith(counterText: ''),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        orangeButton('NEXT', () {
          Navigator.pushReplacementNamed(context, '/home');
        }),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            pageBasicDetails(),
            pageCommunityDetails(),
            pageSetPassword(),
            pageOTP(),
          ],
        ),
      ),
    );
  }
}
