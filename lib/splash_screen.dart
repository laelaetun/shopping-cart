import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/application/auth/auth_bloc.dart';
import 'package:shopping_cart/application/auth/auth_state.dart';
import 'package:shopping_cart/firebase/f_login.dart';
import 'package:shopping_cart/firebase/f_register.dart';
import 'package:shopping_cart/home/view/home_page.dart';
import 'package:shopping_cart/home/view/login_page.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // 1. Initialize the controller
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    // 2. Define a Curved Animation (Elastic feel)
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    // 3. Start the animation
    _controller.forward();

    // 4. Navigate to AuthRouter after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const FLogin()));
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Always clean up controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C), // Dark professional theme
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Your Logo (Use an Image.asset or Icon)
              const Icon(Icons.bolt, size: 100, color: Colors.blueAccent),
              const SizedBox(height: 20),
              const Text(
                "FLUTTER APP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthRouter extends StatelessWidget {
  const AuthRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      // Listen for specific side effects like errors or success snacks
      listener: (context, state) {},
      // Build the UI based on the current state
      builder: (context, state) {
        if (state is Authenticated) {
          return HomePage();
        }

        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is Unauthenticated) {
          return const LoginPage();
        }

        // Splash screen while checking token on boot
        return const Scaffold(body: Center(child: Text("Initializing...")));
      },
    );
  }
}
