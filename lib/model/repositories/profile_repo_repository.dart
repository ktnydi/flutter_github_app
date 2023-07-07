import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/model/domains/github_repositories/github_repositories.dart';

import '../domains/github_repo/github_repo.dart';
import '../../provider/shared_preferences_provider.dart';

final profileRepoRepositoryProvider = Provider((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  final accessToken = prefs.getString('accessToken');
  if (accessToken == null) return null;

  return ProfileRepoRepository(accessToken: accessToken);
});

class ProfileRepoRepository {
  ProfileRepoRepository({required this.accessToken});

  final String accessToken;
  final _dio = Dio();

  Future<GithubRepositories> searchRepositories({
    required String query,
    int page = 1,
    int perPage = 30,
    String sort = '',
  }) async {
    final response = await _dio.getUri<Map<String, dynamic>>(
      Uri.https(
        'api.github.com',
        '/search/repositories',
        {
          'q': query,
          'sort': sort,
          'page': '$page',
          'per_page': '$perPage',
        },
      ),
      options: Options(
        headers: {
          'Accept': 'aplication/vnd.github+json',
          'Authorization': 'Bearer $accessToken',
          'X-Github-Api-Version': '2022-11-28',
        },
      ),
    );

    final jsonMap = response.data!['items'] as List<dynamic>?;

    if (jsonMap == null) return const GithubRepositories();

    final repositories = jsonMap.map((json) => GithubRepo.fromJson(json));
    return GithubRepositories(
      value: repositories.toList(),
      totalCount: response.data!['total_count'] as int? ?? 0,
    );
  }
}
