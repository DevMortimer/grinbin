import 'dart:developer';

import 'package:Grinbin/global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ViewLogPage extends StatelessWidget {
  ViewLogPage({super.key, required this.logToView});

  final Map<String, dynamic> logToView;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
      ),
      backgroundColor: colorScheme.primaryContainer,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Center(
                    child: Text(
                      "Viewing Log",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Container
                  Container(
                    width: 256,
                    decoration: BoxDecoration(
                      color: colorScheme.tertiaryContainer,
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
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Icon and how long ago
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FaIcon(
                                [
                                  FontAwesomeIcons.solidFaceSmileBeam,
                                  FontAwesomeIcons.solidFaceMeh,
                                  FontAwesomeIcons.solidFaceSadTear,
                                  FontAwesomeIcons.solidFaceAngry,
                                ][logToView['feeling']],
                                size: 48,
                              ),
                              Text(
                                calculateHowLongAgo(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          // Description
                          Text(
                            logToView['description'],
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Delete button
                      IconButton(
                        icon: const Icon(
                          Icons.delete_forever_rounded,
                          size: 32,
                        ),
                        onPressed: () async => await showAlertDialog(
                          context,
                          'Are you sure you want to delete log?',
                          title: "Confirm",
                          icon: const FaIcon(
                            FontAwesomeIcons.triangleExclamation,
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Cancel'),
                              onPressed: () => context.pop(),
                            ),
                            TextButton(
                              child: const Text('Confirm'),
                              onPressed: () async {
                                context.loaderOverlay.show();
                                await supabase
                                    .from('logs')
                                    .delete()
                                    .eq('id', logToView['id']);
                                context.loaderOverlay.hide();
                                context.pushReplacement('/');
                              },
                            ),
                          ],
                        ),
                      ),

                      // Edit button
                      IconButton(
                        icon: const Icon(
                          Icons.edit_rounded,
                          size: 32,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),

              // Metadata
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 256,
                    height: 256,
                    decoration: BoxDecoration(
                      color: colorScheme.tertiaryContainer,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Date
                        const Text('Date', style: TextStyle(fontSize: 18)),
                        Text(
                          '${getTime().day}/${getTime().month}/${getTime().year}',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),

                        // Time
                        const Text('Time', style: TextStyle(fontSize: 18)),
                        Text(
                          '${getTime().hour.toString().padLeft(2, '0')}:${getTime().minute}',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String calculateHowLongAgo() {
    print(logToView);
    DateTime created_date = DateTime.parse(logToView['created_at']);
    DateTime now = DateTime.now();
    Duration diff = now.difference(created_date);

    if (diff.inMinutes > 60) {
      return '${diff.inMinutes % 60} hours\nago';
    } else {
      return '${diff.inMinutes} minutes\nago';
    }
  }

  DateTime getTime() {
    return DateTime.parse(logToView['created_at']);
  }
}
