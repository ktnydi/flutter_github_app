import 'package:github_app/presentation/screens/profile/profile_screen.dart';
import 'package:github_app/presentation/screens/repository/repository_screen.dart';
import 'package:github_app/presentation/screens/search_form/search_form_screen.dart';
import 'package:github_app/presentation/screens/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
      routes: [
        GoRoute(
          path: 'search',
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const SearchFormScreen(),
              transitionsBuilder: (context, animation, _, child) {
                return child;
              },
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            );
          },
          routes: [
            GoRoute(
              path: ':repositoryId',
              builder: (context, state) => RepositoryScreen(
                id: int.parse(state.pathParameters['repositoryId']!),
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
  ],
);
