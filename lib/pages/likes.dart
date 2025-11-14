import 'package:flutter/material.dart';
import '../components/navbar.dart';
import './profile.dart';
import './home.dart';

class LikesPage extends StatelessWidget {
  const LikesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F7),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Matches",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Matches (2)",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                _matchCard(
                  context,
                  Profile(
                    image: "assets/girl2_profile.jpg",
                    name: "Priya Sharma",
                    age: "27 years",
                    city: "Bangalore, Karnataka",
                    job: "Product Manager",
                  ),
                ),
                const SizedBox(width: 16),
                _matchCard(
                  context,
                  Profile(
                    image: "assets/girl_profile.jpg",
                    name: "Anjali Mehta",
                    age: "25 years",
                    city: "Hyderabad, Telangana",
                    job: "Software Engineer",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      bottomNavigationBar: const BottomNavBar(selectedIndex: 1),
    );
  }

  /// MATCH CARD UI
  Widget _matchCard(BuildContext context, Profile profile) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomePage(profile: profile),
          ),
        );
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.asset(
                profile.image,
                height: 160,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color:Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    profile.age,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                    const Icon(Icons.location_on_outlined,
                        size: 14, color: Colors.pinkAccent),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        profile.city,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.work_outline,
                        size: 14, color: Colors.pinkAccent),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        profile.job,
                        style: const TextStyle(
                            fontSize: 12, color: Colors.black54),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
