import 'dart:async';

import 'package:flutter/material.dart';

class TransportScreen extends StatefulWidget {
  const TransportScreen({super.key});
  @override
  State<TransportScreen> createState() => _TransportScreenState();
}

class _TransportScreenState extends State<TransportScreen> {
  final List<Map<String, dynamic>> _trucks = [
    {
      'driver': 'Satnam Singh',
      'vehicle': 'Tata 1109 Truck',
      'route': 'Ludhiana to Rajpura',
      'bhada': '₹8,500 Fixed',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kisan Transport'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _trucks.length,
        itemBuilder: (c, i) => Card(
          child: ListTile(
            leading: const Icon(Icons.local_shipping, color: Colors.blueGrey),
            title: Text(_trucks[i]['driver']!),
            subtitle: Text(_trucks[i]['route']!),
            trailing: Text(
              _trucks[i]['bhada']!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
