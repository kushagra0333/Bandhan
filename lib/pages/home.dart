import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import '../components/navbar.dart';
import './profile.dart';

class HomePage extends StatefulWidget {
  final Profile? profile;

  const HomePage({super.key, this.profile});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late List<Profile> _profiles;
  int _currentProfileIndex = 0;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  int _swipeCount = 0;
  int _likesCount = 0;
  int _dislikesCount = 0;
  int _availableLikes = 6;
  bool _showAdPopup = false;
  bool _isWatchingAd = false;
  int _adSecondsRemaining = 0;
  late Timer _adTimer;
  late VideoPlayerController _videoController;
  bool _showAdBanner = false;

  /// RANDOM PROFILES DATA
  final List<Profile> _profileData = [
    Profile(
      image: "assets/girl_profile.jpg",
      name: "Anjali Mehta",
      age: "25",
      city: "Hyderabad, Telangana",
      job: "Software Engineer",
    ),
    Profile(
      image: "assets/girl2_profile.jpg",
      name: "Priya Sharma",
      age: "27",
      city: "Bangalore, Karnataka",
      job: "Product Manager",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _profiles = [..._profileData];

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(1.5, 0.0)).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    // Initialize video controller
    _videoController = VideoPlayerController.asset('assets/dummy_ad.mp4')
      ..initialize().then((_) {
        setState(() {});
      });

    // Check if we should show ad banner
    _checkAndShowAdBanner();
  }

  Future<void> _checkAndShowAdBanner() async {
    final prefs = await SharedPreferences.getInstance();
    bool hasSeenAdBanner = prefs.getBool('hasSeenAdBanner') ?? false;
    
    if (!hasSeenAdBanner) {
      // Wait for the page to load then show ad banner
      await Future.delayed(Duration(milliseconds: 800));
      if (mounted) {
        setState(() {
          _showAdBanner = true;
        });
      }
      // Mark as seen
      await prefs.setBool('hasSeenAdBanner', true);
    }
  }

  void _closeAdBanner() {
    setState(() {
      _showAdBanner = false;
    });
  }

