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
      'title': 'Tractor Diesel Fuel',
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
      'msg':
          '🚜 Naya Swaraj 855 FE: Kam Diesel mein Zyada Takat! Today\'s Deal!',
    },
    {
      'brand': 'IFFCO Fertilizer',
      'msg': '🌱 IFFCO Nano Urea: Fasal ko de behtareen jhaad aur haryali.',
    },
  ];
  int _topAdIndex = 0, _bottomAdIndex = 1;
  Timer? _khataAdTimer;

  @override
  void initState() {
    super.initState();
    _khataAdTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _topAdIndex = (_topAdIndex + 1) % _khataLiveAds.length;
          _bottomAdIndex = (_bottomAdIndex + 1) % _khataLiveAds.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _khataAdTimer?.cancel();
    super.dispose();
  }

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
      backgroundColor: const Color(0xFFF7F5F2),
      appBar: AppBar(
        title: const Text('Kisan Khata / ਹਿਸਾਬ-ਕਿਤਾਬ'),
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 💰 Top Ad Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF1E1E1E),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.brown,
                  radius: 14,
                  child: Icon(Icons.star, color: Colors.white, size: 14),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _khataLiveAds[_topAdIndex]['brand']!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        _khataLiveAds[_topAdIndex]['msg']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Ad',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.brown.shade700, Colors.brown.shade500],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.account_balance_wallet, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Kisan Auto-Save Balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '₹$kisanWalletBalance',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.brown.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      'Total Income',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    Text(
                      '₹$totalIncome',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Total Expense',
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    Text(
                      '₹$totalExpense',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _records.length,
              itemBuilder: (context, i) {
                final item = _records[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(
                      item['isExpense']
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                      color: item['isExpense'] ? Colors.red : Colors.green,
                    ),
                    title: Text(
                      item['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
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
          // 💰 Bottom Ad Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: const Color(0xFF1E1E1E),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.brown,
                  radius: 14,
                  child: Icon(Icons.star, color: Colors.white, size: 14),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _khataLiveAds[_bottomAdIndex]['brand']!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        _khataLiveAds[_bottomAdIndex]['msg']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Ad',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
