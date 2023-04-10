import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domains/github_repo/github_repo.dart';
import '../../proverder/shared_preferences_provider.dart';

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

  Future<List<GithubRepo>> fetchProfileRepositories() async {
    final response = await _dio.getUri<List<dynamic>>(
      Uri.https(
        'api.github.com',
        '/user/repos',
        {
          'sort': 'pushed',
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

  Future<List<GithubRepo>> fetchStarredRepositories() async {
    final response = await _dio.getUri<List<dynamic>>(
      Uri.https(
        'api.github.com',
        '/user/starred',
        {
          'sort': 'created',
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
}
