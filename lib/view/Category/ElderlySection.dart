import 'package:flutter/material.dart';
import 'package:user_app/view/Booking/RentalSection.dart';

class ElderlySection extends StatefulWidget {
  @override
  _ElderlySectionState createState() => _ElderlySectionState();
}

class _ElderlySectionState extends State<ElderlySection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Elderly Section"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                    Text(
                      "Rent a Three-Wheeler",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Choose a vehicle for comfortable and safe transportation.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/elderly.png', // Replace with your image path
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Why Choose Our Three-Wheeler Rentals?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal[800]),
              ),
              SizedBox(height: 10),
              // Description of the rental service
              Container(
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Text(
                      "• Affordable rates for all distances\n"
                          "• Comfortable seating for a smooth ride\n"
                          "• Easy booking process through our app\n"
                          "• Trained drivers to ensure safety\n"
                          "• 24/7 customer support for assistance\n"
                          "• Eco-friendly vehicles to reduce carbon footprint\n"
                          "• Flexible rental hours for your convenience\n"
                          "• On-time pickup and drop-off guaranteed\n"
                          "• User-friendly app interface for seamless navigation\n"
                          "• Multiple payment options for easy transactions\n"
                          "• Well-maintained vehicles for a reliable experience\n"
                          "• Family-friendly options available upon request",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.teal[800],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _showRentalDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Rent Now",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show a confirmation dialog
  void _showRentalDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Rental"),
          content: Text(
            "Are you sure you want to rent a three-wheeler? We guarantee a comfortable ride and excellent service.",
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirm"),
              onPressed: () {
                // Navigate to RentalSection after confirming rental
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => RentalSection()),
                );

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Rental Confirmed!", style: TextStyle(color: Colors.green)),
                ));
              },
            ),
          ],
        );
      },
    );
  }
}





