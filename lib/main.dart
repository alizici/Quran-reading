import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'stores/quran_store.dart';
import 'screens/animated_home_screen.dart';
import 'theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<QuranStore>(create: (_) => QuranStore()),
      ],
      child: MaterialApp(
        home: const AnimatedHomeScreen(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
