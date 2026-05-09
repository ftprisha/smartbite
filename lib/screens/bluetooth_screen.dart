import 'package:flutter/material.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF0B1F3A),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Connect Sensor',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B1F3A),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Skip',
              style: TextStyle(color: Color(0xFF1A56DB)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              // Animated Ripple Effect
              SizedBox(
                height: 280,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            // Outer circle
                            Container(
                              width: 240,
                              height: 240,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF1A56DB)
                                      .withOpacity(_controller.value * 0.3),
                                  width: 1,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            // Middle circle
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF1A56DB)
                                      .withOpacity(_controller.value * 0.6),
                                  width: 1.5,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                            // Inner circle
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF1A56DB)
                                      .withOpacity(_controller.value),
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    // Bluetooth Icon
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Color(0xFF0B1F3A),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.bluetooth,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Searching for SmartBite_Sensor',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                ),
              ),
              SizedBox(height: 24),
              // Sensor Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.bluetooth,
                          color: Color(0xFF1A56DB),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SmartBite_Sensor',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Color(0xFF0B1F3A),
                              ),
                            ),
                            Text(
                              'Digital Occlusal Sensor',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_isConnected)
                        Icon(
                          Icons.check_circle,
                          color: Color(0xFF16A34A),
                        )
                      else
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isConnected = true;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1A56DB),
                          ),
                          child: Text('Connect'),
                        ),
                    ],
                  ),
                ),
              ),
              if (_isConnected)
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF0FDF4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Color(0xFF16A34A),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Connected! Battery 85%',
                          style: TextStyle(
                            color: Color(0xFF16A34A),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 20),
              Divider(
                color: Color(0xFFE2E8F0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'or',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 12,
                  ),
                ),
              ),
              Divider(
                color: Color(0xFFE2E8F0),
              ),
              SizedBox(height: 16),
              // Simulator Mode Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: Color(0xFF1A56DB),
                      width: 2,
                    ),
                    backgroundColor: Color(0xFFEFF6FF),
                  ),
                  child: Text(
                    '🔬  Use Simulator Mode',
                    style: TextStyle(
                      color: Color(0xFF1A56DB),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Help Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Having trouble?',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View setup guide →',
                      style: TextStyle(
                        color: Color(0xFF1A56DB),
                        fontSize: 12,
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