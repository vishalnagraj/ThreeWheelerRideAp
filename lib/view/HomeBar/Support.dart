import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
   SupportScreen({Key? key}) : super(key: key);

  // Sample data for FAQs
  final List<Map<String, String>> faqs = [
    {
      'question': 'How do I book a ride?',
      'answer': 'You can book a ride by selecting your pickup and destination locations in the app.'
    },
    {
      'question': 'What payment methods are accepted?',
      'answer': 'We accept credit cards, debit cards, and mobile payment options like Google Pay and Apple Pay.'
    },
    {
      'question': 'How can I cancel my ride?',
      'answer': 'You can cancel your ride from the active bookings screen. There may be a cancellation fee based on the timing.'
    },
    {
      'question': 'What should I do if I left something in the vehicle?',
      'answer': 'Please contact our support team immediately, and we will assist you in retrieving your lost item.'
    },
    {
      'question': 'How can I contact customer support?',
      'answer': 'You can reach our customer support via the contact form below or call our hotline at 1-800-555-0199.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Support'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: faqs.length,
                  separatorBuilder: (context, index) => const Divider(color: Colors.grey),
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title: Text(faqs[index]['question']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          child: Text(faqs[index]['answer']!),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text('Need more help? Contact us below:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Your Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Your Message',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Handle the contact form submission
                  // For now, just show a snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Message sent!')),
                  );
                },
                child: const Text('Send Message'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
