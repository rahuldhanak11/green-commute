import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        centerTitle: true,
        backgroundColor: Color(0xFF212121), // Dark background color
        foregroundColor: Colors.red, // Red text color
      ),
      body: Container(
        color: Color(0xFF212121), // Dark background color
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Carbon Emission',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Add rows for leaderboard entries here
            LeaderboardEntry(name: 'Player 1', emission: '1000'),
            LeaderboardEntry(name: 'Player 2', emission: '800'),
            LeaderboardEntry(name: 'Player 3', emission: '600'),
          ],
        ),
      ),
    );
  }
}

class LeaderboardEntry extends StatelessWidget {
  final String name;
  final String emission;

  LeaderboardEntry({required this.name, required this.emission});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            emission,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
