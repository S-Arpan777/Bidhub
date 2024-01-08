import 'package:auction_app/main.dart';
import 'package:auction_app/register_validate.dart';
import 'package:auction_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isPasswordVisible = false;

  bool? _isFemale;
  DateTime _selectedDate = DateTime.now(); // Initialize with the current date
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  final _passwordController = TextEditingController();
  final _addressController = TextEditingController();
  final _genderController = TextEditingController();
  final _citizenController = TextEditingController();
  final _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final fireStore = FirebaseFirestore.instance.collection('users');
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

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
              const SizedBox(height: 30),
              const Text(
                "Registration",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue, // Set the text color to blue
                  fontWeight: FontWeight.bold, // Set the text to bold
                ),
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Fullname:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _addressController,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Date Of Birth:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      readOnly: true,
                      controller: _dateController,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        hintText: 'Date of birth',
                        prefixIcon: const Icon(Icons.date_range_outlined),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Gender:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    DropdownButtonFormField<bool>(
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
                      value: _isFemale,
                      items: const [
                        DropdownMenuItem<bool>(
                          value: false,
                          child: Text('Male'),
                        ),
                        DropdownMenuItem<bool>(
                          value: true,
                          child: Text('Female'),
                        ),
                      ],
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isFemale = newValue;
                          _genderController.text = _isFemale == true? 'Female':'Male';
                          // ignore: avoid_print
                          print(_genderController.text); //gender is stored in _isFemale
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Citizenship Number:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _citizenController,
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'EMAIL:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'EMAIL',
                        prefixIcon: const Icon(Icons.email_outlined),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Password:',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.password_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),

              // Initialize with false

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          agreeToTerms = value!;
                        });
                      },
                    ),
                    RichText(
                      text: const TextSpan(
                        text: 'I agree to ',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'terms and conditions',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                    if(_formKey.currentState!.validate()){
                        if (agreeToTerms) {
                          _auth.createUserWithEmailAndPassword(email: _emailController.text.toString(), password: _passwordController.text.toString()).then((value){
                            String email = _emailController.text.toString();
                            fireStore.doc(email).set({
                              'Name':_nameController.text.toString(),
                              'Address': _addressController.text.toString(),
                              'Date of Birth': _dateController.text.toString(),
                              'Gender': _genderController.text.toString(),
                              'Citizenship Number': _citizenController.text.toString(),
                              'Email': _emailController.text.toString(),
                              'password': _passwordController.text.toString(),
                            }).then((value) {
                              Navigator.push(
                                context,
                                MaterialPageRoute( // Navigate to the register validate page
                                  builder: (context) =>
                                      RegisterValidationScreen(email: email),
                                ),
                              );
                            }).onError((error, stackTrace){
                              Utils().toastMessage(error.toString());
                            });
                          }).onError((error, stackTrace){
                            Utils().toastMessage(error.toString());
                          });
                      }else{
                          Utils().toastMessage("Agree to terms and conditions");
                        }
                    }


                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Continue', style: TextStyle(fontSize: 18)),
              ),

              const SizedBox(height: 20),
              const Divider(
                color: Colors.blue,
                thickness: 2,
                indent: 20,
                endIndent: 20,
              ),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Already a member?',
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the login page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Log in',
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
    ));
  }
}
