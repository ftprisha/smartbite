import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../models/scan_session.dart';
import '../providers/scan_provider.dart';
import '../widgets/dental_arch_widget.dart';

class LiveScanScreen extends StatefulWidget {
  final dynamic patient;

  const LiveScanScreen({required this.patient});

  @override
  State<LiveScanScreen> createState() => _LiveScanScreenState();
}

class _LiveScanScreenState extends State<LiveScanScreen> {
  Timer? _timer;
  int _elapsed = 0;
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();
    context.read<ScanProvider>().startScan();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsed++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    context.read<ScanProvider>().stopScan();
    super.dispose();
  }

  void _showStopDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Stop Scan?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Stop'),
            ),
          ],
        );
      },
    );
  }

  void _stopAndAnalyse() {
    final scanProvider = context.read<ScanProvider>();
    final scanSession = scanProvider.stopScan();
    context.push('/results', extra: scanSession);
  }

  String _formatElapsedTime(int seconds) {
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    if (minutes > 0) {
      return '$minutes:${secs.toString().padLeft(2, '0')} min';
    } else {
      return '$secs.${((_elapsed % 10).toString())} s';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (!didPop) {
          _showStopDialog();
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF8FAFF),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFF0B1F3A)),
            onPressed: _showStopDialog,
          ),
          title: Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Color(0xFF059669),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Scanning...',
                style: TextStyle(
                  color: Color(0xFF059669),
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  _formatElapsedTime(_elapsed),
                  style: TextStyle(
                    color: Color(0xFF1A56DB),
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.patient.name ?? 'Patient',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.patient.condition ?? 'Routine Check',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    'Friday',
                    style: TextStyle(
                      color: Color(0xFF1A56DB),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Consumer<ScanProvider>(
                            builder: (context, scanProvider, child) {
                              return DentalArchWidget(
                                teeth: scanProvider.currentTeeth,
                                isLive: true,
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Balance',
                                    style: TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Consumer<ScanProvider>(
                                    builder: (BuildContext context, ScanProvider scanProvider, Widget? child) {
                                      final left = scanProvider.leftBalance.toStringAsFixed(0);
                                      final right = scanProvider.rightBalance.toStringAsFixed(0);
                                      return Text(
                                        '$left% / $right%',
                                        style: TextStyle(
                                          color: Color(0xFF1A56DB),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Left / Right',
                                    style: TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFFF7ED),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Peak Force',
                                    style: TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Consumer<ScanProvider>(
                                    builder: (BuildContext context, ScanProvider scanProvider, Widget? child) {
                                      return Text(
                                        '${scanProvider.peakForce.toStringAsFixed(1)} N',
                                        style: TextStyle(
                                          color: Color(0xFFD97706),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Newtons',
                                    style: TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFEF2F2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Pressure',
                                    style: TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 10,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Consumer<ScanProvider>(
                                    builder: (BuildContext context, ScanProvider scanProvider, Widget? child) {
                                      return Text(
                                        '${scanProvider.pressurePoints}',
                                        style: TextStyle(
                                          color: Color(0xFFDC2626),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Points',
                                    style: TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 9,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: _stopAndAnalyse,
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Color(0xFFDC2626),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Center(
                            child: Text(
                              '⏹  STOP & ANALYSE',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}