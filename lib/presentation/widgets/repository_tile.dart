import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_app/extensions/build_context.dart';
import 'package:github_app/extensions/number.dart';

import '../../model/domains/github_repo/github_repo.dart';

class RepositoryTile extends StatelessWidget {
  const RepositoryTile({
    Key? key,
    required this.repository,
    this.onTap,
  }) : super(key: key);

  final GithubRepo repository;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Material(
                          shape: const CircleBorder(),
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            imageUrl: repository.owner.avatarUrl,
                            placeholder: (context, url) {
                              return const CircularProgressIndicator();
                            },
                            width: 36,
                            height: 36,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          repository.owner.login,
                          style: context.textTheme.titleSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      repository.name,
                      style: context.textTheme.titleMedium!.copyWith(
                        color: context.colorScheme.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (repository.description != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        repository.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (repository.language != null) ...[
                          Text(repository.language!),
                          const SizedBox(width: 8),
                        ],
                        const Icon(
                          Icons.star_border,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(repository.stargazersCount.format()),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.fork_right,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(repository.forksCount.format()),
                      ],
                    ),
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
