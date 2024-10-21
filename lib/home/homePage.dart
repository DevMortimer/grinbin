import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:Grinbin/home/home.dart';
import 'package:Grinbin/newLog/newLogPage.dart';
import 'package:Grinbin/profilePage/profilePage.dart';
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
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
      ),
      backgroundColor: colorScheme.primaryContainer,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: colorScheme.primaryContainer,
        currentIndex: currentIndex.watch(context),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_outlined),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            currentIndex.value = 0;
          } else if (index == 1) {
            currentIndex.value = 1;
          } else {
            currentIndex.value = 2;
          }
        },
      ),
      body: <Widget>[
        const Home(),
        const NewLogPage(),
        const ProfilePage(),
      ][currentIndex.value],
    );
  }
}
