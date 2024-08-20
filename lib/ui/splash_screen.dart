import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/route_manager.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/res/size_box_extension.dart';
import 'package:todo_app/ui/bottom_nav/bottom_nav.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _scaleAnimation;
  Animation<double>? _fadeAnimation;
  Animation<Offset>? _slideAnimation;

  final Color _iconColor = MyColors.color;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOutBack,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut,
    ));

    _controller!.forward();

    Timer(const Duration(seconds: 4), () {
      Get.offAll(const BottomNav());
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: Get.height* 0.18,),
          Image.asset('images/app_icon.png',height: Get.height * 0.12),
          SizedBox(height: Get.height* 0.15),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation!,
              child: ScaleTransition(
                scale: _scaleAnimation!,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App logo/icon with rotation effect and color change
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(_controller!),
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 100.0,
                        color: _iconColor,
                      ),
                    ),
                    20.kH,
                    // App name
                     const Text(
                      "Todo Master",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: MyColors.color,
                      ),
                    ),
                    10.kH,
                    // Tagline with slide-in effect
                    SlideTransition(
                      position: _slideAnimation!,
                      child: const Text(
                        "Stay Organized, Stay Productive",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: MyColors.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
