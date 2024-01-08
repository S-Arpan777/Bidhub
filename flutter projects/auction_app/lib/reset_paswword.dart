import 'package:auction_app/email_otp.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
 

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
               const SizedBox(height: 20),
              Row(
  children: [
    IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        // Handle the back action
      },
    ),
    const Text(
      'Back',
      style: TextStyle(
        fontSize: 24,
      ),
    ),
    // Other widgets...
  ],
)
,
              const SizedBox(height: 10),

              const Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue, // Set the text color to blue
                  fontWeight: FontWeight.bold, // Set the text to bold
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Enter the email associated with your account and we’ll send and code to reset your password',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email address:',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                 
                ),
              ),
              const SizedBox(height: 5),
              TextField(
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
              const SizedBox(height: 30),
              
              ElevatedButton(
                onPressed: ()  {
                  String email = _emailController.text;
    // Handle login logic or any other necessary tasks



    // Navigate to the register validate page
    Navigator.push(
      context,
      MaterialPageRoute(
         builder: (context) => EmailOtpScreen(email: email),
        ),
    );
  },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Send code', style: TextStyle(fontSize: 18)),
              ),
             
            ],
          ),
        ),
      ),
    ));
  }
}
