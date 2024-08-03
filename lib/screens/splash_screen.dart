import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 80), // add padding to the top
          Center(
            child: SizedBox(
              width: 200, // specify the desired width
              height: 200, // specify the desired height
              child: Image.asset(
                'assets/images/splash_logo.png',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 20.0), // add padding to the bottom
            child: Text('Youtube',
                style: TextStyle(
                  fontSize: 16,
                )),
          ),
        ],
      ),
    );
  }
}
