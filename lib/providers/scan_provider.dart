import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/scan_session.dart';

class ScanProvider extends ChangeNotifier {
  List<ToothData> currentTeeth = [];
  double peakForce = 0.0;
  double leftBalance = 0.0;
  double rightBalance = 0.0;
  int pressurePoints = 0;
  int elapsedSeconds = 0;
  bool isScanning = false;
  Timer? _scanTimer;

  void startScan() {
    isScanning = true;
    elapsedSeconds = 0;
    currentTeeth = [];
    peakForce = 0.0;
    leftBalance = 0.0;
    rightBalance = 0.0;
    pressurePoints = 0;
    notifyListeners();

    _scanTimer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      elapsedSeconds += 1;
      List<ToothData> newTeeth = [];
      double maxForce = 0.0;
      double leftSum = 0.0;
      double rightSum = 0.0;
      int leftCount = 0;
      int rightCount = 0;
      int points = 0;

      // FDI teeth: 11-18 upper right, 21-28 upper left, 31-38 lower left, 41-48 lower right
      List<int> fdiNumbers = [
        11,12,13,14,15,16,17,18, // upper right
        21,22,23,24,25,26,27,28, // upper left
        31,32,33,34,35,36,37,38, // lower left
        41,42,43,44,45,46,47,48  // lower right
      ];

      for (int fdi in fdiNumbers) {
        double force = 50 + Random().nextDouble() * 900; // 50 to 950
        bool highlighted = false;
        newTeeth.add(ToothData(fdiNumber: fdi, forceN: force, isHighlighted: highlighted));

        if (force > maxForce) maxForce = force;
        if (force > 100) points += 1;

        // Left side: 21-28, 31-38
        if (fdi >= 21 && fdi <= 28 || fdi >= 31 && fdi <= 38) {
          leftSum += force;
          leftCount += 1;
        } else {
          rightSum += force;
          rightCount += 1;
        }
      }

      currentTeeth = newTeeth;
      peakForce = maxForce;
      leftBalance = leftCount > 0 ? leftSum / leftCount : 0.0;
      rightBalance = rightCount > 0 ? rightSum / rightCount : 0.0;
      pressurePoints = points;

      notifyListeners();
    });
  }

  ScanSession stopScan() {
    _scanTimer?.cancel();
    isScanning = false;
    notifyListeners();

    return ScanSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      patientName: '',
      patientId: '',
      condition: '',
      scannedAt: DateTime.now(),
      teeth: currentTeeth,
      durationSeconds: elapsedSeconds,
      peakForce: peakForce,
      leftBalance: leftBalance,
      rightBalance: rightBalance,
      pressurePoints: pressurePoints,
    );
  }

  void resetScan() {
    _scanTimer?.cancel();
    currentTeeth = [];
    peakForce = 0.0;
    leftBalance = 0.0;
    rightBalance = 0.0;
    pressurePoints = 0;
    elapsedSeconds = 0;
    isScanning = false;
    notifyListeners();
  }
}