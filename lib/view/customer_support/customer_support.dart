import 'package:flutter/material.dart';

class CustomerSupportPage extends StatelessWidget {
  const CustomerSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Support'),
      ),
      body: SingleChildScrollView(
        padding:const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildContactSection(),
           const SizedBox(height: 20.0),
            _buildFAQSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      const  Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
       const SizedBox(height: 10.0),
        ListTile(
          leading:const Icon(Icons.email),
          title:const Text('support@ecotrack.com'),
          onTap: () {
            // Implement email sending functionality
          },
        ),
        ListTile(
          leading:const Icon(Icons.phone),
          title:const Text('+1 234 567 8900'),
          onTap: () {
            // Implement phone call functionality
          },
        ),
      const  SizedBox(height: 20.0),
      const  Text(
          'Electricity Board',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListTile(
          leading:const Icon(Icons.phone),
          title:const Text('+91 12345 67890'),
          onTap: () {
            // Implement phone call functionality
          },
        ),
       const SizedBox(height: 20.0),
       const Text(
          'Water Board',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListTile(
          leading:const Icon(Icons.phone),
          title:const Text('+1 234 567 8900'),
          onTap: () {
            // Implement phone call functionality
          },
        ),
      ],
    );
  }


  Widget _buildFAQSection() {
    return const  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Text(
          'FAQs',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        ExpansionTile(
          title: Text('How do I create an account?'),
          children: <Widget>[
            ListTile(
              title: Text('To create an account, go to...'),
              // Add more details here
            ),
          ],
        ),
        ExpansionTile(
          title: Text('How can I reset my password?'),
          children: <Widget>[
            ListTile(
              title: Text('To reset your password, follow...'),
              // Add more details here
            ),
          ],
        ),
        // Add more FAQ items
      ],
    );
  }
}

