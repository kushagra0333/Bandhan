import 'package:flutter/material.dart';

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
          controller: c,
          obscureText: obscure,
          style: TextStyle(color: textDark),
          decoration: inputDecoration(hint).copyWith(
            suffixIcon: suffix,
          ),
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

  Widget header() {
    if (step == LoginStep.otp) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            'Please enter the 4 digit OTP Code sent\non your phone number.',
            style: TextStyle(color: textGrey),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const SizedBox(height: 6),
        Text(
          'Please enter your sign in details.',
          style: TextStyle(color: textGrey),
        ),
      ],
    );
  }

  // 📄 CONTENT SWITCH
  Widget content() {
    switch (step) {
      case LoginStep.login:
        return loginForm();
      case LoginStep.confirmPhone:
        return confirmPhone();
      case LoginStep.otp:
        return otpForm();
    }
  }

  Widget loginForm() {
    return Column(
      children: [
        labeledField(
          'Email / Phone Number',
          'Enter Email/Phone Number',
          emailCtrl,
        ),
        labeledField(
          'Password',
          'Password',
          passCtrl,
          obscure: obscurePassword,
          suffix: IconButton(
            icon: Icon(
              obscurePassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: textGrey,
            ),
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
              });
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              color: primaryOrange,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 24),
        terms(),
        const SizedBox(height: 16),
        orangeButton('Sign In', () {
          setState(() => step = LoginStep.confirmPhone);
        }),
      ],
    );
  }

  Widget confirmPhone() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: primaryOrange),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            'Sign In with phone number',
            style: TextStyle(color: textGrey),
          ),
          const SizedBox(height: 12),
          Text(
            '(+91) 65485 8XX98',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
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
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: primaryOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: orangeButton('Next', () {
                  setState(() => step = LoginStep.otp);
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget otpForm() {
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
        orangeButton('NEXT', () {
          Navigator.pushReplacementNamed(context, '/home');
        }),
        const SizedBox(height: 14),
        Text.rich(
          TextSpan(
            text: 'Didn’t receive the code? ',
            style: TextStyle(color: textDark),
            children: [
              TextSpan(
                text: 'Resend (30s)',
                style: TextStyle(color: primaryOrange),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget terms() {
    return Text.rich(
      TextSpan(
        text: 'By clicking Sign In, you agree with our ',
        style: TextStyle(fontSize: 12, color: textGrey),
        children: const [
          TextSpan(
            text: 'Terms and Conditions',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

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
              Image.asset('assets/logo.png', height: 60),
              const SizedBox(height: 24),
              header(),
              const SizedBox(height: 28),
              content(),
            ],
          ),
        ),
      ),
    );
  }
}
