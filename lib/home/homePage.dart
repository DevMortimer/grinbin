import 'dart:developer';
import 'dart:math';

import 'package:Grinbin/global.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:redacted/redacted.dart';
import 'package:signals/signals_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.user});

  User? user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final FutureSignal<Map<String, dynamic>> user;
  late final FutureSignal<List<Map<String, dynamic>>> logs;

  @override
  void initState() {
    super.initState();
    user = FutureSignal<Map<String, dynamic>>(
      () async => await getUser(),
    );
    logs = FutureSignal<List<Map<String, dynamic>>>(
      () async => await getLogs(),
      dependencies: [user],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: Container(), // to remove the back button
        actions: [
          // Info button
          IconButton(
            icon: const Icon(Icons.info_rounded),
            onPressed: () => context.push('/about'),
          ),

          // Logout button
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () async {
              context.loaderOverlay.show();
              await supabase.auth.signOut();
              context.pushReplacement('/login');
              context.loaderOverlay.hide();
            },
          ),
        ],
        backgroundColor: colorScheme.primaryContainer,
      ),
      backgroundColor: colorScheme.primaryContainer,
      floatingActionButton: Watch(
        (context) => Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: user.value.value != null
              ? FloatingActionButton(
                  onPressed: () =>
                      context.push('/newLog', extra: user.value.value!),
                  backgroundColor: colorScheme.surfaceContainerLow,
                  child: const Icon(Icons.add_rounded),
                )
              : null,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: RefreshIndicator(
            onRefresh: () async {
              await user.reload();
              await logs.reload();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title / Greeting
                  Padding(
                    padding: const EdgeInsets.only(left: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hi',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        // Username
                        Watch(
                          (context) => Text(
                            user.value.value != null
                                ? '${user.value.value!['username']},'
                                : 'placeholder',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                            ),
                          ).redacted(
                            context: context,
                            redact: user.value.value == null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Statistics
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.rotate(
                        angle: -pi / 2,
                        child: const Text(
                          'Statistics',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
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
                            color: colorScheme.inversePrimary,
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // You have made
                                Watch(
                                  (context) => Column(
                                    children: [
                                      const Text(
                                        'You have made',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "${logs.value.value?.length ?? '000'}",
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                          color: colorScheme.surfaceTint,
                                        ),
                                      ).redacted(
                                        context: context,
                                        redact: logs.value.value == null ||
                                            user.value.value == null,
                                      ),
                                      Text(
                                        "${(logs.value.value?.length ?? 0) <= 1 ? 'log' : 'logs'}.",
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      // Explore more
                                      if (logs.value.value != null &&
                                          logs.value.value!.isNotEmpty)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(),
                                            FilledButton(
                                              onPressed: () => context.push(
                                                '/logs',
                                                extra: logs.value.value!,
                                              ),
                                              child: const Text('See all'),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                            color: colorScheme.inversePrimary,
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Watch(
                              (context) => Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: logs.value.value != null &&
                                        logs.value.value!.isNotEmpty
                                    ? MainAxisAlignment.spaceAround
                                    : MainAxisAlignment.center,
                                children: logs.value.value != null &&
                                        logs.value.value!.isNotEmpty
                                    ? [
                                        const Text(
                                          'Your latest log info.',
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),

                                        // Description (brief)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 128,
                                              child: Text(
                                                logs.value.value!
                                                    .last['description'],
                                                style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: 5,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                            FaIcon(
                                              [
                                                FontAwesomeIcons
                                                    .solidFaceSmileBeam,
                                                FontAwesomeIcons.solidFaceMeh,
                                                FontAwesomeIcons
                                                    .solidFaceSadTear,
                                                FontAwesomeIcons
                                                    .solidFaceAngry,
                                              ][logs.value.value!
                                                  .last['feeling']],
                                              size: 48,
                                            ),
                                          ],
                                        ),

                                        // View more button
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(),
                                            FilledButton(
                                              onPressed: () => context.push(
                                                '/viewLog',
                                                extra: logs.value.value!.last,
                                              ),
                                              child: const Text('View more'),
                                            ),
                                          ],
                                        )
                                      ]
                                    : [
                                        const Text(
                                          'No logs yet.',
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 32, right: 32),
                                          child: Text(
                                            'Press the button on the bottom right to get started!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                              ),
                            ),
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
            ),
          ),
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> getUser() async {
    widget.user ??= supabase.auth.currentUser;

    var result = await supabase
        .from('users')
        .select()
        .eq('email', widget.user!.email ?? "");

    return result[0];
  }

  Future<List<Map<String, dynamic>>> getLogs() async {
    if (user.value.value == null) {
      return [];
    } else {
      final result = await supabase
          .from('logs')
          .select()
          .eq('user_id', user.value.value!['id']);

      return result;
    }
  }
}
