import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smartbite/widgets/dental_arch_widget.dart';
import 'package:smartbite/models/scan_session.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedMode = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SmartBite', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0B1F3A))),
              Text('Digital Occlusal Sensor', style: TextStyle(fontSize: 9, color: Color(0xFF64748B))),
            ],
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications_outlined, color: Color(0xFF64748B)), onPressed: () {}),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(radius: 16, backgroundColor: Color(0xFF1A56DB), child: Icon(Icons.person, color: Colors.white, size: 16)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMode = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMode == 0 ? Color(0xFF1A56DB) : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.chair,
                                color: _selectedMode == 0 ? Colors.white : Color(0xFF64748B),
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Chairside Mode',
                                style: TextStyle(
                                  color: _selectedMode == 0 ? Colors.white : Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMode = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedMode == 1 ? Color(0xFF1A56DB) : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.bar_chart,
                                color: _selectedMode == 1 ? Colors.white : Color(0xFF64748B),
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Analysis Mode',
                                style: TextStyle(
                                  color: _selectedMode == 1 ? Colors.white : Color(0xFF64748B),
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
              SizedBox(height: 16),
              // Temporary DentalArchWidget for testing
              SizedBox(
                height: 200,
                child: DentalArchWidget(
                  teeth: List.generate(
                    32,
                    (i) => ToothData(
                      fdiNumber: i + 11,
                      forceN: (i * 30).toDouble(),
                      isHighlighted: false,
                    ),
                  ),
                  isLive: false,
                ),
              ),
              SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Color(0xFF059669),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Sensor: Connected',
                                style: TextStyle(
                                  color: Color(0xFF059669),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: <Widget>[
                              Container(
                                width: 60,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Color(0xFF059669),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Battery: 85%',
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.signal_cellular_alt,
                        color: Color(0xFF059669),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  context.push('/pre-scan');
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFF1D6AFF), Color(0xFF0A3FCC)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      '▶  START SCAN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'SENSOR STATUS',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
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
                                  'Connected',
                                  style: TextStyle(
                                    color: Color(0xFF059669),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'SCAN STATUS',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color(0xFF64748B),
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Color(0xFF1A56DB),
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Ready',
                                  style: TextStyle(
                                    color: Color(0xFF1A56DB),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Mode Overview',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0B1F3A),
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Card(
                      color: Color(0xFFEFF6FF),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.chair,
                              color: Color(0xFF1A56DB),
                              size: 32,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Chairside Mode',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1F3A),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Perform and review scans chairside',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF64748B),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Card(
                      color: Color(0xFFF5F3FF),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.bar_chart,
                              color: Color(0xFF7C3AED),
                              size: 32,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Analysis Mode',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0B1F3A),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Study and compare bite reports',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF64748B),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}