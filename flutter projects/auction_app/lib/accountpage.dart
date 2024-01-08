import 'package:auction_app/editaccount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  final String email;
  const AccountPage({Key? key, required this.email}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  late Future<String> profileImageFuture;
  late Future<DocumentSnapshot<Object?>> userDataFuture;
  late String _email;
  @override
  void initState(){
    super.initState();
    profileImageFuture= getProfileImage();
    _email = widget.email;
    userDataFuture = getUserData();
  }
  Future<String> getProfileImage() async {
    /*FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageRef = storage.ref().child(email).child('profile');*/
    Reference storageRef = FirebaseStorage.instance.ref(_email).child('profile');


    try {
      // Get the download URL of the profile image
      String downloadURL = await storageRef.getDownloadURL();
      return downloadURL;
    } catch (error) {
      print('Error getting profile image: $error');
      if (error is FirebaseException && error.code == 'object-not-found') {
        print('File not found at the specified reference.');
      }
      return '';
    }
  }
  Future<DocumentSnapshot<Object?>> getUserData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot<Object?> documentSnapshot = await users.doc(_email).get();

    return documentSnapshot;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            FutureBuilder<String>(
              future: profileImageFuture,
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Text ('Error: ${snapshot.error}');
                }else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No profile image available.');
                } else{
                  return  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(snapshot.data!),
                  );
                }
                
              }
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 15,
                  color: Colors.blue,
                ),
                SizedBox(width: 5),
                Text(
                  'Verified',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            FutureBuilder<DocumentSnapshot<Object?>>(
              future: userDataFuture,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  Map<String, dynamic>? userData =
                  snapshot.data!.data() as Map<String, dynamic>?;
                  return Column(
                    children: [
                      Text('Name: ${userData?['Name']}'),
                      const SizedBox(height: 20),
                      Text('Address: ${userData?['Address']}'),
                      const SizedBox(height: 20),
                      Text('Date of Birth: ${userData?['Date of Birth']}'),
                      const SizedBox(height: 20),
                      Text('Gender: ${userData?['Gender']}'),
                      const SizedBox(height: 20),
                      Text('Citizenship number: ${userData?['Citizenship number']}'),
                      const SizedBox(height: 20),
                      Text('Email: ${userData?['Email']}'),
                      const SizedBox(height: 20),
                    ],
                  );
                }
              }
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditAccountScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit_document,
                      size: 20,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Edit Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
