import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';
import 'package:user_app/Config/AllDimensions.dart';
import 'package:user_app/Config/Confidential.dart';
import '../../Config/routes/PageConstants.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({Key? key}) : super(key: key);

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  final _sourceController = TextEditingController();
  final _destinationController = TextEditingController();

  // Focus Nodes
  FocusNode? _startFocusNode;
  FocusNode? _endFocusNode;

  // Details
  DetailsResult? _startPosition;
  DetailsResult? _endPosition;

  // List of Predictions
  GooglePlace? _googlePlace;
  List<AutocompletePrediction> predictions = [];

  @override
  void initState() {
    super.initState();
    _startFocusNode = FocusNode();
    _endFocusNode = FocusNode();
    _googlePlace = GooglePlace(Confidential.googleMapApiKey);
  }

  @override
  void dispose() {
    _startFocusNode!.dispose();
    _endFocusNode!.dispose();
    _sourceController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search Location"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          margin: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              // Source Location TextField
              TextField(
                autofocus: false,
                controller: _sourceController,
                focusNode: _startFocusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Source location',
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: Icon(Icons.my_location_outlined),
                  suffixIcon: InkWell(
                    onTap: () {
                      _sourceController.text = "";
                    },
                    child: Icon(Icons.close),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.isNotEmpty && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
              ),
              SizedBox(height: AllDimensions.eigth),

              // Destination Location TextField
              TextField(
                autofocus: false,
                controller: _destinationController,
                focusNode: _endFocusNode,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Destination location',
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: Icon(Icons.flag),
                  suffixIcon: InkWell(
                    onTap: () {
                      _destinationController.text = "";
                    },
                    child: Icon(Icons.close),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.isNotEmpty && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
              ),
              SizedBox(height: AllDimensions.eigth),

              // Predictions List
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: predictions.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        var details = await _googlePlace!.details.get(predictions[index].placeId!);
                        if (_startFocusNode!.hasFocus) {
                          setState(() {
                            _startPosition = details!.result!;
                            _sourceController.text = details.result!.name!;
                            predictions = [];
                          });
                        }
                        if (_endFocusNode!.hasFocus) {
                          setState(() {
                            _endPosition = details!.result!;
                            _destinationController.text = details.result!.name!;
                            predictions = [];
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.location_on_outlined),
                            SizedBox(width: AllDimensions.eigth),
                            Expanded(child: Text(predictions[index].description!)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Search Button
              ElevatedButton(
                onPressed: () {
                  if (_sourceController.text.isNotEmpty && _destinationController.text.isNotEmpty) {
                    // Navigate to BookingSection with source and destination
                    Navigator.pushNamed(
                      context,
                      PageConstants.book,
                      arguments: {
                        'pickupLocation': _sourceController.text,
                        'destinationLocation': _destinationController.text,
                        'price': calculatePriceBasedOnDistance(),
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please select both source and destination locations")),
                    );
                  }
                },
                child: Text("Search"),
              ),
            ],
          ),
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
    return 150.00; // Example static price
  }
}





