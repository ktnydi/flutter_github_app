import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../extensions/build_context.dart';
import '../../../../model/domains/user/user.dart';

final userProfileProvider = Provider<User>(
  (_) => throw UnimplementedError(),
);

class UserProfile extends ConsumerWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                shape: const CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl: user.avatarUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.name}',
                    style: context.textTheme.titleLarge,
                  ),
                  Text(
                    user.login,
                    style: context.textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
          if (user.bio != null) ...[
            const SizedBox(height: 8),
            Text(
              user.bio!,
              style: context.textTheme.bodyLarge,
            ),
          ],
          const SizedBox(height: 8),
          Text.rich(
            style: context.textTheme.bodyLarge,
            TextSpan(
              children: [
                const TextSpan(
                  text: 'フォロー',
                ),
                const WidgetSpan(
                  child: SizedBox(width: 4),
                ),
                TextSpan(
                  text: '${user.following}',
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const WidgetSpan(
                  child: SizedBox(width: 8),
                ),
                const TextSpan(
                  text: 'フォロワー',
                ),
                const WidgetSpan(
                  child: SizedBox(width: 4),
                ),
                TextSpan(
                  text: '${user.followers}',
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.link),
              const SizedBox(width: 4),
              InkWell(
                onTap: () async {
                  final url = user.htmlUrl;
                  if (await canLaunchUrlString(url)) {
                    launchUrlString(url);
                  }
                },
                child: Text(
                  '${Uri.parse(user.htmlUrl).host}${Uri.parse(user.htmlUrl).path}',
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
