import 'package:flutter/material.dart';
import 'dart:math'; // Import to generate random values

class BookingSuccessfully extends StatefulWidget {
  final String pickupLocation; // Accept pickup location
  final String destinationLocation; // Accept destination location
  final double price; // Accept price

  const BookingSuccessfully({
    required this.pickupLocation,
    required this.destinationLocation,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  _BookingSuccessfullyState createState() => _BookingSuccessfullyState();
}

class _BookingSuccessfullyState extends State<BookingSuccessfully> {
  bool _isLoading = true;
  late double _randomDistance; // Random distance in km
  late double _randomPrice; // Random price for the ride
  late int _randomTime; // Random time in minutes

  @override
  void initState() {
    super.initState();
    _generateRandomValues(); // Generate random values when the screen is initialized

    // Simulate a loading delay of 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false; // Switch to ride details after loading
      });
    });
  }

  // Function to generate random values for distance, time, and price
  void _generateRandomValues() {
    // Random distance between 5 and 30 kilometers
    _randomDistance = (Random().nextDouble() * (30 - 5)) + 5;

    // Random price based on the distance (e.g., ₹50 to ₹500)
    _randomPrice = (_randomDistance * 10) + 50;

    // Random time to reach between 15 and 60 minutes
    _randomTime = Random().nextInt(45) + 15;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoading ? "Finding the Ride" : "Ride Assigned"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: _isLoading ? _buildLoadingSection() : _buildRideDetails(context),
      ),
    );
  }

  // Build loading section
  Widget _buildLoadingSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                "Finding the Ride...",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 15),
              CircularProgressIndicator(),
              SizedBox(height: 15),
              Text(
                "Please wait while we assign a ride for you",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Build ride details section after loading
  Widget _buildRideDetails(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Your ride has been assigned!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/images/rider.png', // Replace with your three-wheeler image asset
          height: 100,
        ),
        const SizedBox(height: 20),
        // Show Random Distance, Time, and Price
        Text(
          "Price: ₹${_randomPrice.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        const SizedBox(height: 10),
        Text(
          "Distance: ${_randomDistance.toStringAsFixed(2)} km",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        const SizedBox(height: 10),
        Text(
          "Estimated Time: $_randomTime minutes",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.star, color: Colors.orange),
            Icon(Icons.star, color: Colors.orange),
            Icon(Icons.star, color: Colors.orange),
            Icon(Icons.star, color: Colors.orange),
            Icon(Icons.star_half, color: Colors.orange),
            SizedBox(width: 10),
            Text("4.5", style: TextStyle(fontSize: 18)),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.lightGreen[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green, width: 2),
          ),
          child: Column(
            children: [
              Text(
                "Pick-Up Location: ${widget.pickupLocation}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              Text(
                "Destination: ${widget.destinationLocation}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'completed'); // Navigate to BookingCompleted
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text("Confirm Booking"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Booking Canceled"),
                duration: Duration(seconds: 2),
              ),
            );
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pushReplacementNamed(context, 'homeScreen'); // Navigate to HomeScreen
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text("Cancel Booking"),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, 'rent'); // Navigate to RentBike
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: const Text("Rental"),
        ),
        const SizedBox(height: 30),
        const Text(
          "You can cancel or choose the rental option before confirmation.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
