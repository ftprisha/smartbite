import 'package:flutter/material.dart';
import '../models/scan_session.dart';

class HistoryProvider extends ChangeNotifier {
  List<ScanSession> sessions = [];

  Future<void> loadHistory() async {
    sessions = await ScanSession.loadAll();
    notifyListeners();
  }

  Future<void> addScan(ScanSession session) async {
    await ScanSession.addSession(session);
    sessions.add(session);
    notifyListeners();
  }

  Future<void> clearAll() async {
    await ScanSession.clearAll();
    sessions.clear();
    notifyListeners();
  }
}