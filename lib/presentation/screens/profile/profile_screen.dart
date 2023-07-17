import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/extensions/build_context.dart';
import 'package:github_app/model/use_cases/authenticator/authenticator.dart';
import 'package:github_app/model/use_cases/show_material_grid.dart';
import 'package:github_app/model/use_cases/theme_mode.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:go_router/go_router.dart';
import 'widgets/user_profile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authenticatorProvider).value;
    final userNotifier = ref.watch(authenticatorProvider.notifier);
    final themeModeState = ref.watch(themeModeNotifierProvider);
    final themeModeNotifier = ref.watch(themeModeNotifierProvider.notifier);

    Future<void> logout() async {
      final result = await showOkCancelAlertDialog(
        context: context,
        title: 'サインアウト',
        message: 'サインアウトしますか？',
      );

      if (result == OkCancelResult.cancel) return;

      await userNotifier.signOut();

      // ignore: use_build_context_synchronously
      if (!context.mounted) return;

      context.go('/');
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: logout,
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              if (user != null)
                ProviderScope(
                  overrides: [
                    userProfileProvider.overrideWithValue(user),
                  ],
                  child: const UserProfile(),
                ),
              const Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
              ),
              const SizedBox(height: 12),
              ListTile(
                onTap: () async {
                  final result = await showModalActionSheet(
                    context: context,
                    actions: ThemeMode.values.map((e) {
                      return SheetAction(
                        key: e,
                        label: L10n.of(context)!.themeModeLabel(e.name),
                      );
                    }).toList(),
                  );

                  if (result == null) return;

                  themeModeNotifier.update(result);
                },
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.white,
                  ),
                ),
                title: Row(
                  children: [
                    const Expanded(
                      child: Text('外観'),
                    ),
                    Text(
                      L10n.of(context)!.themeModeLabel(themeModeState.name),
                      style: context.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                trailing: const Icon(Icons.navigate_next),
              ),
              if (kDebugMode)
                ListTile(
                  onTap: () async {},
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.grid_on,
                      color: Colors.white,
                    ),
                  ),
                  title: const Text('Debug Show Material Grid'),
                  trailing: Switch(
                    value: ref.watch(isOnMaterialGridProvider),
                    onChanged: (value) {
                      ref.read(isOnMaterialGridProvider.notifier).state = value;
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
