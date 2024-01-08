import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Utils/utils.dart';

class BiddingPage extends StatefulWidget {
   const BiddingPage(
      {Key? key, required this.photoUrls, required this.descriptionText, required this.email})
      : super(key: key);

  final String photoUrls;
  final String descriptionText;
  final String email;



  @override
  // ignore: library_private_types_in_public_api
  _BiddingPageState createState() => _BiddingPageState();
}


class _BiddingPageState extends State<BiddingPage> {
  final valueChange = TextEditingController();
  final keyController = TextEditingController();
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child('auctions');
  final List<Map<String, dynamic>> _auctionsData = [];
  Timer? _countdownTimer;
late String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setupDatabase();
    email = widget.email;
  }

  void _setupDatabase() {
    databaseRef.onChildAdded.listen((event) {
      _handleDatabaseChange(event.snapshot);
    });

    databaseRef.onChildChanged.listen((event) {
      _handleDatabaseChange(event.snapshot);
    });
  }

  void _handleDatabaseChange(DataSnapshot snapshot) {
    if (snapshot.value != null) {
      dynamic data = snapshot.value;
      if (data is Map &&
          data.containsKey('productName') &&
          data.containsKey('price') &&
          data.containsKey('days') &&
          data.containsKey('lastBid') &&
          data.containsKey('Key') &&
          data.containsKey('BuyerEmail') &&
          data.containsKey('SellerEmail') &&
          data.containsKey('expireDay')
          ) {
        DateTime expiryDay = DateTime.parse(data['expireDay']);
        DateTime currentDate = DateTime.now();
        if(currentDate.isBefore(expiryDay)){
          setState(() {
            _auctionsData.removeWhere((element) =>
            element['Key'] == data['Key']);
            _auctionsData.add({
              'productName': data['productName'],
              'price': data['price'],
              'days': data['days'],
              'lastBid': data['lastBid'],
              'Key': data['Key'],
              'BuyerEmail': data['BuyerEmail'],
              'SellerEmail': data['SellerEmail'],
            });
          });
        }

      }
    }
  }

  @override
  void dispose(){
    _countdownTimer?.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(height: 10),

              // Description text in a light grey container
              Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.descriptionText,
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // Bidding section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: valueChange,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.monetization_on),
                        prefixIconColor: Colors.blue,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        isDense: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.purple,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            style: BorderStyle.solid,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the Bid button
                      final currentTime = DateTime.now();
                      final isBiddingAllowed = _isBiddingAllowed(currentTime);
                      if(isBiddingAllowed){
                        _updateBidInDatabase(keyController.text, valueChange.text);
                      }else{
                        Utils().toastMessage('Bidding is allowed between 10 AM to 5AM');
                      }


                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(80, 10),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Bid',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add functionality for the Edit button
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(75, 10),
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // My Bids section
               const Text(
                'My Bids',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              // Auctions table
              _buildAuctionsTable(),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build the auctions table
  Widget _buildAuctionsTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[200]),
          children: const [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Product Name'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Original Price'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Last Bid'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Days Left'),
              ),
            ),
          ],
        ),
        for (var elements in _auctionsData)
          _buildAuctionRow(
            elements['productName'],
            elements['price'],
            elements['days'],
            elements['lastBid'],
          ),
      ],
    );
  }



  // Function to build an auction row
  TableRow _buildAuctionRow(
    String productName,
    String price,
    String days,
    String lastBid,
  ) {

    return TableRow(
      children: [
        GestureDetector(
          onTap: () {
            // Handle row click event, set highest bid value in the TextField
            _setHighestBidValue(lastBid, context, productName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(productName),
            //child: Padding(padding: const EdgeInsets.all(8.0), child: Text(productName)),
          ),
        ),
        TableCell(child: Padding(padding: const EdgeInsets.all(8.0), child: Text(price))),
        TableCell(child: Padding(padding: const EdgeInsets.all(8.0), child: Text(lastBid))),
        TableCell(child: Padding(padding: const EdgeInsets.all(8.0), child: Text(days))),
      ],
    );
  }

  void _setHighestBidValue(String highestBid, BuildContext context, String productName) {
    valueChange.text = highestBid;
    final matchingProduct = _auctionsData.firstWhere(
          (element) => element['productName'] == productName,
      orElse: () => {},
    );
    keyController.text = matchingProduct['Key'] ?? '';
  }

  void _updateBidInDatabase(String auctionKey, String enteredBid) {
    final matchingProduct = _auctionsData.firstWhere(
          (element) => element['Key'] == auctionKey,
      orElse: () => {},
    );

    if (matchingProduct.isEmpty) {
      Utils().toastMessage('Product not found.');
      return;
    }
    final originalPrice = double.tryParse(matchingProduct['price'] ?? '') ?? 0.0;
    final currentLastBid = double.tryParse(matchingProduct['lastBid'] ?? '') ?? 0.0;

    if (email == matchingProduct['SellerEmail']) {
      Utils().toastMessage("You cannot bid on your own item.");
      return;
    }else if (email != matchingProduct['SellerEmail']){
    }
    if (enteredBid.isNotEmpty) {
      final bidValue = double.tryParse(enteredBid) ?? 0.0;

      if (bidValue > originalPrice && bidValue > currentLastBid) {
        // Update the database with the new bid value
        databaseRef.child(matchingProduct['Key']).update({
          'lastBid': enteredBid,
          // You can update other fields if needed
          'BuyerEmail' : email,

        }).then((_) {
          Utils().toastMessage('Bid successfully placed!');
          setState(() {

          });
        }).catchError((error) {
          Utils().toastMessage('Failed to update bid: $error');
        });
      } else {
        Utils().toastMessage('Invalid bid value. Please enter a value greater than the original price and last bid.');
      }
    } else {
      Utils().toastMessage('Bid value cannot be empty.');
    }
  }

  bool _isBiddingAllowed(DateTime currentTime) {
    final int currentHour = currentTime.hour;
    // Bidding is allowed between 10 AM to 5 PM (10 to 17 in 24-hour format)
    return currentHour >= 10 && currentHour < 24;
  }


}
