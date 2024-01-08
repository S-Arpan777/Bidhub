import 'package:auction_app/register_validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditAccountScreenState createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final TextEditingController _emailController = TextEditingController();

  bool agreeToTerms = false; //agree to trems is stored here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
                 const Text(
                "Edit account",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue, // Set the text color to blue
                  fontWeight: FontWeight.bold, // Set the text to bold
                ),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'assets/profile_image.jpg'), // Replace with your image asset
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Fullname:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                      width:
                          12), // Adjust the spacing between label and TextField
                  Expanded(
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                      ],
                      decoration: InputDecoration(
                        hintText: 'FULL NAME',
                        prefixIcon: const Icon(Icons.person_outline),
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
                ],
              ),

              const SizedBox(height: 10),
              Row(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Address:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Address',
                        prefixIcon: const Icon(Icons.location_city_outlined),
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
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Date of',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Birth:',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  Expanded(
                      child: TextField(
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Date of birth',
                      prefixIcon: const Icon(Icons.date_range_outlined),
                      prefixIconColor: Colors.black,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
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
                  )),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Gender:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(width: 26),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Gender',
                        prefixIcon: const Icon(Icons.wc_outlined),
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
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Citizenship',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Number:',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Citizenship Number',
                        prefixIcon: const Icon(Icons.description_outlined),
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
                ],
              ),
              const SizedBox(height: 10),
              Row(children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'EMAIL:',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(width: 28),
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'EMAIL',
                      prefixIcon: const Icon(Icons.email_outlined),
                      prefixIconColor: Colors.black,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
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
              ]),

              const SizedBox(height: 20),
              // Initialize with false

              ElevatedButton(
                onPressed: () {
                  // Handle login logic or any other necessary tasks

                  String email = _emailController.text;

                  // Navigate to the register validate page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RegisterValidationScreen(email: email),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Continue', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
