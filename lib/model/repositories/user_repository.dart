import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domains/user/user.dart';
import '../../provider/shared_preferences_provider.dart';

final userProvider = FutureProvider((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);

  return await userRepository?.fetchUser();
});

final userRepositoryProvider = Provider(
  (ref) {
    final prefs = ref.watch(sharedPreferencesProvider);
    final accessToken = prefs.getString('accessToken');
    if (accessToken == null) return null;

    return UserRepository(accessToken: accessToken);
  },
);

class UserRepository {
  UserRepository({
    required this.accessToken,
  });

  final String accessToken;
  final _dio = Dio();

  Future<User> fetchUser() async {
    final response = await _dio.getUri(
      Uri.https(
        'api.github.com',
        '/user',
      ),
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'X-Github-Api-Version': '2022-11-28',
        },
      ),
    );

    return User.fromJson(response.data);
  }
}
