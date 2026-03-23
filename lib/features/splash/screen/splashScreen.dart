import 'package:flutter/material.dart';
import 'dart:async';

import '../../../core/network/cache_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final token = CacheHelper.getData("token");

    print("cached token: $token");

    final bool hasValidToken =
        token != null && token.toString().trim().isNotEmpty;

    if (hasValidToken) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/alhamdsplash.png',
          width: 180,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.broken_image, size: 80, color: Colors.grey);
          },
        ),
      ),
    );
  }
}