import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/presentation/screens/search/widgets/appbar.dart';
import 'package:github_app/presentation/screens/search/widgets/search_screen_body.dart';

class SearchRepositoriesScreen extends ConsumerWidget {
  const SearchRepositoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: SearchAppBar(),
      body: SearchScreenBody(),
    );
  }
}
