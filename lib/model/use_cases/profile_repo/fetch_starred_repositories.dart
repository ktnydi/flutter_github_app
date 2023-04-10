import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domains/github_repo/github_repo.dart';
import '../../repositories/profile_repo_repository.dart';

final fetchStarredRepositoriesProvider = FutureProvider<List<GithubRepo>?>(
  (ref) async {
    final repository = ref.watch(profileRepoRepositoryProvider);

    return await repository?.fetchStarredRepositories();
  },
);
