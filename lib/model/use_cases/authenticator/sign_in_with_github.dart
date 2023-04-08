import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../proverder/shared_preferences_provider.dart';

final signInWithGithub = Provider(_SignInWithGithub.new);

class _SignInWithGithub {
  _SignInWithGithub(this._ref);

  final Ref _ref;
  final _appAuth = const FlutterAppAuth();
  final _dio = Dio();

  SharedPreferences get _prefs => _ref.read(sharedPreferencesProvider);

  /// Githubサインイン
  /// https://docs.github.com/ja/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#web-application-flow
  Future<void> call() async {
    const clientId = String.fromEnvironment('clientId');
    const clientSecret = String.fromEnvironment('clientSecret');

    /// アプリに特定のアクセス権限を許可するか求める。（認証）
    /// 許可すると`Callback URL`に認可コードを付与してリダイレクトされる。（認可）
    final AuthorizationResponse? authorizationResult;

    try {
      authorizationResult = await _appAuth.authorize(
        AuthorizationRequest(
          clientId,
          'githubapp://',
          serviceConfiguration: const AuthorizationServiceConfiguration(
            authorizationEndpoint: 'https://github.com/login/oauth/authorize',
            tokenEndpoint: 'https://github.com/login/oauth/access_token',
          ),
          scopes: [
            'repo',
            'user',
          ],
        ),
      );
    } on Exception catch (_) {
      rethrow;
    }

    if (authorizationResult == null) return;

    /// 認可コードを認可サーバーに渡してアクセストークンを取得する。
    final result = await _dio.postUri(
      Uri.https(
        'github.com',
        '/login/oauth/access_token',
        {
          'client_id': clientId,
          'client_secret': clientSecret,
          'code': authorizationResult.authorizationCode,
        },
      ),
      options: Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    final accessToken = result.data['access_token'] as String;

    await _prefs.setString('accessToken', accessToken);
  }
}
