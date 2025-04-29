import 'package:flutter/material.dart';

class InsuranceScreen extends StatelessWidget {
  InsuranceScreen({Key? key}) : super(key: key);

  // Sample data for insurance policies
  final List<Map<String, dynamic>> insurancePolicies = [
    {
      'policyName': 'Health Insurance',
      'provider': 'ABC Insurance Co.',
      'policyNumber': 'H123456',
      'expiryDate': '2025-01-15',
      'status': 'Active',
    },
    {
      'policyName': 'Vehicle Insurance',
      'provider': 'XYZ Insurance Ltd.',
      'policyNumber': 'V987654',
      'expiryDate': '2024-08-30',
      'status': 'Active',
    },
    {
      'policyName': 'Home Insurance',
      'provider': 'HomeSecure Insurance',
      'policyNumber': 'H654321',
      'expiryDate': '2023-12-31',
      'status': 'Expired',
    },
    {
      'policyName': 'Travel Insurance',
      'provider': 'Safe Travel Co.',
      'policyNumber': 'T112233',
      'expiryDate': '2023-05-15',
      'status': 'Claimed',
    },
    {
      'policyName': 'Life Insurance',
      'provider': 'LifeCare Insurance',
      'policyNumber': 'L445566',
      'expiryDate': '2026-03-20',
      'status': 'Active',
    },
    {
      'policyName': 'Pet Insurance',
      'provider': 'PetProtect Insurance',
      'policyNumber': 'P778899',
      'expiryDate': '2024-10-01',
      'status': 'Active',
    },
    {
      'policyName': 'Critical Illness Insurance',
      'provider': 'SecureLife Insurance',
      'policyNumber': 'C334455',
      'expiryDate': '2025-09-12',
      'status': 'Active',
    },
    {
      'policyName': 'Dental Insurance',
      'provider': 'Dental Health Co.',
      'policyNumber': 'D101112',
      'expiryDate': '2024-04-20',
      'status': 'Active',
    },
    {
      'policyName': 'Accidental Insurance',
      'provider': 'AccidentSafe Insurance',
      'policyNumber': 'A131415',
      'expiryDate': '2023-11-30',
      'status': 'Expired',
    },
    {
      'policyName': 'Business Insurance',
      'provider': 'BizSecure Insurance',
      'policyNumber': 'B161718',
      'expiryDate': '2025-06-15',
      'status': 'Active',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Insurance Policies'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: insurancePolicies.length,
            separatorBuilder: (context, index) => const Divider(color: Colors.grey),
            itemBuilder: (context, index) {
              final policy = insurancePolicies[index];
              return Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        policy['policyName'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text('Provider: ${policy['provider']}'),
                      const SizedBox(height: 4),
                      Text('Policy Number: ${policy['policyNumber']}'),
                      const SizedBox(height: 4),
                      Text('Expiry Date: ${policy['expiryDate']}'),
                      const SizedBox(height: 4),
                      Text(
                        'Status: ${policy['status']}',
                        style: TextStyle(
                          color: policy['status'] == 'Active'
                              ? Colors.green
                              : policy['status'] == 'Expired'
                              ? Colors.red
                              : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
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
