import 'package:flutter/material.dart';
import '../components/language_controller.dart';
import '../components/language_toggle_button.dart';
enum LoginStep { login, confirmPhone, otp }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginStep step = LoginStep.login;

  final Color primaryOrange = const Color(0xFFFF7A1A);
  final Color textDark = const Color(0xFF1F2937);
  final Color textGrey = const Color(0xFF6B7280);
  final Color fieldBg = const Color(0xFFF9FAFB);
  final Color borderColor = const Color(0xFFD1D5DB);

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final otpCtrls = List.generate(4, (_) => TextEditingController());

  bool obscurePassword = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    for (final c in otpCtrls) {
      c.dispose();
    }
    super.dispose();
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

  Widget labeledField(
    String label,
    String hint,
    TextEditingController c, {
    bool obscure = false,
    Widget? suffix,
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
          controller: c,
          obscureText: obscure,
          style: TextStyle(color: textDark),
          decoration: inputDecoration(hint).copyWith(suffixIcon: suffix),
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
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(text,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ),
    );
  }

  Widget header(bool en) {
    if (step == LoginStep.otp) {
      return Column(
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
                ? 'Please enter the 4 digit OTP code sent\non your phone number.'
                : 'आपके फोन नंबर पर भेजा गया\n4 अंकों का ओटीपी दर्ज करें।',
            style: TextStyle(color: textGrey),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          en ? 'Welcome Community' : 'समुदाय में आपका स्वागत है',
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: textDark),
        ),
        const SizedBox(height: 6),
        Text(
          en
              ? 'Please enter your sign in details.'
              : 'कृपया अपनी साइन इन जानकारी दर्ज करें।',
          style: TextStyle(color: textGrey),
        ),
      ],
    );
  }

  Widget content(bool en) {
    switch (step) {
      case LoginStep.login:
        return loginForm(en);
      case LoginStep.confirmPhone:
        return confirmPhone(en);
      case LoginStep.otp:
        return otpForm(en);
    }
  }

  Widget loginForm(bool en) {
    return Column(
      children: [
        labeledField(
          en ? 'Email / Phone Number' : 'ईमेल / फोन नंबर',
          en ? 'Enter Email/Phone Number' : 'ईमेल / फोन नंबर दर्ज करें',
          emailCtrl,
        ),
        labeledField(
          en ? 'Password' : 'पासवर्ड',
          en ? 'Password' : 'पासवर्ड दर्ज करें',
          passCtrl,
          obscure: obscurePassword,
          suffix: IconButton(
            icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: textGrey),
            onPressed: () =>
                setState(() => obscurePassword = !obscurePassword),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            en ? 'Forgot Password?' : 'पासवर्ड भूल गए?',
            style: TextStyle(
                color: primaryOrange, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 24),
        terms(en),
        const SizedBox(height: 16),
        orangeButton(en ? 'Sign In' : 'साइन इन करें',
            () => setState(() => step = LoginStep.confirmPhone)),
      ],
    );
  }

  Widget confirmPhone(bool en) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: primaryOrange),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            en
                ? 'Sign in with phone number'
                : 'फोन नंबर से साइन इन करें',
            style: TextStyle(color: textGrey),
          ),
          const SizedBox(height: 12),
          Text(
            '(+91) 65485 8XX98',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textDark),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                      setState(() => step = LoginStep.login),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: primaryOrange),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(en ? 'Cancel' : 'रद्द करें',
                      style: TextStyle(
                          color: primaryOrange,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: orangeButton(
                    en ? 'Next' : 'आगे', () {
                  setState(() => step = LoginStep.otp);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget otpForm(bool en) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            4,
            (i) => SizedBox(
              width: 60,
              child: TextField(
                controller: otpCtrls[i],
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
        orangeButton(en ? 'NEXT' : 'आगे',
            () => Navigator.pushNamed(context, '/main-dashboard')),
        const SizedBox(height: 14),
        Text(
          en
              ? 'Didn’t receive the code? Resend (30s)'
              : 'कोड नहीं मिला? पुनः भेजें (30 सेकंड)',
          style: TextStyle(color: textDark),
        ),
      ],
    );
  }

  Widget terms(bool en) {
    return Text(
      en
          ? 'By clicking Sign In, you agree with our Terms and Privacy Policy'
          : 'साइन इन करने पर आप हमारी शर्तों और गोपनीयता नीति से सहमत होते हैं',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 12, color: textGrey),
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/logo.png', height: 60),
                const SizedBox(height: 24),
                header(en),
                const SizedBox(height: 28),
                content(en),
              ],
            ),
          ),
        );
      },
    );
  }
}
