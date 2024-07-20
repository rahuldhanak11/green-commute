import 'package:flutter/material.dart';
import 'package:transport_app/leaderboard-service.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  bool showOverall = true;
  Future<List<LeaderboardEntryModel>>? leaderboardFuture;

  @override
  void initState() {
    super.initState();
    leaderboardFuture = LeaderboardService().fetchOverallLeaderboard();
  }

  void toggleLeaderboard(bool isOverall) {
    setState(() {
      showOverall = isOverall;
      if (isOverall) {
        leaderboardFuture = LeaderboardService().fetchOverallLeaderboard();
      } else {
        leaderboardFuture = LeaderboardService().fetchDailyLeaderboard();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 16, 25),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => toggleLeaderboard(true),
                child: Text(
                  'Overall',
                  style: TextStyle(
                    color: showOverall ? Colors.white : Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => toggleLeaderboard(false),
                child: Text(
                  'Daily',
                  style: TextStyle(
                    color: showOverall ? Colors.grey : Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 250, 30, 78),
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
            child: FutureBuilder<List<LeaderboardEntryModel>>(
              future: leaderboardFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var entry = snapshot.data![index];
                      return LeaderboardEntry(
                        rank: (index + 1).toString(),
                        name: entry.fullName,
                        emission: '${entry.carbonSaved} kg CO2',
                      );
                    },
                  );
                }
              },
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

  LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.emission,
  });

  @override
  Widget build(BuildContext context) {
    Color rankColor;
    Color borderColor;
    switch (rank) {
      case '1':
        rankColor = Colors.amber;
        borderColor = Colors.amber;
        break;
      case '2':
        rankColor = Colors.grey;
        borderColor = Colors.grey;
        break;
      case '3':
        rankColor = Color.fromARGB(255, 205, 127, 50);
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
        padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
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
