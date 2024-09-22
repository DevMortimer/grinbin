import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SignalsMixin {
  late final currentIndex = signal(0);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.watch(context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_outlined),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Person",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            currentIndex.value = 0;
            Beamer.of(context).beamToNamed('/');
          } else if (index == 1) {
            currentIndex.value = 1;
          } else {
            currentIndex.value = 2;
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title / Greeting
            Text(
              'Hi',
              style: textTheme.displaySmall,
            ),
            Text(
              'Ryan',
              style: textTheme.displayMedium,
            ),

            // Statistics

            // Logs
          ],
        ),
      ),
    );
  }
}
