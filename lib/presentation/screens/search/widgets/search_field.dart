import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/extensions/build_context.dart';
import 'package:github_app/model/use_cases/profile_repo/search_repo/search_repo.dart';

final _searchFieldController = Provider.autoDispose((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
});

final _focusNode = Provider.autoDispose((ref) {
  final focusNode = FocusNode();

  ref.onDispose(() {
    focusNode.dispose();
  });

  return focusNode;
});

class SearchField extends ConsumerWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchFieldController = ref.watch(_searchFieldController);
    final searchKeywordNotifier = ref.watch(searchRepoQueryProvider.notifier);
    final focusNode = ref.watch(_focusNode);

    return Material(
      color: context.colorScheme.surfaceVariant,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: TextFormField(
        controller: searchFieldController,
        focusNode: focusNode,
        textInputAction: TextInputAction.search,
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: 'リポジトリを検索',
          prefixIcon: const Icon(Icons.search, size: 24),
          suffixIcon: ValueListenableBuilder(
            valueListenable: searchFieldController,
            builder: (_, value, child) {
              if (value.text.isEmpty) return const SizedBox();

              return IconButton(
                onPressed: () {
                  searchFieldController.clear();

                  focusNode.requestFocus();
                },
                icon: const Icon(Icons.cancel_outlined),
              );
            },
          ),
        ),
        onFieldSubmitted: (value) {
          if (value.trim().isEmpty) return;

          searchKeywordNotifier.state = value.trim();
        },
      ),
    );
  }
}
