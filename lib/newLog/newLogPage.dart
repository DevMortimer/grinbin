import 'package:flutter/material.dart';

class NewLogPage extends StatelessWidget {
  const NewLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.arrow_right_alt_rounded,
          size: 32,
        ),
      ),
      body: Column(
        children: [
          const Center(
            child: Text(
              "How do you feel?",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 64),
          IconButton(
            icon: const Icon(
              Icons.emoji_emotions,
              size: 32,
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          IconButton(
            icon: const Icon(
              Icons.emoji_emotions,
              size: 32,
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          IconButton(
            icon: const Icon(
              Icons.emoji_emotions,
              size: 32,
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          IconButton(
            icon: const Icon(
              Icons.emoji_emotions,
              size: 32,
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          IconButton(
            icon: const Icon(
              Icons.emoji_emotions,
              size: 32,
            ),
            onPressed: () {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
