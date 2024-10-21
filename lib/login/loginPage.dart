import 'package:Grinbin/global.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.primaryContainer,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 69),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              // Logo
              Image.asset('assets/grinbin.png', width: 128, height: 128),
              const Text(
                'GRINBIN',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 32),

              // Username
              TextField(
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.username],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username*',
                ),
                controller: usernameController,
                onSubmitted: (v) => passwordNode.requestFocus(),
              ),
              const SizedBox(height: 16),

              // Password
              TextField(
                keyboardType: TextInputType.text,
                autofillHints: const [AutofillHints.password],
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password*',
                ),
                controller: passwordController,
                focusNode: passwordNode,
                onSubmitted: (value) => login(context),
              ),
              const SizedBox(height: 32),

              // Login and Signup
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () => login(context),
                  ),
                  ElevatedButton(
                    child: const Text('Sign Up'),
                    onPressed: () => signUp(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> validate(BuildContext context) async {
// Validate input
    // Empty inputs
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      await showAlertDialog(context, "Please fill in all the fields.");
    }

    // Invalid inputs
    if (usernameController.text.contains(' ') ||
        passwordController.text.contains(' ')) {
      await showAlertDialog(context, "Fields must not contain spaces.");
    }
  }

  Future<void> login(BuildContext context) async {
    context.loaderOverlay.show();
    validate(context);

    // Login
    try {
      final response = await supabase.auth.signInWithPassword(
        email: "${usernameController.text}@fake-email.com",
        password: passwordController.text,
      );
      supabase.auth.setSession(response.session!.refreshToken!);
      context.loaderOverlay.hide();
      context.pushReplacement('/', extra: response.user!);
    } on AuthApiException catch (e) {
      context.loaderOverlay.hide();
      await showAlertDialog(context, "Failed to login!\n\n${e.message}");
    } catch (e) {
      context.loaderOverlay.hide();
      await showAlertDialog(context, "Failed to login!");
    }
  }

  Future<void> signUp(BuildContext context) async {
    context.loaderOverlay.show();
    validate(context);

    // Signup
    try {
      final response = await supabase.auth.signUp(
        email: "${usernameController.text}@fake-email.com",
        password: passwordController.text,
      );
      supabase.auth.setSession(response.session!.refreshToken!);

      // Create user data
      await supabase.from('users').insert({
        'username': usernameController.text,
        'email': "${usernameController.text}@fake-email.com",
      });

      context.loaderOverlay.hide();
      context.pushReplacement('/', extra: response.user!);
    } on AuthApiException catch (e) {
      context.loaderOverlay.hide();

      if (e.code == 'user_already_exists') {
        await showAlertDialog(context, "Failed to sign up!\n\nUnknown error");
      } else {
        await showAlertDialog(context, "Failed to sign up!\n\n${e.message}");
      }
    }
  }
}
