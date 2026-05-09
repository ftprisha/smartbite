import 'package:flutter/material.dart';
import '../models/scan_session.dart';

class ResultSheetScreen extends StatelessWidget {
  final ScanSession scanSession;

  const ResultSheetScreen({required this.scanSession});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Sheet Screen'),
      ),
      body: Center(
        child: Text('Result Sheet Screen'),
      ),
    );
  }
}