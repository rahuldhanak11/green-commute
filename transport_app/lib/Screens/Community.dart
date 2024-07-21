import 'package:flutter/material.dart';
import 'package:transport_app/Screens/Post.dart';

class Community extends StatelessWidget {
  final List<CommunityData> communities = [
    CommunityData(
      name: 'Cycling Community',
      numberOfPeople: 150,
      description: 'Join us for daily rides and bike maintenance tips.',
    ),
    CommunityData(
      name: 'Walking Community',
      numberOfPeople: 220,
      description: 'Discover new walking routes and connect with nature lovers.',
    ),
    CommunityData(
      name: 'Driving Community',
      numberOfPeople: 300,
      description: 'Share driving tips, road safety advice, and car enthusiasts.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 16, 25),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(height: 30 ),
            Center(
              child: Text(
                'Communities',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'Sans',
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: communities.length,
                itemBuilder: (context, index) {
                  final community = communities[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
                      color: Color.fromARGB(255, 37, 31, 50),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                          leading: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              getCommunityIcon(community.name),
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            community.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Sans',
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${community.numberOfPeople} people',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontFamily: 'Sans',
                                ),
                              ),
                              Text(
                                community.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                  fontFamily: 'Sans',
                                ),
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Handle JOIN button press
                              print('Join ${community.name} community');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 250, 30, 78),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                            child: Text(
                              'JOIN',
                              style: TextStyle(
                                fontFamily: 'Sans',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostPage()),
          );
        },
        backgroundColor: Color.fromARGB(255, 250, 30, 78),
        child: Icon(Icons.add,
        color: Colors.white,
        ),
      ),
    );
  }

  IconData getCommunityIcon(String name) {
    switch (name) {
      case 'Cycling Community':
        return Icons.directions_bike;
      case 'Walking Community':
        return Icons.directions_walk;
      case 'Driving Community':
        return Icons.drive_eta;
      default:
        return Icons.people;
    }
  }
}

class CommunityData {
  final String name;
  final int numberOfPeople;
  final String description;

  CommunityData({
    required this.name,
    required this.numberOfPeople,
    required this.description,
  });
}
