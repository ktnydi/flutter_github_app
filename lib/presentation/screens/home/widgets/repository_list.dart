import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../extensions/date_time.dart';
import '../../../../model/use_cases/profile_repo/fetch_profile_repositories.dart';

class RepositoryList extends ConsumerWidget {
  const RepositoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositories = ref.watch(fetchProfileRepositoriesProvider);

    return repositories.when(
      data: (data) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final repository = data[index];

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index != 0)
                    const Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                  ListTile(
                    title: Text(repository.name),
                    subtitle: Text.rich(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      TextSpan(
                        children: [
                          if (repository.language != null) ...[
                            TextSpan(text: repository.language!),
                            const WidgetSpan(
                              child: SizedBox(width: 8),
                            ),
                          ],
                          TextSpan(
                            text: repository.updatedAt.yMd(addHm: true),
                          ),
                          const WidgetSpan(
                            child: SizedBox(width: 8),
                          ),
                          TextSpan(
                            text: repository.description,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            childCount: data!.length,
          ),
        );
      },
      error: (error, stack) {
        return const SliverFillRemaining(
          child: Center(
            child: Icon(Icons.error_outline),
          ),
        );
      },
      loading: () {
        return const SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
