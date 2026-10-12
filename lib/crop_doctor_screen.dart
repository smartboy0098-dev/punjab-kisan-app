import 'dart:async';

import 'package:flutter/material.dart';

class CropDoctorScreen extends StatefulWidget {
  const CropDoctorScreen({super.key});
  @override
  State<CropDoctorScreen> createState() => _CropDoctorScreenState();
}

class _CropDoctorScreenState extends State<CropDoctorScreen> {
  final List<Map<String, String>> _cropLiveAds = [
    {
      'brand': 'Syngenta',
      'msg': '🐛 Amistar Top Fungicide: Kapaas aur tamatar ki chitti bimari ka 100% ilaaj!',
    },
    {
      'brand': 'Swaraj Tractors',
      'msg':
          '🚜 Naya Swaraj 855 FE: 5-Saal Warranty ke sath aaj hi book karein!',
    },
  ];
  int _topAdIndex = 0, _bottomAdIndex = 1;
  Timer? _adTimer;
  bool _scanning = false, _reportReady = false;

  @override
  void initState() {
    super.initState();
    _adTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _topAdIndex = (_topAdIndex + 1) % _cropLiveAds.length;
          _bottomAdIndex = (_bottomAdIndex + 1) % _cropLiveAds.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _adTimer?.cancel();
    super.dispose();
  }

  void _startScan() {
    setState(() {
      _scanning = true;
      _reportReady = false;
    });
    Timer(const Duration(seconds: 3), () {
      if (mounted)
        setState(() {
          _scanning = false;
          _reportReady = true;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEEEEE),
      appBar: AppBar(
        title: const Text('AI Crop Doctor / ਫਸਲ ਡਾਕਟਰ'),
        backgroundColor: Colors.red.shade700,
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
                  backgroundColor: Colors.red,
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
                        _cropLiveAds[_topAdIndex]['brand']!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        _cropLiveAds[_topAdIndex]['msg']!,
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.red.shade200, width: 2),
                    ),
                    child: _scanning
                        ? const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(color: Colors.red),
                                SizedBox(height: 12),
                                Text('AI Analyzing Crop Leaves Registry...'),
                              ],
                            ),
                          )
                        : Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 72,
                              color: Colors.red.shade300,
                            ),
                          ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _scanning ? null : _startScan,
                    icon: const Icon(
                      Icons.document_scanner,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Click Photo & Scan Disease',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  if (_reportReady) ...[
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '🔴 bimari detected: Yellow Rust / ਪੀਲੀ ਕੁੰਗੀ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade900,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Remedy Solution: Spray Propiconazole 25% EC directly. Water field layout smoothly.',
                            style: TextStyle(fontSize: 12, height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
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
                  backgroundColor: Colors.red,
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
                        _cropLiveAds[_bottomAdIndex]['brand']!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        _cropLiveAds[_bottomAdIndex]['msg']!,
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
