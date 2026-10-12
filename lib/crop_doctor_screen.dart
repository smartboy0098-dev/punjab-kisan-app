import 'package:flutter/material.dart';

class CropDoctorScreen extends StatefulWidget {
  const CropDoctorScreen({super.key});
  @override
  State<CropDoctorScreen> createState() => _CropDoctorScreenState();
}

class _CropDoctorScreenState extends State<CropDoctorScreen> {
  bool _scanning = false, _report = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Crop Doctor'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 64, color: Colors.red.shade700),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => setState(() => _report = true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
              ),
              child: const Text(
                'Start AI Diagnosis',
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (_report)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  '• Issue Detected: Yellow Rust Disease / ਪੀਲੀ ਕੁੰਗੀ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
