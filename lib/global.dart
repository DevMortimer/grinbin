import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<void> showAlertDialog(
  BuildContext context,
  String message, {
  String title = "Error",
  Widget icon = const Icon(Icons.warning),
  List<Widget> actions = const [],
}) async {
  await showDialog(
    builder: (context) => AlertDialog(
      title: Text(title),
      icon: icon,
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: actions.isNotEmpty
          ? actions
          : [
              TextButton(
                child: const Text("Ok"),
                onPressed: () => Navigator.of(context).maybePop(),
              )
            ],
    ),
    context: context,
  );
}
