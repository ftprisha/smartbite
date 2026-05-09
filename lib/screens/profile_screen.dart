import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Me',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0B1F3A),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.settings,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile Header
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF0F9FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Color(0xFF1A56DB),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Dr. Priya Sharma',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF0B1F3A),
                      ),
                    ),
                    Text(
                      'Dental Surgeon · Clinic Name',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        fixedSize: Size.fromHeight(28),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF1A56DB),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '124',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0B1F3A),
                          ),
                        ),
                        Text(
                          'Scans',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: Color(0xFFE2E8F0),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '38',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0B1F3A),
                          ),
                        ),
                        Text(
                          'Patients',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    thickness: 1,
                    color: Color(0xFFE2E8F0),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '12',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0B1F3A),
                          ),
                        ),
                        Text(
                          'This Month',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Sensor & Device
              Text(
                'SENSOR & DEVICE',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 8),
              Card(
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.bluetooth,
                        color: Color(0xFF1A56DB),
                      ),
                      title: Text('Connected Sensor'),
                      subtitle: Text('SmartBite_Sensor'),
                      trailing: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Color(0xFF16A34A),
                          shape: BoxShape.circle,
                        ),
                      ),
                      onTap: () => context.push('/bluetooth'),
                    ),
                    Divider(height: 0),
                    ListTile(
                      leading: Icon(Icons.battery_full),
                      title: Text('Battery Level'),
                      trailing: Text(
                        '85%',
                        style: TextStyle(color: Color(0xFF16A34A)),
                      ),
                    ),
                    Divider(height: 0),
                    ListTile(
                      leading: Icon(Icons.sync),
                      title: Text('Last Sync'),
                      trailing: Text(
                        '2 minutes ago',
                        style: TextStyle(color: Color(0xFF64748B)),
                      ),
                    ),
                    Divider(height: 0),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Sensor Settings'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // App Settings
              Text(
                'APP SETTINGS',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 8),
              Card(
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Default Numbering'),
                      trailing: Text(
                        'FDI',
                        style: TextStyle(color: Color(0xFF1A56DB)),
                      ),
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: Text('Dark Mode'),
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: Text('Notifications'),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {},
                        activeColor: Color(0xFF1A56DB),
                      ),
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: Text('Language'),
                      trailing: Text(
                        'English',
                        style: TextStyle(color: Color(0xFF64748B)),
                      ),
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: Text('Data Privacy'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: Text('Normal Values Reference'),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Color(0xFF1A56DB),
                      ),
                      onTap: () => context.push('/normal-values'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Reports & Export
              Text(
                'REPORTS & EXPORT',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(height: 8),
              Card(
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Email Reports'),
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {},
                      ),
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: Text('Default Print Size'),
                      trailing: Text(
                        'A4',
                        style: TextStyle(color: Color(0xFF64748B)),
                      ),
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: Text('Export Format'),
                      trailing: Text(
                        'PDF',
                        style: TextStyle(color: Color(0xFF64748B)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Sign Out Button
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Color(0xFFDC2626)),
                ),
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Color(0xFFDC2626),
                  ),
                ),
              ),
              SizedBox(height: 8),
              // Delete Data Button
              TextButton(
                onPressed: () {},
                child: Text(
                  'Delete All Scan Data',
                  style: TextStyle(
                    color: Color(0xFFDC2626),
                    fontSize: 12,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Version Text
              Text(
                'SmartBite v1.0.0 · Build 2024',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF64748B),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}