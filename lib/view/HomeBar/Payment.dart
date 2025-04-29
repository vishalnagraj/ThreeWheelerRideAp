import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
   PaymentScreen({Key? key}) : super(key: key);

  // Sample data for past payments
  final List<Map<String, dynamic>> payments = [
    {
      'date': '2024-10-01',
      'amount': 250.0,
      'method': 'Credit Card',
      'status': 'Completed',
    },
    {
      'date': '2024-09-25',
      'amount': 150.0,
      'method': 'PayPal',
      'status': 'Completed',
    },
    {
      'date': '2024-09-15',
      'amount': 300.0,
      'method': 'Debit Card',
      'status': 'Failed',
    },
    {
      'date': '2024-09-10',
      'amount': 400.0,
      'method': 'Bank Transfer',
      'status': 'Pending',
    },
    {
      'date': '2024-08-30',
      'amount': 180.0,
      'method': 'Credit Card',
      'status': 'Completed',
    },
    {
      'date': '2024-08-15',
      'amount': 120.0,
      'method': 'PayPal',
      'status': 'Completed',
    },
    {
      'date': '2024-07-20',
      'amount': 250.0,
      'method': 'Debit Card',
      'status': 'Completed',
    },
    {
      'date': '2024-07-05',
      'amount': 350.0,
      'method': 'Credit Card',
      'status': 'Failed',
    },
    {
      'date': '2024-06-30',
      'amount': 200.0,
      'method': 'Bank Transfer',
      'status': 'Completed',
    },
    {
      'date': '2024-06-15',
      'amount': 500.0,
      'method': 'Credit Card',
      'status': 'Completed',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Payment History'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: payments.length,
            separatorBuilder: (context, index) => const Divider(color: Colors.grey),
            itemBuilder: (context, index) {
              final payment = payments[index];
              return Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date: ${payment['date']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text('Amount: \$${payment['amount']}'),
                          const SizedBox(height: 4),
                          Text('Method: ${payment['method']}'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            payment['status'],
                            style: TextStyle(
                              color: payment['status'] == 'Completed'
                                  ? Colors.green
                                  : payment['status'] == 'Failed'
                                  ? Colors.red
                                  : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
