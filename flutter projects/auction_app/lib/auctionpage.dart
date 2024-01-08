import 'dart:async';
import 'dart:io';
import 'package:auction_app/biddingpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'Utils/utils.dart';

class AuctionPage extends StatefulWidget {
  final int showindex;
  final String photoUrls;
  final String descriptionText;
  final String email;

  const AuctionPage({
    Key? key,
    required this.showindex,
    required this.photoUrls,
    required this.descriptionText,
    required this.email,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AuctionPageState createState() => _AuctionPageState();
}

class _AuctionPageState extends State<AuctionPage> {
  File? _imagePath;
  int _showTabs=0;
  final Map<String, Timer?> productTimers = {};
  final databaseReference = FirebaseDatabase.instance.ref();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _showTabs = widget.showindex;
  }


  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = File(pickedFile.path);
      });
    }
  }
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descController = TextEditingController();
  final daysController = TextEditingController();

  @override
  void dispose(){
    // TODO: implement dispose
    super.dispose();
    daysController.dispose();
    descController.dispose();
    priceController.dispose();
    nameController.dispose();
    _imagePath = null;
  }
  final databaseref = FirebaseDatabase.instance.ref('auctions');


  /*Future<void> createAuction(String email, String name) async {
    firebase_storage.Reference profileRef = firebase_storage.FirebaseStorage.instance.ref(email).child(DateTime.now().microsecondsSinceEpoch.toString());
    firebase_storage.UploadTask up loadPhoto = profileRef.putFile(_imagePath!);
    await Future.value(uploadPhoto);
    var profileUrl = await profileRef.getDownloadURL();
    databaseref.child(DateTime.now().microsecondsSinceEpoch.toString()).child(email).set({

      'Product name': nameController.text.toString(),
      'Price': priceController.text.toString(),
      'Description': descController.text.toString(),
      'Days': daysController.text.toString(),
      'product': profileUrl,
    })
        .then((value){
      databaseReference.child(DateTime.now().microsecondsSinceEpoch.toString()).child(email).set({
        'Product name': nameController.text.toString(),
        'Price': priceController.text.toString(),
        'Description': descController.text.toString(),
        'Days': daysController.text.toString(),
        'Photo': profileUrl.toString(),
      }).onError((error, stackTrace){
        Utils().toastMessage(error.toString());
      }).then((value){
        Utils().toastMessage("Auction Placed");
      });
    });

  }*/
  void _startCountdownForProduct(String productId) {
    productTimers[productId]?.cancel(); // Cancel previous timer if exists
    productTimers[productId] = Timer.periodic(const Duration(minutes: 1), (timer) {
      // Update UI or perform actions based on the elapsed time for the specific product
      setState(() {});
    });
  }

  Future<void> createAuction(String email, String name) async {
    // Create a unique reference for the profile photo in Firebase Storage
    firebase_storage.Reference profileRef = firebase_storage.FirebaseStorage
        .instance.ref('products').child(DateTime
        .now()
        .microsecondsSinceEpoch
        .toString());
    final fireStore = FirebaseFirestore.instance.collection('user_photos');

    // Upload the photo to Firebase Storage
    firebase_storage.UploadTask uploadPhoto = profileRef.putFile(_imagePath!);
    await uploadPhoto; // Wait for the photo to be uploaded

    // Get the download URL of the uploaded photo
    var profileUrl = await profileRef.getDownloadURL();

    // Create a reference to the Realtime Database
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    // Create a unique key for the auction
    String auctionKey = databaseReference
        .child('auctions')
        .push()
        .key!;
    DateTime currentDate = DateTime.now();
    String StringDays = daysController.text.toString();
    int intDays = int.parse(StringDays);
    DateTime nDays = currentDate.add(Duration(days: intDays));
    // Set the auction details in the Realtime Database
    databaseReference.child('auctions').child(auctionKey).set(
        { //child(auctionKey!)push()
          'Key': auctionKey,
          'productName': nameController.text.toString(),
          'price': priceController.text.toString(),
          'Description': descController.text.toString(),
          'days': daysController.text.toString(),
          'lastBid': '0',
          'Photo': profileUrl,
          'SellerEmail': email,
          'BuyerEmail': '',
          'status': 'available',
          'placedDate': formatDate(currentDate),
          'expireDay': formatDate(nDays),
          // Add other fields as needed
        }).then((value) {
      if (mounted) {
        Utils().toastMessage("Auction Placed");
        _startCountdownForProduct(auctionKey);
        formKey.currentState?.reset();
        setState(() {
          nameController.clear();
          priceController.clear();
          descController.clear();
          daysController.clear();
          _imagePath = null;
        });
      }
    }).catchError((error) {
      if (mounted) {
        Utils().toastMessage("Failed to place auction: $error");
      }
    });
    fireStore.doc(auctionKey).set({
      'productName': nameController.text.toString(),
      'price': priceController.text.toString(),
      'Photo': profileUrl,
    });
  }
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
  @override
  Widget build(BuildContext context) {
    int showtabs = _showTabs;

    String photoUrls = widget.photoUrls;
    String descriptionText = widget.descriptionText;
    String email = widget.email;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  2,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _showTabs = index;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: showtabs == index
                            ? Colors.blue
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        index == 0 ? 'Create Auction' : 'Auction/Bid',
                        style: TextStyle(
                          color: showtabs == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (BuildContext context) {
                  if (showtabs == 0) {
                    return SingleChildScrollView(
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: 'Product name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: priceController,
                              decoration: InputDecoration(
                                labelText: 'Price',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: descController,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: daysController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              decoration: InputDecoration(
                                labelText: 'number of days',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.red[200],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.all(16),
                              height: 60,
                              width: 400,
                              child: const Text(
                                'Upload Photo:',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: 200,
                              height: 120,
                              child: GestureDetector(
                                onTap: _getImage,
                                child: _imagePath != null
                                    ? Image.file(
                                        (_imagePath!),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.photo_camera,
                                        size: 75,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                String input = nameController.text.toString();
                                  createAuction(email,input);
                                /*databaseRef.child(DateTime.now().microsecondsSinceEpoch.toString()).child(email).set({
                                  'Product name': nameController.text.toString()
                                }).then((value){
                                  Utils().toastMessage('Auction Created');
                                }).onError((error, stackTrace){
                                  Utils().toastMessage(error.toString());
                                });*/
                                // Add your logic for handling the button press here
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 5,
                                padding: const EdgeInsets.all(15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                minimumSize: const Size(250, 40),
                                backgroundColor: Colors.blue,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.shopping_bag,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 15),
                                  Text(
                                    'Place Bid',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (showtabs == 1) {
                    return BiddingPage(
                      photoUrls: photoUrls,
                      descriptionText: descriptionText,
                      email: email
                    );
                  } else {
                    return const Center(
                      child: Text('Invalid Index'),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
