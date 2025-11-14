import 'package:flutter/material.dart';
import '../components/navbar.dart';
import './profile.dart';

class HomePage extends StatelessWidget {
  final Profile? profile;

  const HomePage({super.key, this.profile});

  /// RANDOM PROFILE GENERATOR
  Profile getRandomProfile() {
    return Profile(
      image: "assets/girl_profile.jpg",
      name: "Priya Sharma",
      age: "27",
      city: "Bangalore, Karnataka",
      job: "Product Manager at Tech Startup",
    );
  }

  @override
  Widget build(BuildContext context) {
    final Profile showProfile = profile ?? getRandomProfile();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Discover",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            /// IMAGE (matches screenshot height ratio)
            SizedBox(
              width: double.infinity,
              height: size.height * 0.55,
              child: Image.asset(
                showProfile.image,
                fit: BoxFit.cover,
              ),
            ),

            /// WHITE CARD BELOW IMAGE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// NAME + AGE
                  Text(
                    "${showProfile.name}, ${showProfile.age}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// ---------- LOCATION ----------
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 18, color: Colors.pinkAccent),
                      const SizedBox(width: 8),
                      Text(
                        showProfile.city,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// ---------- JOB ----------
                  Row(
                    children: [
                      const Icon(Icons.work_outline,
                          size: 18, color: Colors.pinkAccent),
                      const SizedBox(width: 8),
                      Text(
                        showProfile.job,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// ---------- MBA LINE (fixed like screenshot) ----------
                  Row(
                    children: const [
                      Icon(Icons.school_outlined,
                          size: 18, color: Colors.pinkAccent),
                      SizedBox(width: 8),
                      Text(
                        "MBA from IIM Bangalore",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// BIO
                  const Text(
                    "Passionate about technology and innovation. Love traveling, reading, and trying new cuisines...",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// VIEW FULL PROFILE
                  Row(
                    children: const [
                      Icon(Icons.visibility_outlined,
                          size: 18, color: Colors.pinkAccent),
                      SizedBox(width: 8),
                      Text(
                        "View Full Profile",
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// LIKE / DISLIKE BUTTONS (perfect match)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _circleButton(Icons.close),
                      const SizedBox(width: 40),
                      _circleButton(Icons.favorite_border),
                    ],
                  ),

                  const SizedBox(height: 26),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }

  /// CIRCLE BUTTON STYLE (matches screenshot)
  Widget _circleButton(IconData icon) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.pinkAccent, width: 1.8),
      ),
      child: Icon(icon, size: 34, color: Colors.pinkAccent),
    );
  }
}
