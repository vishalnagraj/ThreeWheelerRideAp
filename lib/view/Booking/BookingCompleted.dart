import 'package:flutter/material.dart';

class BookingCompleted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green, // Set the entire background to green
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Checkmark inside a circle
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white, // White circle
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check, // Checkmark icon
                  size: 60,
                  color: Colors.green, // Green color for the checkmark
                ),
              ),
              SizedBox(height: 20), // Space between the icon and text
              // Booking Completed Text
              Text(
                "Booking Completed!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40), // Space between text and button
              // Home Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to the home screen
                  Navigator.pushReplacementNamed(context, 'homeScreen');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Set button background to white
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  "Book Another Ride",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green, // Set button text color to green
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

