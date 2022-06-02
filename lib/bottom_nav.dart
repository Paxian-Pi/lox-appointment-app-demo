import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lox_mobile/search_view.dart';

import 'profile_view.dart';
import 'appontment_view.dart';
import 'home_view.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static final List<Widget> _bottomNavView = [
    const HomeView(),
    const SearchView(),
    const AppointmentView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _bottomNavView.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: _navBarList
            .map(
              (e) => BottomNavigationBarItem(
            icon: Image.asset(
              e.icon,
              width: 24.0,
            ),
            activeIcon: Image.asset(
              e.activeIcon,
              width: 24.0,
            ),
            label: e.title,
          ),
        )
            .toList(),
      ),
    );
  }
}

class NavBarItem {
  final String icon;
  final String activeIcon;
  final String title;

  NavBarItem(
      {required this.icon, required this.activeIcon, required this.title});
}

List<NavBarItem> _navBarList = [
  NavBarItem(
    icon: "assets/home.png",
    activeIcon: "assets/home_2.png",
    title: "Home",
  ),
  NavBarItem(
    icon: "assets/search.png",
    activeIcon: "assets/search_2.png",
    title: "Search",
  ),
  NavBarItem(
    icon: "assets/appointment.png",
    activeIcon: "assets/appointment_2.png",
    title: "Appointment",
  ),
  NavBarItem(
    icon: "assets/profile.png",
    activeIcon: "assets/profile_2.png",
    title: "Profile",
  ),
];
