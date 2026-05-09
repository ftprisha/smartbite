import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/theme.dart';
import 'app/router.dart';
import 'providers/sensor_provider.dart';
import 'providers/scan_provider.dart';
import 'providers/history_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartBiteApp());
}

class SmartBiteApp extends StatelessWidget {
  const SmartBiteApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<SensorProvider>(
          create: (BuildContext context) => SensorProvider(),
        ),
        ChangeNotifierProvider<ScanProvider>(
          create: (BuildContext context) => ScanProvider(),
        ),
        ChangeNotifierProvider<HistoryProvider>(
          create: (BuildContext context) => HistoryProvider(),
        ),
      ],
      child: MaterialApp.router(
        title: 'SmartBite',
        theme: AppTheme.lightTheme,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
