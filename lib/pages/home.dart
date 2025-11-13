import 'package:flutter/material.dart';
import '../components/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Discover',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PROFILE IMAGE
            SizedBox(
              width: double.infinity,
              height: screenHeight*0.5,
              child: Image.asset(
                'assets/girl_profile.jpg',
                fit: BoxFit.cover,
              ),
            ),

            // DETAILS CARD
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Priya Sharma, 27',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.location_on_outlined,
                          color: Colors.pinkAccent, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Bangalore, Karnataka',
                        style:
                            TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(Icons.work_outline,
                          color: Colors.pinkAccent, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Product Manager at Tech Startup',
                        style:
                            TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(Icons.school_outlined,
                          color: Colors.pinkAccent, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'MBA from IIM Bangalore',
                        style:
                            TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Passionate about technology and innovation. Love traveling, reading, and trying new cuisines...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      Icon(Icons.visibility_outlined,
                          color: Colors.pinkAccent, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'View Full Profile',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  // Like / Dislike Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.pinkAccent, width: 1.5),
                        ),
                        child: const Icon(Icons.close,
                            color: Colors.pinkAccent, size: 30),
                      ),
                      const SizedBox(width: 40),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.pinkAccent, width: 1.5),
                        ),
                        child: const Icon(Icons.favorite_border,
                            color: Colors.pinkAccent, size: 30),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}
