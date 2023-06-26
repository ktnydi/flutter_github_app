import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/presentation/screens/search_form/widgets/searchbar.dart';
import 'package:github_app/presentation/screens/search_form/widgets/search_form_body.dart';

class SearchFormScreen extends ConsumerWidget {
  const SearchFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: Searchbar(),
      body: SearchFormBody(),
    );
  }
}
