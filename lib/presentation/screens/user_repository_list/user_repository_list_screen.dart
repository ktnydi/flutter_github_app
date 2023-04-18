import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/extensions/date_time.dart';

import '../../../model/domains/github_repo/github_repo.dart';
import '../../../model/use_cases/profile_repo/fetch_profile_repositories.dart';
import '../../../model/use_cases/profile_repo/fetch_starred_repositories.dart';

enum SegmentAction {
  public(label: 'リポジトリ'),
  star(label: 'スター'),
  ;

  const SegmentAction({required this.label});

  final String label;
}

final fetchUserGitHubRepositories =
    Provider.family<AsyncValue<List<GithubRepo>?>, SegmentAction>(
  (ref, action) {
    if (action == SegmentAction.star) {
      return ref.watch(fetchStarredRepositoriesProvider);
    } else {
      return ref.watch(fetchProfileRepositoriesProvider);
    }
  },
);

class UserRepositoryListScreen extends ConsumerWidget {
  const UserRepositoryListScreen({
    super.key,
    required this.repositoryType,
  });

  final SegmentAction repositoryType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repositories = ref.watch(fetchUserGitHubRepositories(repositoryType));

    return Scaffold(
      appBar: AppBar(
        title: Text(repositoryType.label),
      ),
      body: repositories.when(
        data: (data) {
          return ListView.builder(
            itemBuilder: (context, index) {
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
                          if (repository.updatedAt != null) ...[
                            TextSpan(
                              text: repository.updatedAt!.yMd(addHm: true),
                            ),
                            const WidgetSpan(
                              child: SizedBox(width: 8),
                            ),
                          ],
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
            itemCount: data!.length,
          );
        },
        error: (error, stack) {
          return const Center(
            child: Icon(Icons.error_outline),
          );
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
