import 'package:flutter/material.dart';

class NormalValuesScreen extends StatelessWidget {
  const NormalValuesScreen();

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
          'Normal Values',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0B1F3A),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF0D9488), width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  'Clinical Reference',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF0D9488),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.info_outline, color: Color(0xFF065F46), size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Reference ranges based on dental research 2023–2025. Use as clinical guide only.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF065F46),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'BITE FORCE (Newtons, N)',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildForceRow(Color(0xFF3B82F6), '<100 N', 'Weak Contact', 'Poor contact', ''),
                      Divider(),
                      _buildForceRow(Color(0xFF34D399), '100-200 N', 'Chewing Force', 'Normal eating', ''),
                      Divider(),
                      _buildForceRow(Color(0xFF22C55E), '200-650 N', 'Normal Max', 'Healthy bite', '✓'),
                      Divider(),
                      _buildForceRow(Color(0xFFF59E0B), '650-800 N', 'High Load', 'Heavy load', '⚠'),
                      Divider(),
                      _buildForceRow(Color(0xFFEF4444), '>800 N', 'Risk Zone', 'Possible bruxism', '!'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'BALANCE (Left/Right %)',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildBalanceRow(Color(0xFF22C55E), '45/55', 'Balanced'),
                      SizedBox(height: 8),
                      _buildBalanceRow(Color(0xFFF59E0B), '40/60', 'Mild Imbalance'),
                      SizedBox(height: 8),
                      _buildBalanceRow(Color(0xFFEF4444), '<40/>60', 'Severe Imbalance'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'CONTACT TIME (ms)',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildContactTimeRow(Color(0xFF22C55E), '<250 ms', 'Fast Contact'),
                      SizedBox(height: 8),
                      _buildContactTimeRow(Color(0xFF34D399), '250-500 ms', 'Normal Range'),
                      SizedBox(height: 8),
                      _buildContactTimeRow(Color(0xFFF59E0B), '>500 ms', 'Extended Contact'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'HIGH-PRESSURE POINTS',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildPressureRow(Color(0xFF22C55E), '1-5 pts', 'Optimal'),
                      SizedBox(height: 8),
                      _buildPressureRow(Color(0xFF34D399), '6-10 pts', 'Normal'),
                      SizedBox(height: 8),
                      _buildPressureRow(Color(0xFFF59E0B), '11-15 pts', 'Monitor'),
                      SizedBox(height: 8),
                      _buildPressureRow(Color(0xFFEF4444), '>15 pts', 'High Risk'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'TOOTH NUMBERING (FDI)',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF94A3B8),
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Upper Right',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0B1F3A),
                                    ),
                                  ),
                                  Text(
                                    '1x (11-18)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1A56DB),
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
                                color: Color(0xFFF5F3FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Upper Left',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0B1F3A),
                                    ),
                                  ),
                                  Text(
                                    '2x (21-28)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF7C3AED),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF0FDF4),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Lower Left',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0B1F3A),
                                    ),
                                  ),
                                  Text(
                                    '3x (31-38)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF059669),
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Lower Right',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF0B1F3A),
                                    ),
                                  ),
                                  Text(
                                    '4x (41-48)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFEA580C),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Center(
                        child: Text(
                          '26 = Upper Left First Molar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0B1F3A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Based on dental research (2023–2025)',
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFF94A3B8),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForceRow(Color color, String range, String label, String description, String badge) {
    return Row(
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8),
        Text(
          range,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        SizedBox(width: 8),
        Text(
          '=',
          style: TextStyle(
            color: Color(0xFF94A3B8),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B1F3A),
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
        if (badge.isNotEmpty)
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                badge,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildBalanceRow(Color color, String value, String label) {
    return Row(
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF0B1F3A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildContactTimeRow(Color color, String value, String label) {
    return Row(
      children: <Widget>[
        Icon(Icons.schedule, color: color, size: 18),
        SizedBox(width: 12),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF0B1F3A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPressureRow(Color color, String value, String label) {
    return Row(
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 12),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        SizedBox(width: 12),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFF0B1F3A),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}