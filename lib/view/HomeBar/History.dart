import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> rideHistory = [
    {
      "date": "Oct 21, 2024",
      "time": "10:00 AM",
      "pickup": "Sector 62, Noida",
      "destination": "Electronic City, Noida",
      "fare": 150.0
    },
    {
      "date": "Oct 20, 2024",
      "time": "6:30 PM",
      "pickup": "Indirapuram, Ghaziabad",
      "destination": "Sector 18, Noida",
      "fare": 200.0
    },
    {
      "date": "Oct 19, 2024",
      "time": "8:00 AM",
      "pickup": "Lajpat Nagar, Delhi",
      "destination": "Connaught Place, Delhi",
      "fare": 300.0
    },
    {
      "date": "Oct 18, 2024",
      "time": "1:00 PM",
      "pickup": "Dwarka, Delhi",
      "destination": "Janakpuri, Delhi",
      "fare": 120.0
    },
    {
      "date": "Oct 17, 2024",
      "time": "5:00 PM",
      "pickup": "Greater Noida",
      "destination": "Sector 16, Noida",
      "fare": 350.0
    },
    {
      "date": "Oct 16, 2024",
      "time": "9:30 AM",
      "pickup": "Sector 15, Faridabad",
      "destination": "South Extension, Delhi",
      "fare": 250.0
    },
    {
      "date": "Oct 15, 2024",
      "time": "3:15 PM",
      "pickup": "Karol Bagh, Delhi",
      "destination": "Rajendra Place, Delhi",
      "fare": 180.0
    },
    {
      "date": "Oct 14, 2024",
      "time": "7:45 PM",
      "pickup": "Gurugram Sector 29",
      "destination": "Cyber City, Gurugram",
      "fare": 220.0
    },
    {
      "date": "Oct 13, 2024",
      "time": "11:30 AM",
      "pickup": "Kalkaji, Delhi",
      "destination": "Nehru Place, Delhi",
      "fare": 100.0
    },
    {
      "date": "Oct 12, 2024",
      "time": "4:20 PM",
      "pickup": "MG Road, Gurugram",
      "destination": "Saket, Delhi",
      "fare": 400.0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ride History'),
      ),
      body: ListView.builder(
        itemCount: rideHistory.length,
        itemBuilder: (context, index) {
          final ride = rideHistory[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(Icons.directions_car, color: Colors.blue),
              title: Text('${ride['pickup']} → ${ride['destination']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ${ride['date']}'),
                  Text('Time: ${ride['time']}'),
                  Text('Fare: ₹${ride['fare'].toStringAsFixed(2)}'),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Handle ride details click if needed
              },
            ),
          );
        },
      ),
    );
  }
}
