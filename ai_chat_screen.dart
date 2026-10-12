import 'dart:async';

import 'package:flutter/material.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});
  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final List<Map<String, String>> _aiLiveAds = [
    {
      'brand': 'Bayer CropScience',
      'msg': '🐛 Nativo Fungicide: Dhan aur kanak ki fasal ko chitti kungi se bachayein!',
    },
    {
      'brand': 'Mahindra Tractors',
      'msg': '🚜 Mahindra Arjuna Novo: Kam diesel mein sabse zyada kheech aur takat!',
    },
  ];
  int _topAdIndex = 0, _bottomAdIndex = 1;
  Timer? _adTimer;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _adTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _topAdIndex = (_topAdIndex + 1) % _aiLiveAds.length;
          _bottomAdIndex = (_bottomAdIndex + 1) % _aiLiveAds.length;
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
      backgroundColor: const Color(0xFFEDF4F9),
      appBar: AppBar(
        title: const Text('AI Kisan Sathi / ਏ.ਆਈ. ਸਹਾਇਕ'),
        backgroundColor: Colors.blue.shade700,
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
                  backgroundColor: Colors.blue,
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
                        _aiLiveAds[_topAdIndex]['brand']!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        _aiLiveAds[_topAdIndex]['msg']!,
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
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.psychology,
                          size: 80,
                          color: Colors.blue.shade700,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'AI Kisan Voice Engine Active',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Press microphone and speak in Punjabi, English, or Hindi.\nਬੋਲਣ ਲਈ ਮਾਈਕ੍ਰੋਫੋਨ ਦਬਾਓ।',
                          textAlign: CenterTextAlignment,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  GestureDetector(
                    onTap: () => setState(() {
                      _isListening = !_isListening;
                    }),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: _isListening
                          ? Colors.red
                          : Colors.blue.shade700,
                      child: Icon(
                        _isListening ? Icons.mic : Icons.mic_none,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _isListening
                        ? '🎙️ Listening to Voice input... / ਸੁਣ ਰਿਹਾ ਹੈ...'
                        : 'Tap to Speak',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _isListening ? Colors.red : Colors.blue.shade700,
                    ),
                  ),
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
                  backgroundColor: Colors.blue,
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
                        _aiLiveAds[_bottomAdIndex]['brand']!.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        _aiLiveAds[_bottomAdIndex]['msg']!,
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

const CenterTextAlignment = TextAlign.center;
