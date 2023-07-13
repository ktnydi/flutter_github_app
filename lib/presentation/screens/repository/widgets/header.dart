import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository_screen.dart';
import '../../../../extensions/build_context.dart';

class Header extends ConsumerWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(repositoryProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                repository.owner.isOrganization ? 16 : 1000,
              ),
              side: BorderSide(
                width: 1,
                color: context.colorScheme.surfaceVariant,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            // 周囲に枠線の幅だけ余白を設けて画像が枠線に被らないようにする。
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: CachedNetworkImage(
                imageUrl: repository.owner.avatarUrl,
                placeholder: (context, url) {
                  return const CircularProgressIndicator();
                },
                errorWidget: (context, url, error) {
                  return Ink(
                    color: context.colorScheme.surfaceVariant,
                    child: Icon(
                      Icons.broken_image_outlined,
                      size: 32,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  );
                },
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: repository.owner.login,
                ),
                const TextSpan(text: '/'),
                TextSpan(
                  text: repository.name,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            style: context.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          if (repository.description != null) ...[
            const SizedBox(height: 16),
            Text(
              repository.description!,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
