import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:user_app/Config/Confidential.dart';
import 'package:user_app/view/Booking/BookingSection.dart';
import '../../Config/routes/PageConstants.dart';

class SearchDestination extends StatefulWidget {
  const SearchDestination({Key? key}) : super(key: key);

  @override
  State<SearchDestination> createState() => _SearchDestinationState();
}

class _SearchDestinationState extends State<SearchDestination> {
  final TextEditingController _destinationController = TextEditingController();
  GooglePlace? _googlePlace;
  List<AutocompletePrediction> predictions = [];

  @override
  void initState() {
    super.initState();
    _googlePlace = GooglePlace(Confidential.googleMapApiKey);
  }

  @override
  void dispose() {
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Destination"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Current location bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Your current location",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Search destination bar
            TextField(
              controller: _destinationController,
              decoration: InputDecoration(
                hintText: "Search destination",
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  autoCompleteSearch(value);
                } else {
                  setState(() {
                    predictions = [];
                  });
                }
              },
            ),
            SizedBox(height: 20),

            // Display predictions
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(),
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(predictions[index].description!),
                    onTap: () {
                      _destinationController.text = predictions[index].description!;
                      setState(() {
                        predictions = [];
                      });
                    },
                  );
                },
              ),
            ),

            // Search button
            ElevatedButton(
              onPressed: () {
                if (_destinationController.text.isNotEmpty) {
                  String pickupLocation = "Your Pickup Location"; // Replace with actual pickup location
                  String destinationLocation = _destinationController.text; // Selected destination
                  double price = calculatePriceBasedOnDistance(); // Replace with your logic to calculate price

                  // Navigate to BookingSection with parameters
                  Navigator.pushNamed(
                    context,
                    PageConstants.book,
                    arguments: {
                      'pickupLocation': pickupLocation,
                      'destinationLocation': destinationLocation,
                      'price': price,
                    },
                  );
                } else {
                  // Optionally show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select a destination")),
                  );
                }
              },
              child: Text("Search"),
            ),
          ],
        ),
      ),
    );
  }

  void autoCompleteSearch(String value) async {
    var result = await _googlePlace!.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  double calculatePriceBasedOnDistance() {
    // Implement your logic to calculate price based on distance
    return 150.00; // Example static price
  }
}