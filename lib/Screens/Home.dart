import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 16, 25),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20), // Adjusted top spacing
            Text(
              'Hello User',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: 'Sans',
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '+91 1234567890', // Replace with dynamic phone number if needed
              style: TextStyle(
                color: Color.fromARGB(255, 157, 157, 157),
                fontSize: 18,
                fontFamily: 'Sans',
              ),
            ),
            const SizedBox(height: 40), // Adjusted spacing for better layout
            Text(
              'Journey Points',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Sans',
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                _buildClickableContainer('Choose Source'),
                const SizedBox(height: 10),
                _buildClickableContainer('Choose Destination'),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 250, 30, 78),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text('Search',
                    style: TextStyle(
                      fontFamily: 'Sans',
                      fontSize: 18,
                      color: Colors.white
                    ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40), // Adjusted spacing before stats section
            Text(
              'Stats & Leaderboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Sans',
              ),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 165,
                      height: 165,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 37, 31, 50),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Carbon Footprint Saved',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Sans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '150 kg CO2', // Replace with dynamic value
                              style: TextStyle(
                                color: Color.fromARGB(255, 250, 30, 78),
                                fontSize: 24,
                                fontFamily: 'Sans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 165,
                      height: 165,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 37, 31, 50),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Badges Achieved',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'Sans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '23 / 52', // Replace with dynamic value
                              style: TextStyle(
                                color: Color.fromARGB(255, 250, 30, 78),
                                fontSize: 24,
                                fontFamily: 'Sans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 100),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 89, 68, 134),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                    child: Text('Check Leaderboard',
                    style: TextStyle(
                      fontFamily: 'Sans',
                      fontSize: 20,
                      color: Colors.white
                    ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClickableContainer(String text) {
    return GestureDetector(
      onTap: () {
        // Handle container tap
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 37, 31, 50),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
          child: Text(
            text,
            style: TextStyle(
              color: Color.fromARGB(255, 157, 157, 157),
              fontSize: 18,
              fontFamily: 'Sans',
            ),
          ),
        ),
      ),
    );
  }
}
