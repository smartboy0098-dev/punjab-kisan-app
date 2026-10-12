import 'dart:async';

import 'package:flutter/material.dart';

class OnlineShopScreen extends StatefulWidget {
  const OnlineShopScreen({super.key});
  @override
  State<OnlineShopScreen> createState() => _OnlineShopScreenState();
}

class _OnlineShopScreenState extends State<OnlineShopScreen> {
  final List<Map<String, String>> _shopLiveAds = [
    {
      'brand': 'Swaraj Tractors',
      'msg':
          '🚜 Swaraj 744 FE: Har kisan ki pehli pasand, aaj hi booking karein!',
    },
    {
      'brand': 'Bayer Crop',
      'msg': '🌱 Nativo Fungicide: Fasal ki suraksha day-one se lock!',
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
          _topAdIndex = (_topAdIndex + 1) % _shopLiveAds.length;
          _bottomAdIndex = (_bottomAdIndex + 1) % _shopLiveAds.length;
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
      backgroundColor: const Color(0xFFE0F2F1),
      appBar: AppBar(
        title: const Text('Online Ghar Store / ਘਰ ਸਟੋਰ'),
        backgroundColor: Colors.teal.shade700,
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
                  backgroundColor: Colors.teal,
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
                        _shopLiveAds[_topAdIndex]['brand']!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        _shopLiveAds[_topAdIndex]['msg']!,
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
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
              children: [
                _shopCard(
                  'Samsung 32" LED TV',
                  '₹7,500',
                  'Used 2 yrs | Condition 9/10',
                  Icons.tv,
                ),
                _shopCard(
                  'Godrej Refrigerator',
                  '₹11,200',
                  'Double Door | 240 Liters',
                  Icons.kitchen,
                ),
                _shopCard(
                  'Bajaj Mixer Grinder',
                  '₹1,800',
                  'Brand New | 3 Jars Box',
                  Icons.blender,
                ),
                _shopCard(
                  'Orient Ceiling Fan',
                  '₹1,200',
                  'High Speed | 1 yr warranty',
                  Icons.wind_power,
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
                  backgroundColor: Colors.teal,
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
                        _shopLiveAds[_bottomAdIndex]['brand']!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        _shopLiveAds[_bottomAdIndex]['msg']!,
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

  Widget _shopCard(String title, String price, String details, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: Colors.teal.shade700),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            details,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: TextStyle(
              color: Colors.teal.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
