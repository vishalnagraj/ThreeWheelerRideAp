import 'package:flutter/material.dart';

class RentalSection extends StatefulWidget {
  @override
  _RentalSectionState createState() => _RentalSectionState();
}

class _RentalSectionState extends State<RentalSection> {
  String? selectedVehicle; // Track selected vehicle
  String? selectedPrice; // Track selected price

  // Sample price options based on kilometers
  final List<String> priceOptions = [
    "10 km - \$5",
    "20 km - \$10",
    "30 km - \$15",
    "40 km - \$20",
    "50 km - \$25",
    "60 km - \$30",
    "70 km - \$35",
    "80 km - \$40",
    "90 km - \$45",
    "100 km - \$50",
  ];

  // Method to show the selected options dialog
  void _showSelectedOptionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Selected Options"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Vehicle Type: $selectedVehicle"),
              Text("Price Option: $selectedPrice"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showRentalConfirmation(); // Show rental confirmation screen
              },
              child: Text("Get Rental"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel Rental"),
            ),
          ],
        );
      },
    );
  }

  // Show rental confirmation screen
  void _showRentalConfirmation() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => RentalConfirmation(
          vehicle: selectedVehicle,
          price: selectedPrice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rental Section"),
        backgroundColor: Colors.yellow[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vehicle selection section
            Text(
              "Select a Vehicle:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildVehicleOption(
                  "Electric Vehicle",
                  Colors.green,
                  "Electric",
                  'assets/images/electrical.png',
                ),
                _buildVehicleOption(
                  "Petrol Vehicle",
                  Colors.red,
                  "Petrol",
                  'assets/images/petrol.png',
                ),
              ],
            ),
            SizedBox(height: 20),

            // Price options
            Text(
              "Choose Price Option:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: priceOptions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(priceOptions[index]),
                      onTap: () {
                        setState(() {
                          selectedPrice = priceOptions[index]; // Set selected price
                        });
                      },
                      tileColor: selectedPrice == priceOptions[index]
                          ? Colors.yellow[200] // Highlight selected price
                          : null,
                    ),
                  );
                },
              ),
            ),

            // Button to confirm rental
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: selectedVehicle != null && selectedPrice != null
                    ? _showSelectedOptionsDialog
                    : null, // Disable button if not both options are selected
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Confirm Rental"),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Method to build vehicle option buttons with images
  Widget _buildVehicleOption(String label, Color color, String vehicleType, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedVehicle = vehicleType; // Set selected vehicle type
        });
      },
      child: Card(
        elevation: 6,
        color: selectedVehicle == vehicleType ? color.withOpacity(0.7) : color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4, // Half screen width
          height: MediaQuery.of(context).size.width * 0.4, // Half screen height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                height: 80, // Adjust height as needed
                fit: BoxFit.cover,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RentalConfirmation extends StatelessWidget {
  final String? vehicle;
  final String? price;

  RentalConfirmation({this.vehicle, this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Change background to green
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              "Rental Confirmed!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Vehicle: $vehicle\nPrice: $price",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst); // Go back to home
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                "Go to Home",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


