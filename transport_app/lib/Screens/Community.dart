
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:transport_app/Screens/Post.dart';

class CommunityPage extends StatelessWidget {
  // Replace this with your actual data
  final List<String> posts = ['Post 1', 'Post 2', 'Post 3'];
  final List<String> groups = ['Group A', 'Group B', 'Group C'];
  final List<String> events = ['Event 1', 'Event 2', 'Event 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Social Feed
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Social Feed',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            for (var post in posts)
              SizedBox(
                width: double.infinity,
                height: 100, // Adjust the height as needed
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(
                      vertical: 4), // Optional: add margin between containers
                  color: Colors.grey[
                      300], // Optional: add background color for better visibility
                  child: Text(post),
                ),
              ),

            // Group Discovery
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  Text('Groups', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            for (var group in groups)
              SizedBox(
                width: double.infinity,
                height: 100, // Adjust the height as needed
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(
                      vertical: 4), // Optional: add margin between containers
                  color: Colors.grey[
                      300], // Optional: add background color for better visibility
                  child: Text(group),
                ),
              ),

            // Event Listings
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  Text('Events', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            for (var event in events)
              SizedBox(
                width: double.infinity,
                height: 100, // Adjust the height as needed
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.symmetric(
                      vertical: 4), // Optional: add margin between containers
                  color: Colors.grey[
                      300], // Optional: add background color for better visibility
                  child: Text(event),
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
        child: Icon(Icons.add),
      ),
    );
  }
}

