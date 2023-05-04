import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future<List<GithubRepo>> fetchProfileRepositories({
    required int page,
    required int perPage,
  }) async {
    final response = await _dio.getUri<List<dynamic>>(
      Uri.https(
        'api.github.com',
        '/user/repos',
        {
          'sort': 'pushed',
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

    final jsonMap = response.data;

    if (jsonMap == null) return [];

    final repositories = jsonMap.map((json) => GithubRepo.fromJson(json));
    return repositories.toList();
  }

  Future<List<GithubRepo>> fetchStarredRepositories({
    required int page,
    required int perPage,
  }) async {
    final response = await _dio.getUri<List<dynamic>>(
      Uri.https(
        'api.github.com',
        '/user/starred',
        {
          'sort': 'created',
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

    final jsonMap = response.data;

    if (jsonMap == null) return [];

    final repositories = jsonMap.map((json) => GithubRepo.fromJson(json));
    return repositories.toList();
  }

  Future<List<GithubRepo>> searchRepositories({
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

    if (jsonMap == null) return [];

    final repositories = jsonMap.map((json) => GithubRepo.fromJson(json));
    return repositories.toList();
  }
}
