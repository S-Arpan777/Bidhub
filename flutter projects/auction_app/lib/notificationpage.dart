import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const NotificationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the background color
        title: const Text(
          'System Notification',
          style: TextStyle(color: Colors.black), // Set text color
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black, // Set the color of the back arrow
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back when the arrow is pressed
          },
        ),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Icon(
                Icons.notifications_off,
                size: 250,
                color: Colors.blue,
              ),
              SizedBox(height: 30),
              Text(
                'No notifications yet',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 300),
            ],
          ),
        ),
      ),
    );
  }
}
