import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../extensions/date_time.dart';
import '../../../model/use_cases/profile_repo/search_repositories.dart';
import 'widgets/search_field.dart';

class SearchRepositoriesScreen extends ConsumerWidget {
  const SearchRepositoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewPadding = MediaQuery.of(context).viewPadding;
    final searchResult = ref.watch(searchRepositories);
    final searchKeywordState = ref.watch(searchKeywordProvider);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16 + viewPadding.top, 16, 0),
            child: const SearchField(),
          ),
          const SizedBox(height: 16),
          if (searchKeywordState.isNotEmpty)
            Expanded(
              child: searchResult.when(
                data: (data) {
                  if (data!.isEmpty) {
                    return const Center(
                      child: Text('一致する結果が見つかりませんでした。'),
                    );
                  }

                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final repository = data[index];

                      return ListTile(
                        title: Text(repository.name),
                        subtitle: Text.rich(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          TextSpan(
                            children: [
                              if (repository.language != null) ...[
                                TextSpan(text: repository.language!),
                                const WidgetSpan(
                                  child: SizedBox(width: 8),
                                ),
                              ],
                              if (repository.updatedAt != null) ...[
                                TextSpan(
                                  text: repository.updatedAt!.yMd(addHm: true),
                                ),
                                const WidgetSpan(
                                  child: SizedBox(width: 8),
                                ),
                              ],
                              TextSpan(
                                text: repository.description,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                    itemCount: data.length,
                  );
                },
                error: (error, stack) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.error_outline),
                        SizedBox(height: 16),
                        Text('エラーが発生しました。'),
                      ],
                    ),
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
