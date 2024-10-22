import 'package:Grinbin/global.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LogDetailsPage extends StatelessWidget {
  LogDetailsPage({super.key, required this.feel, required this.user});

  final int feel;
  final Map<String, dynamic> user;
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.primaryContainer,
      ),
      backgroundColor: colorScheme.primaryContainer,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: FloatingActionButton(
          onPressed: () async => await submitLog(context),
          child: const Icon(
            Icons.arrow_right_alt_rounded,
            size: 32,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FaIcon(
                [
                  FontAwesomeIcons.solidFaceSmileBeam,
                  FontAwesomeIcons.solidFaceMeh,
                  FontAwesomeIcons.solidFaceSadTear,
                  FontAwesomeIcons.solidFaceAngry,
                ][feel],
                size: 64,
              ),

              const Center(
                child: Text(
                  "What's going on?",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // Description input
              SizedBox(
                width: 400,
                height: 128,
                child: TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    labelText: "Description*",
                    alignLabelWithHint: true,
                  ),
                  maxLines: null,
                  expands: true,
                  maxLength: 120,
                  onSubmitted: (string) async => await submitLog(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> submitLog(BuildContext context) async {
    context.loaderOverlay.show();

    // Validate description
    if (descriptionController.text.isEmpty) {
      await showAlertDialog(context, "Description must not be empty.");
      return;
    }

    // Add log to database
    await supabase.from('logs').insert({
      'description': descriptionController.text,
      'feeling': feel,
      'user_id': user['id'],
    });

    context.loaderOverlay.hide();
    context.pushReplacement('/');
  }
}
