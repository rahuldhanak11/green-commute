import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:transport_app/Screens/Activities.dart';
import 'package:transport_app/Screens/Community.dart';
import 'package:transport_app/Screens/Home.dart';
import 'package:transport_app/Screens/Leaderboard.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 0;

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
      HomePage(),
      LeaderBoard(),
      Activities(),
      Community(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 37, 31, 50),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                icon: Icons.home_rounded,
                text: 'Home',
                textStyle: TextStyle(
                  fontFamily: 'Sans',
                  color: Colors.white
                ),
              ),
              GButton(
                icon: Icons.leaderboard,
                text: 'Leaderboard',
                textStyle: TextStyle(
                  fontFamily: 'Sans',
                  color: Colors.white
                ),
              ),
              GButton(
                icon: Icons.auto_graph,
                text: 'Activities',
                textStyle: TextStyle(
                  fontFamily: 'Sans',
                  color: Colors.white
                ),
              ),
              GButton(
                icon: Icons.location_city,
                text: 'Community',
                textStyle: TextStyle(
                  fontFamily: 'Sans',
                  color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}