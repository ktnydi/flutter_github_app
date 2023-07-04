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

  ref.onDispose(() {
    focusNode.dispose();
  });

  return focusNode;
});

class Searchbar extends ConsumerWidget implements PreferredSizeWidget {
  const Searchbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visualDensity = Theme.of(context).visualDensity;
    final queryNotifier = ref.watch(searchRepoQueryProvider.notifier);
    final searchController = ref.watch(_searchbarController);
    final focusNode = ref.watch(_focusNode);
    final sortKeyNotifier = ref.watch(searchSortKeyProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).viewPadding.top,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: kToolbarHeight,
        child: Row(
          children: [
            Expanded(
              child: Material(
                color: context.colorScheme.surfaceVariant,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAlias,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
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
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            isDense: true,
                            hintText: 'GitHub内のリポジトリを検索',
                            suffixIconConstraints:
                                visualDensity.effectiveConstraints(
                              const BoxConstraints(
                                minWidth: 0,
                                minHeight: kMinInteractiveDimension,
                              ),
                            ),
                            suffixIcon: ValueListenableBuilder(
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
                                  icon: const Icon(Icons.cancel),
                                  visualDensity: VisualDensity.compact,
                                  color: context.colorScheme.primary,
                                );
                              },
                            ),
                          ),
                          onFieldSubmitted: (value) {
                            if (value.isEmpty) return;

                            queryNotifier.state = value;
                          },
                        ),
                      ),
                      const VerticalDivider(
                        width: 1,
                        indent: 8,
                        endIndent: 8,
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
            ),
            const SizedBox(width: 16),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                shape: const BeveledRectangleBorder(),
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 40),
                textStyle: context.textTheme.bodyLarge,
              ),
              child: const Text('閉じる'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
