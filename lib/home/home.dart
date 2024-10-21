import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title / Greeting
          const Padding(
            padding: EdgeInsets.only(left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Ryan',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

          // Statistics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Transform.rotate(
                  angle: -pi / 2,
                  child: const Text(
                    'Statistics',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // The statistics card
              SlideInRight(
                from: 300,
                duration: const Duration(milliseconds: 800),
                child: Container(
                  width: 256,
                  height: 256,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer,
                    border: Border.all(),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        blurStyle: BlurStyle.normal,
                        color: Colors.black,
                        offset: Offset(0, 8),
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // You have made
                      Text('You have made'),
                      // TODO

                      // In the past
                      Text('In the past')
                      // TODO
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 64),

          // Logs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // The logs card
              SlideInLeft(
                from: 300,
                duration: const Duration(milliseconds: 800),
                child: Container(
                  width: 256,
                  height: 256,
                  decoration: BoxDecoration(
                    color: colorScheme.tertiaryContainer,
                    border: Border.all(),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        blurStyle: BlurStyle.normal,
                        color: Colors.black,
                        offset: Offset(0, 8),
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Your latest log Input'),
                      // TODO
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 64),
                child: Transform.rotate(
                  angle: pi / 2,
                  child: const Text(
                    'Logs',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
