import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/model/domains/user/user.dart';
import 'package:github_app/model/use_cases/authenticator/sign_in_with_github.dart';
import 'package:github_app/provider/shared_preferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authenticatorProvider =
    StateNotifierProvider<AuthenticatorNotifier, User?>((ref) {
  return AuthenticatorNotifier(ref);
});

class AuthenticatorNotifier extends StateNotifier<User?> {
  AuthenticatorNotifier(this.ref) : super(null);

  final Ref ref;
  final _dio = Dio();
  SharedPreferences get _prefs => ref.read(sharedPreferencesProvider);

  Future<void> signIn() async {
    final accessToken = await ref.read(signInWithGithub)();

    if (accessToken == null) return;

    // 端末にアクセストークンを保存する。
    await _prefs.setString('accessToken', accessToken);

    // アクセストークンを使ってGitHubのユーザー情報を取得する。
    final response = await _dio.getUri<Map<String, dynamic>>(
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

    state = User.fromJson(response.data!);
  }

  Future<void> signOut() async {
    await _prefs.remove('accessToken');
    state = null;
  }
}
