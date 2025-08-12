import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/ac_provider.dart';

void main() {
  runApp(const AirConditionControlApp());
}

class AirConditionControlApp extends StatelessWidget {
  const AirConditionControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ACProvider(),
      child: MaterialApp(
        title: 'AC Control',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          brightness: Brightness.dark,
          colorScheme: ColorScheme.dark(
            primary: Colors.blue.shade400,
            secondary: Colors.cyan.shade400,
            surface: const Color(0xFF1E1E1E),
            background: const Color(0xFF121212),
            onSurface: Colors.white,
            onBackground: Colors.white,
          ),
          scaffoldBackgroundColor: const Color(0xFF121212),
          cardColor: const Color(0xFF1E1E1E),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1E1E1E),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
