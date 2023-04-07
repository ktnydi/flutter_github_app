import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _appAuth = const FlutterAppAuth();
  final _dio = Dio();
  final _prefs = SharedPreferences.getInstance();
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    signInWithGithub();
  }

  /// Githubサインイン
  /// https://docs.github.com/ja/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#web-application-flow
  Future<void> signInWithGithub() async {
    const clientId = String.fromEnvironment('clientId');
    const clientSecret = String.fromEnvironment('clientSecret');

    /// アプリに特定のアクセス権限を許可するか求める。（認証）
    /// 許可すると`Callback URL`に認可コードを付与してリダイレクトされる。（認可）
    final authorizationResult = await _appAuth.authorize(
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

    final prefs = await _prefs;
    await prefs.setString('accessToken', accessToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
