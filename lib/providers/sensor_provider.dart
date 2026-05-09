import 'package:flutter/material.dart';
import '../models/scan_session.dart';

class SensorProvider extends ChangeNotifier {
  bool isConnected = false;
  bool isSimulatorMode = false;
  int batteryLevel = 85;
  String sensorName = 'SmartBite_Sensor';

  void connect() {
    isConnected = true;
    notifyListeners();
  }

  void disconnect() {
    isConnected = false;
    notifyListeners();
  }

  void useSimulator() {
    isSimulatorMode = true;
    isConnected = true;
    notifyListeners();
  }
}