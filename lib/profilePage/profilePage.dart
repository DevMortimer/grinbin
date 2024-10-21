import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: colorScheme.primaryContainer,
      body: const Column(
        children: [],
      ),
    );
  }
}
