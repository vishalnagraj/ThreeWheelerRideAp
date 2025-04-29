import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:user_app/view/Booking/BookingSuccessfully.dart';

class BookingSection extends StatefulWidget {
  final String pickupLocation;
  final String destinationLocation;
  final double price;
  final LatLng pickupLatLng; // Ensure this exists
  final LatLng destinationLatLng; // Ensure this exists

  const BookingSection({
    Key? key,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.price,
    required this.pickupLatLng, // Add this
    required this.destinationLatLng, // Add this
  }) : super(key: key);

  @override
  _BookingSectionState createState() => _BookingSectionState();
}

class _BookingSectionState extends State<BookingSection> {
  late GoogleMapController _mapController;
  List<LatLng> _polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  final LatLng _pickupLatLng = LatLng(28.6139, 77.2090); // Replace with dynamic pickup coordinates
  final LatLng _destinationLatLng = LatLng(28.7041, 77.1025); // Replace with dynamic destination coordinates
  final String _googleApiKey = "AIzaSyDlFCieEJtG5h3FlfjRaHr30lpbJvSpHiM"; // Replace with your actual API key

  @override
  void initState() {
    super.initState();
    _getRouteCoordinates();
  }

  // Fetch route coordinates from Google Directions API
  Future<void> _getRouteCoordinates() async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${_pickupLatLng.latitude},${_pickupLatLng.longitude}&destination=${_destinationLatLng.latitude},${_destinationLatLng.longitude}&key=$_googleApiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["routes"].isNotEmpty) {
        final polylinePoints = data["routes"][0]["overview_polyline"]["points"];
        _polylineCoordinates = _decodePolyline(polylinePoints);
        setState(() {
          _polylines.add(
            Polyline(
              polylineId: PolylineId("route"),
              points: _polylineCoordinates,
              color: Colors.blue,
              width: 5,
            ),
          );
        });
      }
    }
  }

  // Decode polyline points to LatLng
  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Section"),
        backgroundColor: Colors.green[500],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Google Map section
            Container(
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _pickupLatLng,
                    zoom: 12,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('pickup'),
                      position: _pickupLatLng,
                      infoWindow: InfoWindow(title: widget.pickupLocation),
                    ),
                    Marker(
                      markerId: MarkerId('destination'),
                      position: _destinationLatLng,
                      infoWindow: InfoWindow(title: widget.destinationLocation),
                    ),
                  },
                  polylines: _polylines,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                ),
              ),
            ),

            // Pickup and Destination Info
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenHeight * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLocationRow(Icons.my_location, "Pickup Location", widget.pickupLocation, Colors.green),
                      SizedBox(height: screenHeight * 0.01),
                      Divider(color: Colors.grey[300], thickness: 1),
                      SizedBox(height: screenHeight * 0.01),
                      _buildLocationRow(Icons.flag, "Destination", widget.destinationLocation, Colors.red),
                    ],
                  ),
                ),
              ),
            ),

            // Book Ride Button
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingSuccessfully(
                            pickupLocation: widget.pickupLocation,
                            destinationLocation: widget.destinationLocation,
                            price: widget.price,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: screenHeight * 0.02),
                      textStyle: TextStyle(fontSize: screenHeight * 0.025),
                    ),
                    child: Text("Book Ride"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build location rows
  Widget _buildLocationRow(IconData icon, String label, String location, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 24),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                location,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}