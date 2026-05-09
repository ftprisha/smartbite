import 'package:flutter/material.dart';
import '../models/scan_session.dart';

class ResultsScreen extends StatelessWidget {
  final ScanSession scanSession;

  const ResultsScreen({required this.scanSession});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results Screen'),
      ),
      body: Center(
        child: Text('Results Screen'),
      ),
    );
  }
}