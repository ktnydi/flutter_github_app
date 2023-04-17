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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Material(
                shape: CircleBorder(
                  side: BorderSide(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
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
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Text(repository.owner.login),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            repository.name,
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          if (repository.description != null) Text(repository.description!),
        ],
      ),
    );
  }
}
