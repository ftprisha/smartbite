import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/bluetooth_screen.dart';
import '../screens/pre_scan_screen.dart';
import '../screens/live_scan_screen.dart';
import '../screens/results_screen.dart';
import '../screens/result_sheet_screen.dart';
import '../screens/history_screen.dart';
import '../screens/normal_values_screen.dart';
import '../screens/profile_screen.dart';
import '../models/scan_session.dart';

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: <RouteBase>[
    GoRoute(
      path: '/splash',
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: '/bluetooth',
      builder: (BuildContext context, GoRouterState state) {
        return BluetoothScreen();
      },
    ),
    GoRoute(
      path: '/pre-scan',
      builder: (BuildContext context, GoRouterState state) {
        return PreScanScreen();
      },
    ),
    GoRoute(
      path: '/live-scan',
      builder: (BuildContext context, GoRouterState state) {
        final patient = state.extra;
        return LiveScanScreen(patient: patient);
      },
    ),
    GoRoute(
      path: '/results',
      builder: (BuildContext context, GoRouterState state) {
        final scanSession = state.extra as ScanSession;
        return ResultsScreen(scanSession: scanSession);
      },
    ),
    GoRoute(
      path: '/result-sheet',
      builder: (BuildContext context, GoRouterState state) {
        final scanSession = state.extra as ScanSession;
        return ResultSheetScreen(scanSession: scanSession);
      },
    ),
    GoRoute(
      path: '/normal-values',
      builder: (BuildContext context, GoRouterState state) {
        return NormalValuesScreen();
      },
    ),
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BottomNavigationScaffold(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            return HomeScreen();
          },
        ),
        GoRoute(
          path: '/history',
          builder: (BuildContext context, GoRouterState state) {
            return HistoryScreen();
          },
        ),
        GoRoute(
          path: '/profile',
          builder: (BuildContext context, GoRouterState state) {
            return ProfileScreen();
          },
        ),
      ],
    ),
  ],
);

class BottomNavigationScaffold extends StatefulWidget {
  final Widget child;

  const BottomNavigationScaffold({required this.child});

  @override
  State<BottomNavigationScaffold> createState() =>
      _BottomNavigationScaffoldState();
}

class _BottomNavigationScaffoldState extends State<BottomNavigationScaffold> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/pre-scan');
        break;
      case 2:
        context.go('/history');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  int _getSelectedIndex(String location) {
    if (location.startsWith('/home')) {
      return 0;
    } else if (location.startsWith('/pre-scan')) {
      return 1;
    } else if (location.startsWith('/history')) {
      return 2;
    } else if (location.startsWith('/profile')) {
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    _selectedIndex = _getSelectedIndex(location);

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Color(0xFF1A56DB),
        unselectedItemColor: Color(0xFF94A3B8),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
      ),
    );
  }
}