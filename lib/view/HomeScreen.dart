import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_app/view/ChatBot/ChatBotPage.dart';
import 'package:user_app/view_model/HomeViewModel.dart';
import 'package:user_app/view_model/SplashViewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeViewModel = Get.put(HomeViewModel());
  final splashViewModel = Get.put(SplashViewModel());
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = <Marker>[];

  String _userName = "John Doe";
  String _userEmail = "johndoe@example.com";
  bool _isEditing = false; // Flag to toggle between edit and save modes
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  File? _profileImage; // Variable to store picked profile image

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController.text = _userName;
    _emailController.text = _userEmail;
    loadAllMapMarkersData();
    _addChatbotMarker();  // Add the chatbot marker to the map
  }

  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }


  Future<void> loadAllMapMarkersData() async {
    for (int i = 0; i < homeViewModel.markerList.length; i++) {
      final Uint8List markersIcons = await getImages(homeViewModel.markerList[i].icon!, 50);
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          icon: BitmapDescriptor.fromBytes(markersIcons),
          position: LatLng(homeViewModel.markerList[i].latitude!, homeViewModel.markerList[i].longitude!),
          infoWindow: InfoWindow(
            title: homeViewModel.markerList[i].title,
            snippet: '${homeViewModel.markerList[i].distance} Km',
          ),
        ),
      );
    }
  }

  void _addChatbotMarker() async {
    final Uint8List chatbotIcon = await getImages('assets/images/chatbot_icon.png', 100);
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("chatbot_marker"),
          icon: BitmapDescriptor.fromBytes(chatbotIcon),
          position: LatLng(17.385044, 78.486671), // Example position
          infoWindow: InfoWindow(title: "Chatbot"),
          onTap: () {
            _openChatbot();  // Open chatbot when the marker is tapped
          },
        ),
      );
    });
  }

  // Function to open the chatbot as a modal or floating widget
  void _openChatbot() {
    showDialog(
      context: context,
      barrierDismissible: true,  // Allow closing by tapping outside
      builder: (context) {
        return Dialog(
          child: ChatBotPage(),  // Your chatbot widget inside a dialog
        );
      },
    );
  }

  // Toggle edit mode and save profile details
  // Toggle edit mode and save profile details
  // Toggle edit mode and save profile details
  void _toggleEditMode() {
    if (_isEditing) {
      // Save the details if editing is complete
      setState(() {
        _userName = _nameController.text;
        _userEmail = _emailController.text;
        _isEditing = false;
      });
    } else {
      // Show dialog for editing
      _showEditProfileDialog();
    }
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow closing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Enter your name"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "Enter your email"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _userName = _nameController.text;
                  _userEmail = _emailController.text;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Save"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without saving
              },
              child: Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
  // Function to pick an image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Or ImageSource.camera for camera capture
    );
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("THREE WHEELER RIDE"),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: _isEditing
                    ? TextField(
                  controller: _nameController,
                  decoration: InputDecoration(hintText: "Enter your name"),
                )
                    : Text(_userName),
                accountEmail: _isEditing
                    ? TextField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: "Enter your email"),
                )
                    : Text(_userEmail),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage("https://example.com/photo.jpg"),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                otherAccountsPictures: [
                  IconButton(
                    icon: Icon(_isEditing ? Icons.save : Icons.edit, color: Colors.white),
                    onPressed: _toggleEditMode, // Toggle between edit/save
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('History'),
                onTap: () {
                  Navigator.pushNamed(context, 'history');
                },
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text('Payments'),
                onTap: () {
                  Navigator.pushNamed(context, 'payment');
                },
              ),
              ListTile(
                leading: Icon(Icons.security),
                title: Text('Insurance'),
                onTap: () {
                  Navigator.pushNamed(context, 'insurance');
                },
              ),
              ListTile(
                leading: Icon(Icons.support),
                title: Text('Support'),
                onTap: () {
                  Navigator.pushNamed(context, 'support');
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  Navigator.pushNamed(context, 'About');
                },
              ),
            ],
          ),
        ),
        body: Obx(() => Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(splashViewModel.latitude.value), double.parse(splashViewModel.longitude.value)),
                zoom: 12,
              ),
              markers: Set<Marker>.of(_markers),
              mapType: MapType.normal,
              myLocationEnabled: true,
              compassEnabled: false,
              zoomControlsEnabled: false,
              buildingsEnabled: false,
              trafficEnabled: false,
              indoorViewEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),

            // Current Location Bar (Extracted)
            Positioned(
              top: 8,
              left: 8,
              right: 8,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'locationSearchScreen');
                },
                child: Card(
                  elevation: 3,
                  child: Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                        ),
                        Expanded(
                          child: Text(
                            "Your current location",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Icon(Icons.favorite_border_outlined),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Women, Elderly, and Handicapped Section (Extracted)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        itemCount: 3, // We need only three items
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          List<Map<String, String>> categories = [
                            {"name": "Women", "image": "assets/images/Women1.png", "route": 'women'},
                            {"name": "Elderly", "image": "assets/images/elderly.png", "route": 'elderly'},
                            {"name": "Handicapped", "image": "assets/images/handicapped.png", "route": 'handicapped'},
                          ];

                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, categories[index]['route']!);
                            },
                            child: Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8),
                                  padding: EdgeInsets.all(8),
                                  child: Image.asset(
                                    categories[index]["image"]!,
                                    height: 30,
                                    width: 50,
                                  ),
                                ),
                                Text(
                                  categories[index]["name"]!,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(color: Colors.grey[300]),
                    // Search Destination Section (Extracted)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Card(
                        elevation: 3,
                        child: Container(
                          margin: EdgeInsets.all(8),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[300],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, 'destinationScreen');
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 8),
                                      ),
                                      Text(
                                        "Search destination",
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              for (int i = 0; i < 3; i++)
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  height: 40,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.location_on),
                                      Text("Destination Option $i", style: TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              bottom: 100,
              right: 10,
              child: FloatingActionButton(
                onPressed: _openChatbot,  // Open chatbot modal when the FAB is pressed
                backgroundColor: Colors.blue,
                child: Icon(Icons.chat_bubble, color: Colors.white),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
