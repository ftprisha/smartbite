import 'package:flutter/material.dart';

class LiveScanScreen extends StatelessWidget {
  final dynamic patient;

  const LiveScanScreen({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Scan Screen'),
      ),
      body: Center(
        child: Text('Live Scan Screen'),
      ),
    );
  }
}