import 'package:flutter/material.dart';
import 'package:user_app/view/Location/SearchDestination.dart';

class HandicappedSection extends StatefulWidget {
  @override
  _HandicappedSectionState createState() => _HandicappedSectionState();
}

class _HandicappedSectionState extends State<HandicappedSection> {
  List<String> selectedConditions = []; // List to store selected conditions

  // Define a custom light beige color
  final Color lightBeige = Color(0xFFF5F5DC); // Use RGB values for light beige

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Handicapped Section"),
        backgroundColor: Colors.yellow[700], // App bar color
      ),
      body: SingleChildScrollView(
        child: Container(
          color: lightBeige, // Use custom light beige color
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Heading and description
              Text(
                "How We Take Care of Handicapped Persons",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800], // Dark brown text
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Our services are specially designed to accommodate individuals with various disabilities, ensuring a comfortable and safe journey.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 20),

              // Handicapped options
              Text(
                "Select Your Condition",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800], // Dark brown text
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildConditionOption("No Legs", Icons.accessibility, context),
                  _buildConditionOption("No Hands", Icons.accessibility_new, context),
                  _buildConditionOption("No Vision", Icons.visibility_off, context),
                  _buildConditionOption("Can't Hear", Icons.hearing_disabled, context),
                ],
              ),
              SizedBox(height: 20),

              // Display selected conditions
              Text(
                "Selected Conditions:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800], // Dark brown text
                ),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: selectedConditions.map((condition) {
                  return Chip(
                    label: Text(condition),
                    backgroundColor: Colors.yellow[200], // Chip background color
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),

              // Book a ride button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the Destination section
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchDestination()), // Replace with your destination screen
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Peach button color
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Book a Ride",
                    style: TextStyle(fontSize: 18, color: Colors.white), // White text for better contrast
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build handicap option buttons
  Widget _buildConditionOption(String label, IconData icon, BuildContext context) {
    bool isSelected = selectedConditions.contains(label);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedConditions.remove(label); // Deselect if already selected
          } else {
            selectedConditions.add(label); // Select if not already selected
          }
        });
      },
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: isSelected ? Colors.yellow[300] : Colors.yellow[50], // Updated color
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.brown[800]! : Colors.transparent, // Border color when selected
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.brown[800]), // Updated icon color
            SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.brown[800]), // Updated text color
            ),
          ],
        ),
      ),
    );
  }
}

