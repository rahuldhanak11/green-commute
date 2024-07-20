import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:transport_app/Screens/Activities.dart';
import 'package:transport_app/Screens/Community.dart';
import 'package:transport_app/Screens/Home.dart';
import 'package:transport_app/Screens/Leaderboard.dart';

class Navbar extends StatefulWidget {
  final String username;
  final String email;

  const Navbar({required this.username, required this.email, Key? key})
      : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 1;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      Leaderboard(),
      HomePage(username: widget.username, email: widget.email),
      CommunityPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 37, 31, 50),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: GNav(
            backgroundColor: Color.fromARGB(255, 37, 31, 50),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color.fromARGB(255, 75, 66, 96),
            gap: 8,
            padding: EdgeInsets.all(12),
            selectedIndex: _selectedIndex,
            onTabChange: _navigateBottomBar,
            tabs: [
              GButton(
                icon: Icons.leaderboard,
                text: 'Leaderboard',
                textStyle: TextStyle(fontFamily: 'Sans', color: Colors.white),
              ),
              GButton(
                icon: Icons.dashboard_customize,
                text: 'Dashboard',
                textStyle: TextStyle(fontFamily: 'Sans', color: Colors.white),
              ),
              GButton(
                icon: Icons.location_city,
                text: 'Community',
                textStyle: TextStyle(fontFamily: 'Sans', color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
