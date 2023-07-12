import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_app/extensions/build_context.dart';
import 'package:github_app/model/use_cases/search_repo/search_repo.dart';

final _searchbarController = Provider.autoDispose((ref) {
  final controller = TextEditingController();

  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
});

final _focusNode = Provider.autoDispose((ref) {
  final focusNode = FocusNode();

  focusNode.addListener(() {
    ref.read(_hasFocusProvider.notifier).state = focusNode.hasFocus;
  });

  ref.onDispose(() {
    focusNode.dispose();
  });

  return focusNode;
});

final _hasFocusProvider = StateProvider.autoDispose((ref) {
  return false;
});

class Searchbar extends ConsumerWidget implements PreferredSizeWidget {
  const Searchbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final queryNotifier = ref.watch(searchRepoQueryProvider.notifier);
    final searchController = ref.watch(_searchbarController);
    final focusNode = ref.watch(_focusNode);
    final hasFocus = ref.watch(_hasFocusProvider);
    final sortKeyNotifier = ref.watch(searchSortKeyProvider.notifier);

    return Material(
      color: context.colorScheme.surfaceVariant,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top,
        ),
        child: SizedBox(
          height: kToolbarHeight,
          child: Row(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints.tightFor(
                  width: kToolbarHeight,
                  height: kToolbarHeight,
                ),
                child: const BackButton(),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        focusNode: focusNode,
                        autofocus: true,
                        textAlignVertical: TextAlignVertical.center,
                        style: context.textTheme.bodyLarge,
                        strutStyle: StrutStyle.fromTextStyle(
                          context.textTheme.bodyLarge!,
                          forceStrutHeight: true,
                        ),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 4),
                          isDense: true,
                          hintText: 'Github内のリポジトリを検索',
                        ),
                        onFieldSubmitted: (value) {
                          if (value.isEmpty) return;

                          queryNotifier.state = value;
                        },
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: searchController,
                      builder: (context, value, child) {
                        if (value.text.isEmpty) {
                          return const SizedBox();
                        }

                        return IconButton(
                          onPressed: () {
                            searchController.clear();
                            focusNode.requestFocus();
                          },
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(Icons.clear),
                        );
                      },
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  final result = await showModalActionSheet(
                    context: context,
                    title: 'ソート方法',
                    actions: SortKey.values.map((e) {
                      return SheetAction(
                        key: e,
                        label: e.label,
                      );
                    }).toList(),
                  );

                  if (result == null) return;

                  sortKeyNotifier.state = result;
                },
                icon: const Icon(Icons.sort_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
