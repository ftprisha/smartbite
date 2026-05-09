import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/scan_session.dart';

class PreScanScreen extends StatefulWidget {
  const PreScanScreen();

  @override
  State<PreScanScreen> createState() => _PreScanScreenState();
}

class _PreScanScreenState extends State<PreScanScreen> {
  late TextEditingController _patientIdController;
  late TextEditingController _nameController;
  late TextEditingController _conditionController;
  int _age = 25;
  bool _autoStop = true;

  @override
  void initState() {
    super.initState();
    _patientIdController = TextEditingController();
    _nameController = TextEditingController();
    _conditionController = TextEditingController();
  }

  @override
  void dispose() {
    _patientIdController.dispose();
    _nameController.dispose();
    _conditionController.dispose();
    super.dispose();
  }

  void _decreaseAge() {
    setState(() {
      if (_age > 1) _age--;
    });
  }

  void _increaseAge() {
    setState(() {
      _age++;
    });
  }

  void _proceedToScan() {
    final patient = Patient(
      id: _patientIdController.text,
      name: _nameController.text,
      age: _age,
      condition: _conditionController.text,
      date: DateTime.now(),
    );
    context.push('/live-scan', extra: patient);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF0B1F3A)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'New Scan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B1F3A),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'PATIENT INFORMATION',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF94A3B8),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _patientIdController,
                        decoration: InputDecoration(
                          hintText: 'e.g. P045',
                          labelText: 'Patient ID',
                          border: InputBorder.none,
                        ),
                      ),
                      Divider(),
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Full name',
                          labelText: 'Patient Name',
                          border: InputBorder.none,
                        ),
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Text(
                            'Age',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: _decreaseAge,
                              ),
                              Text(
                                '$_age',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: _increaseAge,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Text(
                            'Condition',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            child: TextField(
                              controller: _conditionController,
                              decoration: InputDecoration(
                                hintText: 'Crown check, bruxism...',
                                border: InputBorder.none,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'SCAN SETTINGS',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF94A3B8),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Auto-Stop',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Switch(
                            value: _autoStop,
                            onChanged: (bool value) {
                              setState(() {
                                _autoStop = value;
                              });
                            },
                            activeColor: Color(0xFF1A56DB),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Text(
                            'Grid Size',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '8×8',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A56DB),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: _proceedToScan,
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
                      '→  Proceed to Scan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  'Sensor Connected · SmartBite_Sensor',
                  style: TextStyle(
                    color: Color(0xFF059669),
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}