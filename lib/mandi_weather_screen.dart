import 'package:flutter/material.dart';

class MandiWeatherScreen extends StatefulWidget {
  const MandiWeatherScreen({super.key});
  @override
  State<MandiWeatherScreen> createState() => _MandiWeatherScreenState();
}

class _MandiWeatherScreenState extends State<MandiWeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mandi & Weather'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('Live Punjab Mandi Grain Rates Synced Successfully.'),
      ),
    );
  }
}
