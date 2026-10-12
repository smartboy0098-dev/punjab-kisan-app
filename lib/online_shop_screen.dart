import 'dart:async';

import 'package:flutter/material.dart';

class OnlineShopScreen extends StatefulWidget {
  const OnlineShopScreen({super.key});
  @override
  State<OnlineShopScreen> createState() => _OnlineShopScreenState();
}

class _OnlineShopScreenState extends State<OnlineShopScreen> {
  final List<Map<String, String>> _appliances = [
    {
      'name': 'Samsung 32 inch LED TV',
      'price': '₹7,500',
      'details': 'Condition: 9/10 | 2 Years Used',
    },
    {
      'name': 'Godrej Double Door Refrigerator',
      'price': '₹11,200',
      'details': 'Model: 2022 | 240 Liters',
    },
  ];
  final List<Map<String, String>> _shopLiveAds = [
    {
      'brand': 'Swaraj Tractors',
      'msg': '🚜 Naya Swaraj 855 FE: 5-Saal Warranty ke sath aaj hi booking karein!',
    },
  ];
  int _topAdIndex = 0;
  Timer? _shopAdTimer;
  final _nameCtrl = TextEditingController(),
      _priceCtrl = TextEditingController(),
      _detCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _shopAdTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted)
        setState(() {
          _topAdIndex = (_topAdIndex + 1) % _shopLiveAds.length;
        });
    });
  }

  @override
  void dispose() {
    _shopAdTimer?.cancel();
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _detCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Online Ghar Store'),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Buy'),
              Tab(text: 'Sell'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _appliances.length,
              itemBuilder: (c, i) => Card(
                child: ListTile(
                  title: Text(_appliances[i]['name']!),
                  subtitle: Text(_appliances[i]['details']!),
                  trailing: Text(
                    _appliances[i]['price']!,
                    style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _nameCtrl,
                    decoration: const InputDecoration(labelText: 'Item Name'),
                  ),
                  TextField(
                    controller: _priceCtrl,
                    decoration: const InputDecoration(labelText: 'Price'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Post Ad'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
