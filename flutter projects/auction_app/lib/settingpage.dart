import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme:
            const IconThemeData(color: Colors.black), // Set the arrow color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Upper Container with 2 Buttons
              Container(
                width: 350,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      237, 237, 237, 237), // Light grey color
                  borderRadius: BorderRadius.circular(30), // Rounded border
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 5, // Add shadow
                        padding: const EdgeInsets.all(15), // Increase button size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              40), // Rounded border for the button
                        ),
                        minimumSize: const Size(300, 65),
                        backgroundColor: const Color.fromRGBO(205, 205, 205, 1),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.password,
                            size: 30,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Change password',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        padding: const EdgeInsets.all(18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        minimumSize: const Size(300, 65),
                        backgroundColor: const Color.fromRGBO(205, 205, 205, 1),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.dark_mode,
                            size: 30,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Dark theme',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              // Lower Container with Change Password Form
              Container(
                width: 350,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      237, 237, 237, 237), // Light grey color
                  borderRadius: BorderRadius.circular(30), // Rounded border
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Change your Password',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Previous Password',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300, // Adjust the width as needed
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'password',
                          prefixIcon: const Icon(Icons.password),
                          prefixIconColor: Colors.black,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.purple, // Border color when unfocused
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue, // Border color when focused
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('New Password'),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 300, // Adjust the width as needed
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'New Password',
                          prefixIcon: const Icon(Icons.lock),
                          prefixIconColor: Colors.black,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.purple, // Border color when unfocused
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue, // Border color when focused
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add functionality for the confirm button
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30), // Adjust the radius as needed
                        ),
                        minimumSize: const Size(200, 50),
                        elevation: 5,
                        padding: const EdgeInsets.all(10),
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Confirm'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
