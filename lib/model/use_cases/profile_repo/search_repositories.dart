import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domains/github_repo/github_repo.dart';
import '../../repositories/profile_repo_repository.dart';

final searchKeywordProvider = StateProvider((ref) => '');

final searchRepositories = FutureProvider((ref) async {
  final repository = ref.watch(profileRepoRepositoryProvider);
  final keyword = ref.watch(searchKeywordProvider);

  if (keyword.trim().isEmpty) return <GithubRepo>[];

  return await repository?.searchRepositories(query: keyword);
});
