import 'dart:developer';

import 'package:Grinbin/global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LogsPage extends StatelessWidget {
  LogsPage({super.key, required this.logs});

  final List<Map<String, dynamic>> logs;

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
            children: [
              const Center(
                child: Text(
                  "Logs",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // List of logs
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    child: InkWell(
                      onTap: () => context.push('/viewLog', extra: logs[index]),
                      child: SizedBox(
                        height: 128,
                        child: Card.filled(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                // Icon
                                Hero(
                                  tag:
                                      "${logs[index]['description']}_${logs[index]['feeling']}",
                                  child: FaIcon(
                                    [
                                      FontAwesomeIcons.solidFaceSmileBeam,
                                      FontAwesomeIcons.solidFaceMeh,
                                      FontAwesomeIcons.solidFaceSadTear,
                                      FontAwesomeIcons.solidFaceAngry,
                                    ][logs[index]['feeling']],
                                    size: 48,
                                    color: [
                                      Colors.yellow[800],
                                      Colors.grey,
                                      Colors.blue,
                                      Colors.red,
                                    ][logs[index]['feeling']],
                                  ),
                                ),
                                const SizedBox(width: 16),

                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Description
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        logs[index]['description'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),

                                    // Date
                                    Text(
                                      '${getDate(index).day}/${getDate(index).month}/${getDate(index).year}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime getDate(int index) {
    return DateTime.parse(logs[index]['created_at']);
  }
}
