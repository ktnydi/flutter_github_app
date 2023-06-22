import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../extensions/build_context.dart';
import '../../../model/use_cases/authenticator/sign_in_with_github.dart';
import '../bottom_navigator/bottom_navigator_screen.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> signIn() async {
      try {
        await ref.read(signInWithGithub)();

        // ignore: use_build_context_synchronously
        if (!context.mounted) return;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigatorScreen(),
          ),
        );
      } on PlatformException catch (error, stack) {
        debugPrintStack(
          stackTrace: stack,
          label: error.toString(),
        );

        showOkAlertDialog(
          context: context,
          title: error.code,
          message: error.message,
        );
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'GitHub App',
                style: context.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              FilledButton(
                onPressed: signIn,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(240, 56),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/github-mark-white.png',
                      width: 24,
                      filterQuality: FilterQuality.medium,
                    ),
                    const SizedBox(width: 8),
                    const Text('Githubでサインイン'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
