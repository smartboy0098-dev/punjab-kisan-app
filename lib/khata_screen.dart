import 'dart:async';

import 'package:flutter/material.dart';

class KhataScreen extends StatefulWidget {
  const KhataScreen({super.key});
  @override
  State<KhataScreen> createState() => _KhataScreenState();
}

class _KhataScreenState extends State<KhataScreen> {
  final List<Map<String, dynamic>> _records = [
    {
      'title': 'Beej (Seeds) Khareede',
      'amount': 4500,
      'isExpense': true,
      'actualSpent': 4500,
    },
    {
      'title': 'Tractor Diesel fuel',
      'amount': 180,
      'isExpense': true,
      'actualSpent': 180,
    },
    {
      'title': 'Kanak (Wheat) Kamai',
      'amount': 48000,
      'isExpense': false,
      'actualSpent': 48000,
    },
  ];
  final List<Map<String, String>> _khataLiveAds = [
    {
      'brand': 'Swaraj Tractors',
      'msg': '🚜 Naya Swaraj 855 FE: Kam Diesel mein Zyada Takat!',
    },
  ];
  int _topAdIndex = 0;
  Timer? _khataAdTimer;

  int get kisanWalletBalance {
    int savedPool = 0;
    for (var item in _records) {
      if (item['isExpense'] == true) {
        int spent = item['actualSpent'] as int;
        if (spent % 100 != 0) savedPool += (((spent ~/ 100) + 1) * 100 - spent);
      }
    }
    return savedPool;
  }

  int get totalIncome => _records
      .where((item) => !item['isExpense'])
      .fold(0, (sum, item) => sum + (item['amount'] as int));
  int get totalExpense => _records
      .where((item) => item['isExpense'])
      .fold(0, (sum, item) => sum + (item['amount'] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kisan Khata'),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF1E1E1E),
            child: Text(
              _khataLiveAds[_topAdIndex]['msg']!,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _records.length,
              itemBuilder: (context, i) {
                final item = _records[i];
                return Card(
                  child: ListTile(
                    leading: Icon(
                      item['isExpense']
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: item['isExpense'] ? Colors.red : Colors.green,
                    ),
                    title: Text(item['title']),
                    trailing: Text(
                      '₹${item['amount']}',
                      style: TextStyle(
                        color: item['isExpense'] ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
