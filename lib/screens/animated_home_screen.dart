import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import '../stores/quran_store.dart';
import '../widgets/navigation_card.dart';
import 'surah_page_view_screen.dart';
import 'ayah_screen.dart';

class AnimatedHomeScreen extends StatefulWidget {
  const AnimatedHomeScreen({super.key});

  @override
  _AnimatedHomeScreenState createState() => _AnimatedHomeScreenState();
}

class _AnimatedHomeScreenState extends State<AnimatedHomeScreen> {
  int _colorIndex = 0;

  @override
  void initState() {
    super.initState();
    _startColorAnimation();
  }

  void _startColorAnimation() {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() => _colorIndex = (_colorIndex + 1) % 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      Theme.of(context).primaryColor.withOpacity(0.3),
      Theme.of(context).primaryColor.withOpacity(0.1),
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _colorIndex == 0 ? colors : colors.reversed.toList(),
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                NavigationCard(
                  title: 'Sureler',
                  assetPath: 'assets/sure.png',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SurahPageViewScreen(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                NavigationCard(
                  title: 'Ayetler',
                  assetPath: 'assets/ayetmeal.png',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AyahScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
