import 'dart:async';

import 'package:flutter/material.dart';

class MandiWeatherScreen extends StatefulWidget {
  const MandiWeatherScreen({super.key});
  @override
  State<MandiWeatherScreen> createState() => _MandiWeatherScreenState();
}

class _MandiWeatherScreenState extends State<MandiWeatherScreen> {
  final List<Map<String, String>> _mandiLiveAds = [
    {
      'brand': 'John Deere',
      'msg': '🚜 John Deere 5050 D: Zordar power aur kheti mein behtareen mileage!',
    },
    {
      'brand': 'Tata Shaktee',
      'msg':
          '🪵 Tata GC Sheets: Ghar aur pakke shedd ke liye sabse mazboot tadd!',
    },
  ];
  int _topAdIndex = 0, _bottomAdIndex = 1;
  Timer? _adTimer;

  @override
  void initState() {
    super.initState();
    _adTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _topAdIndex = (_topAdIndex + 1) % _mandiLiveAds.length;
          _bottomAdIndex = (_bottomAdIndex + 1) % _mandiLiveAds.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _adTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6EEF8),
      appBar: AppBar(
        title: const Text('Mandi & Weather / ਮੰਡੀ ਅਤੇ ਮੌਸਮ'),
        backgroundColor: Colors.purple.shade700,
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
                  backgroundColor: Colors.purple,
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
                        _mandiLiveAds[_topAdIndex]['brand']!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        _mandiLiveAds[_topAdIndex]['msg']!,
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Weather Module Card
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.shade700,
                          Colors.purple.shade400,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ludhiana, Punjab',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Icon(Icons.wb_sunny, color: Colors.amber, size: 32),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          '32°C',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Clear Sky / ਮੌਸਮ ਸਾਫ਼ ਹੈ। No rain predicted today.',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Live Mandi Govt Market Rates (🌾 MSP)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _mandiItem(
                  'Wheat / ਕਣਕ',
                  '₹2,425 / Qtl',
                  'Ludhiana Mandi',
                  Colors.green,
                ),
                _mandiItem(
                  'Paddy (Dhan) / ਝੋਨਾ',
                  '₹2,320 / Qtl',
                  'Jalandhar Market',
                  Colors.green,
                ),
                _mandiItem(
                  'Basmati Rice',
                  '₹4,500 / Qtl',
                  'Amritsar Yard',
                  Colors.orange,
                ),
              ],
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
                  backgroundColor: Colors.purple,
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
                        _mandiLiveAds[_bottomAdIndex]['brand']!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        _mandiLiveAds[_bottomAdIndex]['msg']!,
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

  Widget _mandiItem(
    String title,
    String price,
    String location,
    Color trendColor,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple.shade50,
          child: const Icon(Icons.grass, color: Colors.purple),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(location),
        trailing: Text(
          price,
          style: TextStyle(
            color: trendColor,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
