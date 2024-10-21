import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
      ),
      backgroundColor: colorScheme.primaryContainer,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/grinbin.png', width: 128, height: 128),

              const Text(
                'Software Design Project\n\'Grinbin\'',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Members
              const Text(
                'Submitted by',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Asuncion, Andrei',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const Text(
                'Banzuela, Lemuel',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const Text(
                'Bautista, Kenneth',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              const Text(
                'Gapac, Ryan Joshua',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),

              // Submitted to
              const SizedBox(height: 16),
              const Text(
                'Submitted to',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Engr. Lech Walesa Navarra',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
