import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const BottomNavBar({super.key, required this.selectedIndex});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/likes');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: (index) => _onItemTapped(context, index),
      backgroundColor: Colors.white,
      selectedItemColor: Colors.deepPurpleAccent,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),       
          label: 'Discover',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),     
          label: 'Likes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),        
          label: 'Profile',
        ),
      ],
    );
  }
}
