import 'package:auction_app/new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmailOtpScreen extends StatefulWidget {
  const EmailOtpScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  // ignore: library_private_types_in_public_api
  _EmailOtpScreenState createState() => _EmailOtpScreenState();
}

class _EmailOtpScreenState extends State<EmailOtpScreen> {
  @override
  Widget build(BuildContext context) {
    String email = widget.email;

    Widget buildOtpTextField() {
      return Container(
        width: 35,
        height: 35,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                SvgPicture.string(
                        '''
                  <svg width="129" height="129" viewBox="0 0 129 129" fill="none" xmlns="http://www.w3.org/2000/svg">
                  <g clip-path="url(#clip0_26_2)">
                  <path d="M64.5 0C47.3935 0 30.9877 6.79552 18.8916 18.8916C6.79552 30.9877 0 47.3935 0 64.5C0 81.6065 6.79552 98.0123 18.8916 110.108C30.9877 122.204 47.3935 129 64.5 129C81.6065 129 98.0123 122.204 110.108 110.108C122.204 98.0123 129 81.6065 129 64.5C129 47.3935 122.204 30.9877 110.108 18.8916C98.0123 6.79552 81.6065 0 64.5 0ZM32.25 32.25H96.75C97.9029 32.25 99.0156 32.4999 100.048 32.9595L64.5 74.4249L28.9524 32.9595C29.9879 32.4889 31.1126 32.2469 32.25 32.25ZM24.1875 88.6875V40.3125L24.2036 39.8046L47.8429 67.3864L24.4616 90.7676C24.2769 90.0898 24.1847 89.3901 24.1875 88.6875ZM96.75 96.75H32.25C31.5405 96.75 30.8391 96.6532 30.1699 96.4759L53.1157 73.53L64.5081 86.817L75.9004 73.53L98.8463 96.4759C98.1684 96.6606 97.4687 96.7528 96.7661 96.75H96.75ZM104.812 88.6875C104.812 89.397 104.716 90.0984 104.538 90.7676L81.1571 67.3864L104.796 39.8046L104.812 40.3125V88.6875Z" fill="#1297FF"/>
                  </g>
                  <defs>
                  <clipPath id="clip0_26_2">
                  <rect width="129" height="129" fill="white"/>
                  </clipPath>
                  </defs>
                  </svg>

                ''',
                  height: 130,
                  width: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Check your mail",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'We have sent you code to your given email',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Text(
                      'Email: $email',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // Other widgets...
                  ],
                ),
                const SizedBox(height: 50),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildOtpTextField(),
                      const SizedBox(width: 10),
                      buildOtpTextField(),
                      const SizedBox(width: 10),
                      buildOtpTextField(),
                      const SizedBox(width: 10),
                      buildOtpTextField(),
                      const SizedBox(width: 10),
                      buildOtpTextField(),
                      const SizedBox(width: 10),
                      buildOtpTextField(),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                  
    // Handle login logic or any other necessary tasks



    // Navigate to the register validate page
    Navigator.push(
      context,
      MaterialPageRoute(
         builder: (context) => const NewPasswordScreen(),
        ),
    );
                    // Handle logic for Continue button
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Verify', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Didnt receive code?',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'Resend',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
