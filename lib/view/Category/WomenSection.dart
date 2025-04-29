import 'package:flutter/material.dart';

class WomenSection extends StatefulWidget {
  @override
  _WomenSectionState createState() => _WomenSectionState();
}

class _WomenSectionState extends State<WomenSection> {
  // List of drivers with unique details
  final List<Map<String, dynamic>> drivers = List.generate(10, (index) {
    return {
      "name": "Women Driver ${index + 1}",
      "rating": (4.0 + index * 0.1).toStringAsFixed(1), // Simulated ratings
      "rides": (50 + index * 5), // Simulated number of rides
    };
  });

  Map<String, dynamic>? _selectedDriver; // Variable to store selected driver

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Women"),
        backgroundColor: Colors.pinkAccent,
        elevation: 5,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink.shade100, Colors.purple.shade100],
          ),
        ),
        child: Column(
          children: <Widget>[
            // Women Section Image and Title
            Image.asset(
              'assets/images/womendriver.png', // Ensure the image path is correct
              height: 150,
              width: 150,
            ),
            SizedBox(height: 20),
            Text(
              "Welcome to the Women Section",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 15),
            Text(
              "Here, we provide services specifically tailored for women.",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Selected Driver Information
            if (_selectedDriver != null) ...[
              Text(
                "Selected Driver: ${_selectedDriver!['name']}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Rating: ${_selectedDriver!['rating']}",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Rides completed: ${_selectedDriver!['rides']}",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
            ],

            // Book a Ride Button
            ElevatedButton(
              onPressed: () {
                if (_selectedDriver != null) {
                  // Add action for button press
                  Navigator.pushNamed(context, 'destinationScreen');
                } else {
                  // Show a message if no driver is selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select a driver first!")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              ),
              child: Text(
                "Book a Ride",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 30),

            // Drivers List Header
            Text(
              "Available Women Drivers:",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade800,
              ),
            ),
            SizedBox(height: 10),

            // Driver List
            Expanded(
              child: ListView.builder(
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  final driver = drivers[index];
                  return Card(
                    color: Colors.white,
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.purpleAccent,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        driver["name"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      subtitle: Text("Rating: ${driver["rating"]} • Rides: ${driver["rides"]}"),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent),
                      onTap: () {
                        // Show dialog with driver details
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                driver["name"],
                                style: TextStyle(color: Colors.purpleAccent),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rating: ${driver["rating"]}",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Rides completed: ${driver["rides"]}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      _selectedDriver = driver; // Update selected driver
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("${driver["name"]} selected"),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pinkAccent,
                                  ),
                                  child: Text("Select"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}






