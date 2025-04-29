import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('About Us'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'About This App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Our app is designed to provide a reliable and convenient three-wheeler ride service, catering to the needs of elderly, handicapped, and women travelers. We aim to make transportation accessible for everyone, ensuring safety and comfort during your journey.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Features',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                '- User-friendly interface\n'
                    '- Real-time tracking of rides\n'
                    '- Multiple payment options\n'
                    '- Booking for special categories (Elderly, Handicapped, Women)\n'
                    '- Customer support available 24/7',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Contact Us',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'If you have any questions or feedback, feel free to reach out to us at:\n'
                    'Email: support@threewheelerapp.com\n'
                    'Phone: 1-800-555-0199',
                style: TextStyle(fontSize: 16),
              ),
              const Spacer(),
              const Center(
                child: Text(
                  '© 2024 Three Wheeler Ride. All rights reserved.',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
