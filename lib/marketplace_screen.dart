import 'dart:async';

import 'package:flutter/material.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});
  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  final List<Map<String, dynamic>> _crops = [
    {
      'crop': 'Premium Wheat / ਕਣਕ',
      'rate': '₹2,325 / Qtl',
      'mandi': 'Ludhiana Mandi',
      'isPremium': true,
    },
    {
      'crop': 'Organic Basmati Rice',
      'rate': '₹4,200 / Qtl',
      'mandi': 'Amritsar Market',
      'isPremium': false,
    },
  ];
  final List<Map<String, dynamic>> _tools = [
    {
      'name': 'Swaraj 744 FE Tractor 🚜',
      'price': '₹4,50,000',
      'mandi': 'Bathinda Area',
      'isPremium': true,
    },
  ];
  final List<Map<String, String>> _marketLiveAds = [
    {
      'brand': 'IFFCO Fertilizer',
      'msg':
          '🌱 IFFCO Nano Urea: Kam karch mein dugna jhaad aur haryali payein.',
    },
    {
      'brand': 'Swaraj Tractors',
      'msg': '🚜 Naya Swaraj 855 FE: 5-Saal Warranty ke sath aaj hi booking karein!',
    },
  ];

  int _topAdIndex = 0, _bottomAdIndex = 1;
  Timer? _marketAdTimer;
  final _nameCtrl = TextEditingController(),
      _priceCtrl = TextEditingController(),
      _locCtrl = TextEditingController();
  bool _isPremiumRequested = false;

  @override
  void initState() {
    super.initState();
    _marketAdTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _topAdIndex = (_topAdIndex + 1) % _marketLiveAds.length;
          _bottomAdIndex = (_bottomAdIndex + 1) % _marketLiveAds.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _marketAdTimer?.cancel();
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _locCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kisan Marketplace / ਮੰਡੀ'),
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.grass), text: 'Buy Crops'),
              Tab(icon: Icon(Icons.add_circle_outline), text: 'Sell Crop'),
              Tab(icon: Icon(Icons.agriculture), text: 'Buy Tools'),
              Tab(icon: Icon(Icons.add_box), text: 'Sell Tool'),
            ],
          ),
        ),
        body: Column(
          children: [
            _adBox(
              _marketLiveAds[_topAdIndex]['brand']!,
              _marketLiveAds[_topAdIndex]['msg']!,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buyCrops(),
                  _sellForm(true),
                  _buyTools(),
                  _sellForm(false),
                ],
              ),
            ),
            _adBox(
              _marketLiveAds[_bottomAdIndex]['brand']!,
              _marketLiveAds[_bottomAdIndex]['msg']!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _adBox(String brand, String msg) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      color: const Color(0xFF1E1E1E),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.orange,
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
                  brand.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
                Text(
                  msg,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Text('Ad', style: TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buyCrops() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _crops.length,
      itemBuilder: (c, i) => _listCard(
        _crops[i]['crop'],
        _crops[i]['mandi'],
        _crops[i]['rate'],
        _crops[i]['isPremium'],
        Icons.grass,
      ),
    );
  }

  Widget _buyTools() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _tools.length,
      itemBuilder: (c, i) => _listCard(
        _tools[i]['name'],
        _tools[i]['mandi'],
        _tools[i]['price'],
        _tools[i]['isPremium'],
        Icons.construction,
      ),
    );
  }

  Widget _listCard(
    String title,
    String sub,
    String price,
    bool prem,
    IconData icon,
  ) {
    return Card(
      elevation: prem ? 4 : 1,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: prem ? Colors.orange : Colors.transparent,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.orange),
        title: Row(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (prem) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'URGENT ⚡',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(sub),
        trailing: Text(
          price,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _sellForm(bool isCrop) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            isCrop
                ? 'Sell Your Crop / ਫਸਲ ਵੇਚੋ'
                : 'Sell Your Machine / ਸੰਦ ਵੇਚੋ',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameCtrl,
            decoration: InputDecoration(
              labelText: isCrop ? 'Crop Name' : 'Machine Name',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _priceCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Expected Price',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _locCtrl,
            decoration: const InputDecoration(
              labelText: 'Mandi Location',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              border: Border.all(color: Colors.orange.shade200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CheckboxListTile(
              title: const Text(
                '✨ Get Urgent Featured Badge (₹49 Only)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              value: _isPremiumRequested,
              onChanged: (v) {
                setState(() {
                  _isPremiumRequested = v ?? false;
                });
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_nameCtrl.text.isEmpty || _priceCtrl.text.isEmpty) return;
              setState(() {
                if (isCrop) {
                  _crops.insert(0, {
                    'crop': _nameCtrl.text,
                    'rate': '₹${_priceCtrl.text} / Qtl',
                    'mandi': _locCtrl.text,
                    'isPremium': _isPremiumRequested,
                  });
                } else {
                  _tools.insert(0, {
                    'name': _nameCtrl.text,
                    'price': '₹${_priceCtrl.text}',
                    'mandi': _locCtrl.text,
                    'isPremium': _isPremiumRequested,
                  });
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _isPremiumRequested
                        ? 'Firebase Node: Syncing ₹49 Premium Gateway...'
                        : 'Listing uploaded to cloud!',
                  ),
                ),
              );
              _nameCtrl.clear();
              _priceCtrl.clear();
              _locCtrl.clear();
              setState(() {
                _isPremiumRequested = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            child: const Text(
              'Submit Listing',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
