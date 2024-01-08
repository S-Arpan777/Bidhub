import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Utils/utils.dart';

// ignore: use_key_in_widget_constructors

class HistoryPage extends StatefulWidget {
  final String email;

  const HistoryPage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final DatabaseReference databaseRefere =
      FirebaseDatabase.instance.ref().child('auctions');
  final List<Map<String, dynamic>> _history = [];
late String _email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = widget.email;
    _setupTable();
  }

  void _setupTable() {
    databaseRefere.onValue.listen((event) {
      if (event.snapshot.value != null) {
        dynamic data = event.snapshot.value;

        if (data is Map<dynamic, dynamic>) {
          _history.clear(); // Clear the existing data before updating

          data.forEach((key, auctionData) {
            if (auctionData is Map &&
                auctionData.containsKey('productName') &&
                auctionData.containsKey('price') &&
                auctionData.containsKey('lastBid') &&
                auctionData.containsKey('Key') &&
                auctionData.containsKey('BuyerEmail') &&
                auctionData.containsKey('SellerEmail') &&
                auctionData.containsKey('expireDay')) {
              DateTime expiryDay = DateTime.parse(auctionData['expireDay']);
              DateTime currentDay = DateTime.now();
              if (_email == auctionData['BuyerEmail'] ){
                if (currentDay.isAfter(expiryDay)) {
                  setState(() {
                    _history.add({
                      'productName': auctionData['productName'],
                      'price': auctionData['price'],
                      'lastBid': auctionData['lastBid'],
                      'Key': auctionData['Key'],
                      'BuyerEmail': auctionData['BuyerEmail'],
                      'SellerEmail': auctionData['SellerEmail'],
                    });
                  });
                }

              }

            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'History',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _buildHistoryTable(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryTable() {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[200]),
          children: const [
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Text('Product Name'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Text('Original Price'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: Text('Winning Bid Price'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(11.0),
                child: Text('BuyerEmail'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.all(11.0),
                child: Text('SellerEmail'),
              ),
            ),
          ],
        ),
        for (var digits in _history)
          _buildHistoryRow(digits['productName'], digits['price'],
              digits['lastBid'], digits['BuyerEmail'], digits['SellerEmail']),
      ],
    );
  }

  TableRow _buildHistoryRow(String productName, String originalPrice,
      String winningBidPrice, String buyerEmail, String sellerEmail) {
    return TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(productName),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(originalPrice),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Text(winningBidPrice),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Text(buyerEmail),
          ),
        ),
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(11.0),
          child: Text(sellerEmail),
        ))
      ],
    );
  }
}
