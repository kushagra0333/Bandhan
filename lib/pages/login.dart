import 'package:flutter/material.dart';

enum LoginStep { login, confirmPhone, otp }

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginStep step = LoginStep.login;

  // COLORS
  static const Color orange = Color(0xFFF47C20);
  static const Color lightGrey = Color(0xFF9E9E9E);
  static const Color borderColor = Color(0xFFE0E0E0);

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final otpCtrls = List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    for (final c in otpCtrls) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: h - 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                _logo(),
                const SizedBox(height: 24),
                _header(),
                const SizedBox(height: 28),
                _content(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- LOGO ----------------
  Widget _logo() {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Image.asset(
        "assets/logo.png",
        height: 64,
        width: 64,
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _header() {
    if (step == LoginStep.otp) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text.rich(
            TextSpan(
              text: "Enter ",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: "OTP",
                  style: TextStyle(color: orange),
                ),
              ],
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Please enter the 4 digit OTP Code sent\non your phone number.",
            style: TextStyle(fontSize: 14, color: lightGrey, height: 1.4),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text.rich(
          TextSpan(
            text: "Welcome ",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: "Community",
                style: TextStyle(color: orange),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Text(
          "Please enter your sign in details.",
          style: TextStyle(fontSize: 14, color: lightGrey),
        ),
      ],
    );
  }

  // ---------------- CONTENT SWITCH ----------------
  Widget _content() {
    switch (step) {
      case LoginStep.login:
        return _loginForm();
      case LoginStep.confirmPhone:
        return _confirmPhone();
      case LoginStep.otp:
        return _otpForm();
    }
  }

  // ---------------- LOGIN FORM ----------------
  Widget _loginForm() {
    return Column(
      children: [
        _field("Email / Phone Number", "Enter Email/Phone Number", emailCtrl),
        const SizedBox(height: 18),
        _field("Password", "Password", passCtrl, obscure: true),
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 32),
        _terms(),
        const SizedBox(height: 16),
        _button("Sign In", () {
          setState(() => step = LoginStep.confirmPhone);
        }),
      ],
    );
  }

  // ---------------- CONFIRM PHONE ----------------
  Widget _confirmPhone() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          decoration: BoxDecoration(
            border: Border.all(color: orange, width: 1.4),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              const Text(
                "Sign In with phone number",
                style: TextStyle(fontSize: 15, color: lightGrey),
              ),
              const SizedBox(height: 14),
              const Text(
                "(+91) 65485 8XX98",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () =>
                          setState(() => step = LoginStep.login),
                      style: OutlinedButton.styleFrom(
                        side:
                            const BorderSide(color: orange, width: 1.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: orange,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          setState(() => step = LoginStep.otp),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------- OTP FORM (NAVIGATES TO /home) ----------------
  Widget _otpForm() {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (i) => _otpBox(i)),
        ),
        const SizedBox(height: 26),
        _button("NEXT", () {
          Navigator.pushReplacementNamed(context, '/home');
        }),
        const SizedBox(height: 14),
        const Text.rich(
          TextSpan(
            text: "Didn’t receive the code? ",
            style: TextStyle(fontSize: 14, color: Colors.black),
            children: [
              TextSpan(
                text: "Resend (30s)",
                style: TextStyle(color: orange),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _otpBox(int i) {
    return SizedBox(
      width: 58,
      height: 58,
      child: TextField(
        controller: otpCtrls[i],
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: orange, width: 2),
          ),
        ),
      ),
    );
  }

  // ---------------- COMMON WIDGETS ----------------
  Widget _field(
    String label,
    String hint,
    TextEditingController c, {
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: c,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: orange),
            ),
          ),
        ),
      ],
    );
  }

  Widget _button(String text, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: orange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
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

  Widget _terms() {
    return const Text.rich(
      TextSpan(
        text: "By clicking Sign In, you agree with our ",
        style: TextStyle(fontSize: 12, color: lightGrey),
        children: [
          TextSpan(
            text: "Terms and Conditions",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(text: " and "),
          TextSpan(
            text: "Privacy Policy",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
