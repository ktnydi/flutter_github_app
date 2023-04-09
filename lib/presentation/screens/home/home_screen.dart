import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../extensions/build_context.dart';
import '../../../model/repositories/user_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        actions: [
          if (user.value != null)
            IconButton(
              onPressed: () async {
                final url = user.value!.htmlUrl;
                if (await canLaunchUrlString(url)) {
                  launchUrlString(url);
                }
              },
              icon: const Icon(Icons.launch_outlined),
            ),
        ],
      ),
      body: user.when(
        data: (data) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        imageUrl: data!.avatarUrl,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data.name}',
                            style: context.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            textHeightBehavior: const TextHeightBehavior(
                              applyHeightToFirstAscent: false,
                            ),
                          ),
                          Text(
                            data.login,
                            style: context.textTheme.bodyMedium,
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'フォロー',
                                ),
                                const WidgetSpan(
                                  child: SizedBox(width: 4),
                                ),
                                TextSpan(
                                  text: '${data.following}',
                                  style: context.textTheme.bodyMedium!.copyWith(
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
                                  text: '${data.followers}',
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (data.bio != null)
                            Text(
                              data.bio!,
                              style: context.textTheme.bodyMedium,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32),
              ],
            ),
          );
        },
        error: (error, stack) {
          return const SizedBox();
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
