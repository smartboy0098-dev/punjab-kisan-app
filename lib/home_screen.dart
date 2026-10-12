import 'dart:async';

import 'package:flutter/material.dart';

import 'ai_chat_screen.dart';
import 'khata_screen.dart';
import 'marketplace_screen.dart';
import 'mandi_weather_screen.dart';
import 'crop_doctor_screen.dart';
import 'transport_screen.dart';
import 'online_shop_screen.dart';
import 'main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _homeLiveAds = [
    {
      'brand': 'Swaraj Tractors',
      'msg': '🚜 Naya Swaraj 855 FE: 5-Saal Warranty ke sath aaj hi booking karein!',
    },
    {
      'brand': 'IFFCO Organic',
      'msg':
          '🌱 IFFCO Nano Urea: Kam karch mein dugna jhaad aur haryali payein.',
    },
  ];
  int _topAdIndex = 0, _bottomAdIndex = 1;
  Timer? _homeAdTimer;

  @override
  void initState() {
    super.initState();
    _homeAdTimer = Timer.periodic(const Duration(seconds: 5), (t) {
      if (mounted) {
        setState(() {
          _topAdIndex = (_topAdIndex + 1) % _homeLiveAds.length;
          _bottomAdIndex = (_bottomAdIndex + 1) % _homeLiveAds.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _homeAdTimer?.cancel();
    super.dispose();
  }

  void _showPopup(String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int crossCount = MediaQuery.of(context).size.width > 600 ? 3 : 2;
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        title: const Text('Punjab Kisan Home'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.gavel),
            onPressed: () => _showPopup(
              'Legal Support',
              'All transactions monitored. Fraud details will go to Punjab Police Cyber Cell.',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (c) => const SignUpScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: const Color(0xFF1E1E1E),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 16,
                  child: Icon(Icons.star, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _homeLiveAds[_topAdIndex]['brand']!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        _homeLiveAds[_topAdIndex]['msg']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 2,
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      border: Border.all(color: Colors.red.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'FRAUD ALERT: Never give advance money or OTP to anyone. Strict legal action against scammers.',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: crossCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.2,
                    children: [
                      _card(
                        Icons.shopping_bag,
                        'Marketplace',
                        Colors.orange.shade800,
                        const Color(0xFFFFF2EE),
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const MarketplaceScreen(),
                          ),
                        ),
                      ),
                      _card(
                        Icons.psychology,
                        'AI Kisan Sathi',
                        Colors.blue.shade800,
                        const Color(0xFFE8F5E9),
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const AiChatScreen(),
                          ),
                        ),
                      ),
                      _card(
                        Icons.menu_book,
                        'Kisan Khata',
                        Colors.brown.shade800,
                        const Color(0xFFFFF8E1),
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const KhataScreen(),
                          ),
                        ),
                      ),
                      _card(
                        Icons.cloud,
                        'Mandi & Weather',
                        Colors.purple.shade800,
                        const Color(0xFFF3E5F5),
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const MandiWeatherScreen(),
                          ),
                        ),
                      ),
                      _card(
                        Icons.camera_alt,
                        'AI Crop Doctor',
                        Colors.red.shade800,
                        const Color(0xFFFFEBEE),
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const CropDoctorScreen(),
                          ),
                        ),
                      ),
                      _card(
                        Icons.local_shipping,
                        'Kisan Transport',
                        Colors.blueGrey.shade800,
                        const Color(0xFFECEFF1),
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const TransportScreen(),
                          ),
                        ),
                      ),
                      _card(
                        Icons.storefront,
                        'Online Ghar Store',
                        Colors.teal.shade800,
                        const Color(0xFFE0F2F1),
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const OnlineShopScreen(),
                          ),
                        ),
                      ),
                      _card(
                        Icons.add_business,
                        'Ad Portal / ਵਿਗਿਆਪਨ',
                        Colors.indigo.shade800,
                        const Color(0xFFE8EAF6),
                        () => _showPopup(
                          'Business Ad Hub',
                          'Grow your brand with Punjab No.1 Portal!\nEmail: business@punjabkisanapp.com',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFE0F2F1),
                        child: Icon(Icons.support_agent, color: Colors.teal),
                      ),
                      title: const Text(
                        'Legal Help & Report Center',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      subtitle: const Text(
                        'Raise Fraud Ticket or Talk to AI Digital Lawyer',
                        style: TextStyle(fontSize: 11),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () => _showPopup(
                        'Help Center',
                        '1. Raise Fraud Ticket\n2. AI Digital Lawyer Framework',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            color: const Color(0xFF1E1E1E),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 16,
                  child: Icon(Icons.star, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _homeLiveAds[_bottomAdIndex]['brand']!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        _homeLiveAds[_bottomAdIndex]['msg']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 2,
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

  Widget _card(
    IconData icon,
    String title,
    Color contentColor,
    Color bgColor,
    VoidCallback tap,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: tap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: contentColor, size: 40),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: contentColor,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
