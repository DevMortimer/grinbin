import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class NewLogPage extends StatelessWidget {
  NewLogPage({super.key, required this.user});

  final Map<String, dynamic> user;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
      ),
      backgroundColor: colorScheme.primaryContainer,
      body: SafeArea(
        child: Column(
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
            const SizedBox(height: 48),

            // Happy
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.solidFaceSmileBeam,
                size: 48,
                shadows: const [
                  Shadow(offset: Offset(2, 6), blurRadius: 10),
                ],
                color: Colors.yellow[600],
              ),
              onPressed: () => logDetail(context, 0),
            ),
            const SizedBox(height: 16),

            // Neutral
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.solidFaceMeh,
                size: 48,
                shadows: const [
                  Shadow(offset: Offset(2, 6), blurRadius: 10),
                ],
                color: Colors.yellow[600],
              ),
              onPressed: () => logDetail(context, 1),
            ),
            const SizedBox(height: 16),

            // Sad
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.solidFaceSadTear,
                size: 48,
                shadows: const [
                  Shadow(offset: Offset(2, 6), blurRadius: 10),
                ],
                color: Colors.yellow[600],
              ),
              onPressed: () => logDetail(context, 2),
            ),
            const SizedBox(height: 16),

            // Angry
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.solidFaceAngry,
                size: 48,
                shadows: const [
                  Shadow(offset: Offset(2, 6), blurRadius: 10),
                ],
                color: Colors.yellow[600],
              ),
              onPressed: () => logDetail(context, 3),
            ),
          ],
        ),
      ),
    );
  }

  logDetail(BuildContext context, int feel) {
    final data = {
      'feel': feel,
      'user': user,
    };
    context.push('/logDetails', extra: data);
  }
}
