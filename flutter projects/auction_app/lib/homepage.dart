import 'dart:async';
import 'package:auction_app/auctionpage.dart';
import 'package:auction_app/historypage.dart';
import 'package:auction_app/mypage.dart';
import 'package:auction_app/notificationpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  int show = 0;
  late List<String> _promotionImages = [];
  List images = [];
  @override
  void initState() {
    _startAutomaticScroll();
    loadStorageData();
    super.initState();
  }

  Future<List<Map<String, dynamic>>> _imageDataListFuture() async {
    CollectionReference userPhotosRef =
    FirebaseFirestore.instance.collection('user_photos');
    QuerySnapshot<Object?> querySnapshot =
    await FirebaseFirestore.instance.collection('user_photos').get();

    return querySnapshot.docs
        .map((doc) => (doc.data() as Map<String, dynamic>))
        .toList();
  }


  Future<List<String>> fetchStorageData() async {
    List<String> downloadUrls = [];

    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageRef = storage.ref().child('Product');

      // List all items (files) in the 'Product' folder
      ListResult result = await storageRef.listAll();

      // Iterate through each item and get the download URL
      for (Reference ref in result.items) {
        String downloadURL = await ref.getDownloadURL();
        downloadUrls.add(downloadURL);
      }
    } catch (error) {
      print('Error fetching storage data: $error');
      // Handle the error as needed
    }

    return downloadUrls;
  }
  Future<void> loadStorageData() async {
    List<String> storageUrls = await fetchStorageData();

    _promotionImages.addAll(storageUrls);
  }
  void _startAutomaticScroll() {
    if (_promotionImages.isNotEmpty) {
      Timer.periodic( Duration(seconds: 3), (Timer timer) {
        _currentPage = (_currentPage + 1) % _promotionImages.length; // Assuming 10 items
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });
    }

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String email = widget.email;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.perm_identity_outlined,
            color: Colors.black,
            size: 35,
          ),
          onPressed: () {
            setState(() {
              _selectedIndex = 3;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_rounded,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Builder(
        builder: (BuildContext context) {
          if (_selectedIndex == 0) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _promotionImages.length,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.all(8),
                          color: Colors.blue,
                          child: CachedNetworkImage(
                            imageUrl :_promotionImages[index],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => ErrorWidget(error),
                          ),

                        );
                      },
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 16.0),
                    child: Text(
                      'Featured Items',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _imageDataListFuture(),
                      builder: (context, snapshot) {
                        /*if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else*/ if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Text('No images available.');
                        } else {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              Map<String, dynamic> imageData =
                                  snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    show = 1;
                                    _selectedIndex = 1;
                                  });
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  color: const Color.fromARGB(255, 114, 124, 114),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        imageData['Photo'],
                                        height: 120,
                                        width: 160,
                                      ),
                                      const SizedBox(height: 16.0),
                                      Text(
                                        ' ${imageData['productName']}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Price Rs ${imageData['price']}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (_selectedIndex == 1 && show == 1) {
            show = 0;
            return AuctionPage(
              showindex: 1,
              photoUrls: 'assets/anishjpgs.jpg',
              descriptionText: 'description from home page',
              email: email,
            );
          } else if (_selectedIndex == 1 && show == 0) {
            return AuctionPage(
              showindex: 0,
              photoUrls: 'your_photo_urls_for_show_0',
              descriptionText: 'please select the item ',
              email: email,
            );
          } else if (_selectedIndex == 2) {
            return HistoryPage(
              email: email,
            );
          } else if (_selectedIndex == 3) {
            return  MyPage(email: email,);
          } else {
            return const Center(
              child: Text('Invalid Index'),
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 14,
          selectedFontSize: 14,
          unselectedItemColor:
              Colors.grey, // Set the unselected item text color
          selectedItemColor: Colors.black, // Set the selected item text color
          currentIndex:
              _selectedIndex, // Add this line to manage the selected index
          onTap: _onItemTapped, // Add this line to handle item taps
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_outlined),
              activeIcon: Icon(Icons.local_offer),
              label: 'Auction',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              activeIcon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity_outlined),
              activeIcon: Icon(Icons.person),
              label: 'My Account',
            ),
          ],
        ),
      ),
    );
  }
}
