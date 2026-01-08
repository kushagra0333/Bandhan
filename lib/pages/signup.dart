import 'package:flutter/material.dart';
import '../components/language_controller.dart';
import '../components/language_toggle_button.dart';
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
    if (currentPage < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

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
        Text(label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textDark)),
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

  Widget dropdownField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: textDark)),
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
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget orangeButton(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        onPressed: onTap,
        child: Text(text,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
    );
  }

  Widget logoHeader(bool en, {String? subtitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Image.asset('assets/logo.png', height: 60),
        const SizedBox(height: 24),
        Text(
          en ? 'Welcome Community' : 'समुदाय में आपका स्वागत है',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: textDark),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(subtitle, style: TextStyle(color: textGrey)),
        ],
        const SizedBox(height: 24),
      ],
    );
  }

  Widget pageWrapper(Widget child) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: child,
    );
  }

  // PAGE 1
  Widget pageBasicDetails(bool en) {
    return pageWrapper(
      Column(
        children: [
          logoHeader(
            en,
            subtitle: en
                ? 'Please enter your sign up details.'
                : 'कृपया अपनी साइन अप जानकारी दर्ज करें।',
          ),
          labeledTextField(
              label: en ? 'Name' : 'नाम',
              hint: en ? 'Enter Name' : 'नाम दर्ज करें'),
          labeledTextField(
              label: en ? 'Mobile Number' : 'मोबाइल नंबर',
              hint: en ? 'Enter Mobile Number' : 'मोबाइल नंबर दर्ज करें',
              keyboardType: TextInputType.phone),
          labeledTextField(
              label: en ? 'Email' : 'ईमेल',
              hint: 'thisand@that.com',
              keyboardType: TextInputType.emailAddress),
          dropdownField(en ? 'Gender' : 'लिंग', en ? 'Male' : 'पुरुष'),
          dropdownField(
              en ? 'Marital Status' : 'वैवाहिक स्थिति',
              en ? 'Single' : 'अविवाहित'),
          orangeButton(
              en ? 'Save and Continue' : 'सेव करें और आगे बढ़ें', () {
            currentPage = 1;
            nextPage();
          }),
        ],
      ),
    );
  }

  // PAGE 2
  Widget pageCommunityDetails(bool en) {
    return pageWrapper(
      Column(
        children: [
          logoHeader(
            en,
            subtitle: en
                ? 'Please enter your sign up details.'
                : 'कृपया अपनी साइन अप जानकारी दर्ज करें।',
          ),
          dropdownField(en ? 'Religion' : 'धर्म', 'Hindu'),
          dropdownField(en ? 'Caste' : 'जाति', 'XYZ'),
          dropdownField(en ? 'Sub Caste' : 'उप जाति', 'XYZ'),
          dropdownField(en ? 'Family Status' : 'परिवार की स्थिति',
              en ? 'Joint' : 'संयुक्त'),
          dropdownField(en ? 'Family Type' : 'परिवार का प्रकार', 'Select'),
          orangeButton(
              en ? 'Save and Continue' : 'सेव करें और आगे बढ़ें', () {
            currentPage = 2;
            nextPage();
          }),
        ],
      ),
    );
  }

  // PAGE 3
  Widget pageSetPassword(bool en) {
    return pageWrapper(
      Column(
        children: [
          logoHeader(
            en,
            subtitle: en
                ? 'Setting your initial password is key for security.'
                : 'सुरक्षा के लिए पासवर्ड सेट करना आवश्यक है।',
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: primaryOrange),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text(en ? 'Set a Password' : 'पासवर्ड सेट करें',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textDark)),
                const SizedBox(height: 16),
                labeledTextField(
                    label: en ? 'New Password' : 'नया पासवर्ड',
                    hint:
                        en ? 'Enter New Password' : 'नया पासवर्ड दर्ज करें',
                    obscureText: true),
                labeledTextField(
                    label: en ? 'Confirm Password' : 'पासवर्ड की पुष्टि करें',
                    hint:
                        en ? 'Confirm Password' : 'पासवर्ड पुनः दर्ज करें',
                    obscureText: true),
              ],
            ),
          ),
          const SizedBox(height: 24),
          orangeButton(en ? 'Set Password' : 'पासवर्ड सेट करें', () {
            currentPage = 3;
            nextPage();
          }),
        ],
      ),
    );
  }

  // PAGE 4
  Widget pageOTP(bool en) {
    return pageWrapper(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(en ? 'Enter OTP' : 'ओटीपी दर्ज करें',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: textDark)),
          const SizedBox(height: 8),
          Text(
            en
                ? 'Please enter the 4 digit OTP sent on your number.'
                : 'आपके नंबर पर भेजा गया 4 अंकों का ओटीपी दर्ज करें।',
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
          orangeButton(en ? 'NEXT' : 'आगे', () {
            Navigator.pushReplacementNamed(context, '/home');
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: languageController,
      builder: (context, en, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            actions: const [
  LanguageToggleButton(),
],

          ),
          body: SafeArea(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                pageBasicDetails(en),
                pageCommunityDetails(en),
                pageSetPassword(en),
                pageOTP(en),
              ],
            ),
          ),
        );
      },
    );
  }
}
