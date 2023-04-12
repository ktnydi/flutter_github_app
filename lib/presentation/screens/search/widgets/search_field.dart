import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../model/use_cases/profile_repo/search_repositories.dart';

final _searchFieldController = Provider.autoDispose((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
});

final _hasText = Provider.autoDispose((ref) {
  final searchController = ref.watch(_searchFieldController);

  searchController.addListener(() {
    ref.state = searchController.text.isNotEmpty;
  });

  return searchController.text.isNotEmpty;
});

class SearchField extends ConsumerWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchFieldController = ref.watch(_searchFieldController);
    final searchKeywordNotifier = ref.watch(searchKeywordProvider.notifier);
    final hasText = ref.watch(_hasText);

    return TextFormField(
      controller: searchFieldController,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        labelText: 'リポジトリを検索',
        filled: true,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: hasText
            ? IconButton(
                onPressed: () {
                  searchFieldController.clear();
                },
                icon: const Icon(Icons.cancel_outlined),
              )
            : null,
      ),
      onFieldSubmitted: (value) {
        if (value.trim().isEmpty) return;

        searchKeywordNotifier.state = value.trim();
      },
    );
  }
}