  void _onAdBannerTap() {
    // Handle ad banner tap - could open website, play video, etc.
    print('Ad banner tapped!');
    // Example: Open a URL or show more ad details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Special Offer!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/add.jpg',
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              "Get 50% off on our premium dating features!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Upgrade now to see who likes you and get unlimited swipes!",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Maybe Later"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Redirecting to offer page...")),
              );
            },
            child: Text("View Offer"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _videoController.dispose();
    if (_isWatchingAd) {
      _adTimer.cancel();
    }
    super.dispose();
  }

  void _handleSwipe(bool isLike) {
    if (_currentProfileIndex >= _profiles.length) return;

    if (isLike) {
      if (_availableLikes <= 0) {
        // Show popup when no likes left
        _showAdPopup = true;
        setState(() {});
        return;
      }

      _availableLikes--;
      _likesCount++;
      print('Liked: ${_profiles[_currentProfileIndex].name}');
      _swipeCount++;

      // Check if we need to show ad popup (after 7 likes)
      if (_likesCount % 7 == 0 && _availableLikes <= 3) {
        _showAdPopup = true;
        setState(() {});
        return;
      }
    } else {
      _dislikesCount++;
      print('Disliked: ${_profiles[_currentProfileIndex].name}');
    }

    _moveToNextProfile();
  }

  void _moveToNextProfile() {
    // Start slide out animation
    _animationController.forward().then((_) {
      // After animation completes, move to next profile
      setState(() {
        _currentProfileIndex++;

        // Reset to first profile if we've seen all profiles
        if (_currentProfileIndex >= _profiles.length) {
          _currentProfileIndex = 0;
        }

        // Reset animation for next profile
        _animationController.reset();
      });
    });
  }

  void _watchAdForLikes() {
    setState(() {
      _showAdPopup = false;
      _isWatchingAd = true;
      _adSecondsRemaining = 30; // 30 seconds ad
    });

    // Play the video
    _videoController.play();

    // Simulate ad timer
    _adTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _adSecondsRemaining--;
      });

      if (_adSecondsRemaining <= 0) {
        timer.cancel();
        _completeAd();
      }
    });
  }

  void _completeAd() {
    _videoController.pause();
    _videoController.seekTo(Duration.zero);

    setState(() {
      _isWatchingAd = false;
      _availableLikes += 15; // Reward 15 likes for watching ad
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("+15 likes added! Total: $_availableLikes"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _skipAd() {
    if (_isWatchingAd) {
      _adTimer.cancel();
      _videoController.pause();
      _videoController.seekTo(Duration.zero);

      setState(() {
        _isWatchingAd = false;
      });

      // Show install prompt when skipping ad
      _showInstallPrompt();
    }
  }

  void _showInstallPrompt() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Install App"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_bag, size: 50, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              "Check out our amazing products!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Get 50% off on your first purchase",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Maybe Later"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Here you would typically open app store or play store
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Redirecting to app store...")),
              );
            },
            child: Text("Install Now"),
          ),
        ],
      ),
    );
  }

  void _closeAdPopup() {
    setState(() {
      _showAdPopup = false;
    });
  }

  Profile get _currentProfile => _profiles[_currentProfileIndex];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // If watching ad, show full screen ad without app bar or bottom nav
    if (_isWatchingAd) {
      return _buildFullScreenAd();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          "Discover",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "$_availableLikes ❤️",
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                /// ANIMATED PROFILE CARD
                SlideTransition(
                  position: _slideAnimation,
                  child: _buildProfileCard(size),
                ),
              ],
            ),
          ),

          /// AD POPUP OVERLAY
          if (_showAdPopup) _buildAdPopup(),

          /// ADVERTISEMENT BANNER OVERLAY (One-time only)
          if (_showAdBanner) _buildAdBanner(),
        ],
      ),

      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }

  Widget _buildAdBanner() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.orange.withOpacity(0.3)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _onAdBannerTap,
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Ad Poster/Image
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage('assets/add.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      
                      // Ad Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.orange),
                                  ),
                                  child: Text(
                                    "SPONSORED",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Premium Dating Features",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "See who likes you • Unlimited swipes • Boost your profile",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Special 50% off for new users!",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // CTA Button
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange, Colors.deepOrange],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "UPGRADE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Close Button
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.close, size: 14, color: Colors.grey[700]),
                      onPressed: _closeAdBanner,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullScreenAd() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full screen video player
          Center(
            child: _videoController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(height: 20),
                      Text(
                        "Loading ad...",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
          ),

          // Timer and close button at top
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "$_adSecondsRemaining",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Close button (appears after 10 seconds)
                if (_adSecondsRemaining <= 20)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: _skipAd,
                    ),
                  ),
              ],
            ),
          ),

          // Install button at the end
          if (_adSecondsRemaining <= 5)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: _showInstallPrompt,
                  child: Text("Install App Now"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ),
            ),

          // Skip ad text
          if (_adSecondsRemaining > 20)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Video ad - ${_adSecondsRemaining - 20}s until you can skip",
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAdPopup() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: 300,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.video_library, size: 60, color: Colors.pink),
              SizedBox(height: 16),
              Text(
                "Out of Likes!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "Watch a short video to get 15 free likes",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: _closeAdPopup,
                    child: Text("Not Now"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _watchAdForLikes,
                    child: Text("Watch Ad"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard(Size size) {
    final profile = _currentProfile;

    return Column(
      children: [
        /// IMAGE
        SizedBox(
          width: double.infinity,
          height: size.height * 0.55,
          child: Image.asset(
            profile.image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: Icon(Icons.error, size: 50, color: Colors.grey),
              );
            },
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
                "${profile.name}, ${profile.age}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 12),

              /// LOCATION
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: Colors.pinkAccent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    profile.city,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              /// JOB
              Row(
                children: [
                  const Icon(
                    Icons.work_outline,
                    size: 18,
                    color: Colors.pinkAccent,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    profile.job,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              /// MBA LINE
              Row(
                children: const [
                  Icon(
                    Icons.school_outlined,
                    size: 18,
                    color: Colors.pinkAccent,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "MBA from IIM Bangalore",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
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
                  Icon(
                    Icons.visibility_outlined,
                    size: 18,
                    color: Colors.pinkAccent,
                  ),
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

              /// LIKE / DISLIKE BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // DISLIKE BUTTON
                  GestureDetector(
                    onTap: () => _handleSwipe(false),
                    child: _circleButton(Icons.close),
                  ),
                  const SizedBox(width: 40),
                  // LIKE BUTTON
                  GestureDetector(
                    onTap: () => _handleSwipe(true),
                    child: _circleButton(Icons.favorite_border),
                  ),
                ],
              ),

              const SizedBox(height: 26),
            ],
          ),
        ),
      ],
    );
  }

  /// CIRCLE BUTTON STYLE
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