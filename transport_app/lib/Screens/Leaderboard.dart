import 'package:flutter/material.dart';

class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 16, 25), // Dark background color
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Leaderboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sans',
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 30, 78), // Distinct color
                borderRadius: BorderRadius.circular(9),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Rank',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sans',
                      ),
                    ),
                    Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sans',
                      ),
                    ),
                    Text(
                      'CO2 Saved',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sans',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                LeaderboardEntry(rank: '1st', name: 'Player 1', emission: '60 kg CO2'),
                LeaderboardEntry(rank: '2nd', name: 'Player 2', emission: '80 kg CO2'),
                LeaderboardEntry(rank: '3rd', name: 'Player 3', emission: '100 kg CO2'),
                LeaderboardEntry(rank: '4th', name: 'Player 4', emission: '150 kg CO2'),
                LeaderboardEntry(rank: '5th', name: 'Player 5', emission: '161 kg CO2'),
                // Add more entries here
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LeaderboardEntry extends StatelessWidget {
  final String rank;
  final String name;
  final String emission;

  LeaderboardEntry({required this.rank, required this.name, required this.emission});

  @override
  Widget build(BuildContext context) {
    Color rankColor;
    Color borderColor;
    switch (rank) {
      case '1st':
        rankColor = Colors.amber; // Gold
        borderColor = Colors.amber;
        break;
      case '2nd':
        rankColor = Colors.grey; // Silver
        borderColor = Colors.grey;
        break;
      case '3rd':
        rankColor = Color.fromARGB(255, 205, 127, 50); // Bronze
        borderColor = Color.fromARGB(255, 205, 127, 50);
        break;
      default:
        rankColor = Colors.white;
        borderColor = Colors.transparent;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(8,16,8,16),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 37, 31, 50),
          borderRadius: BorderRadius.circular(9.0),
          border: Border.all(
            color: borderColor,
            width: 2.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              rank,
              style: TextStyle(
                color: rankColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sans',
              ),
            ),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Sans',
              ),
            ),
            Text(
              emission,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Sans',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
