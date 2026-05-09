import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ToothData {
  final int fdiNumber;
  final double forceN;
  final bool isHighlighted;

  ToothData({
    required this.fdiNumber,
    required this.forceN,
    required this.isHighlighted,
  });

  factory ToothData.fromJson(Map<String, dynamic> json) {
    return ToothData(
      fdiNumber: json['fdiNumber'] as int,
      forceN: (json['forceN'] as num).toDouble(),
      isHighlighted: json['isHighlighted'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fdiNumber': fdiNumber,
      'forceN': forceN,
      'isHighlighted': isHighlighted,
    };
  }
}

class Patient {
  final String id;
  final String name;
  final int age;
  final String condition;
  final DateTime date;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.condition,
    required this.date,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as int,
      condition: json['condition'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'condition': condition,
      'date': date.toIso8601String(),
    };
  }
}

class ScanSession {
  final String id;
  final String patientName;
  final String patientId;
  final String condition;
  final DateTime scannedAt;
  final List<ToothData> teeth;
  final int durationSeconds;
  final double peakForce;
  final double leftBalance;
  final double rightBalance;
  final int pressurePoints;

  ScanSession({
    required this.id,
    required this.patientName,
    required this.patientId,
    required this.condition,
    required this.scannedAt,
    required this.teeth,
    required this.durationSeconds,
    required this.peakForce,
    required this.leftBalance,
    required this.rightBalance,
    required this.pressurePoints,
  });

  factory ScanSession.fromJson(Map<String, dynamic> json) {
    final teethJson = json['teeth'] as List<dynamic>? ?? <dynamic>[];
    return ScanSession(
      id: json['id'] as String,
      patientName: json['patientName'] as String,
      patientId: json['patientId'] as String,
      condition: json['condition'] as String,
      scannedAt: DateTime.parse(json['scannedAt'] as String),
      teeth: teethJson
          .map((e) => ToothData.fromJson(e as Map<String, dynamic>))
          .toList(),
      durationSeconds: json['durationSeconds'] as int,
      peakForce: (json['peakForce'] as num).toDouble(),
      leftBalance: (json['leftBalance'] as num).toDouble(),
      rightBalance: (json['rightBalance'] as num).toDouble(),
      pressurePoints: json['pressurePoints'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientName': patientName,
      'patientId': patientId,
      'condition': condition,
      'scannedAt': scannedAt.toIso8601String(),
      'teeth': teeth.map((t) => t.toJson()).toList(),
      'durationSeconds': durationSeconds,
      'peakForce': peakForce,
      'leftBalance': leftBalance,
      'rightBalance': rightBalance,
      'pressurePoints': pressurePoints,
    };
  }

  /// Helper: encode to JSON string for storing in SharedPreferences
  String toJsonString() => jsonEncode(toJson());

  /// Helper: decode from a JSON string retrieved from SharedPreferences
  static ScanSession fromJsonString(String jsonString) {
    final Map<String, dynamic> map = jsonDecode(jsonString) as Map<String, dynamic>;
    return ScanSession.fromJson(map);
  }

  // SharedPreferences helpers (key: 'scan_history')
  static const String _storageKey = 'scan_history';

  static Future<List<ScanSession>> loadAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_storageKey);
    if (jsonString == null || jsonString.isEmpty) {
      return <ScanSession>[];
    }
    final List<dynamic> list = jsonDecode(jsonString) as List<dynamic>;
    return list
        .map((e) => ScanSession.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> saveAll(List<ScanSession> sessions) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> mapped =
        sessions.map((s) => s.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(mapped));
  }

  static Future<void> addSession(ScanSession session) async {
    final List<ScanSession> existing = await loadAll();
    existing.add(session);
    await saveAll(existing);
  }

  static Future<void> deleteSession(String id) async {
    final List<ScanSession> existing = await loadAll();
    existing.removeWhere((s) => s.id == id);
    await saveAll(existing);
  }

  static Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }
}
