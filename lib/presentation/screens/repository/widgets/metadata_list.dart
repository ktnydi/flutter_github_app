import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository_screen.dart';
import '../../../../extensions/number.dart';

class MetadataList extends ConsumerWidget {
  const MetadataList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(repositoryProvider);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Wrap(
          children: [
            if (repository.language != null)
              _ResponsiveTile(
                icon: Icons.language_outlined,
                iconBackgroundColor: Colors.blue,
                title: '言語',
                value: repository.language!,
              ),
            _ResponsiveTile(
              icon: Icons.star_border,
              iconBackgroundColor: Colors.amber,
              title: 'スター',
              value: repository.stargazersCount.format(),
            ),
            _ResponsiveTile(
              icon: Icons.remove_red_eye_outlined,
              iconBackgroundColor: Colors.brown,
              title: 'ウォッチ',
              value: repository.watchersCount.format(),
            ),
            _ResponsiveTile(
              icon: Icons.fork_right,
              iconBackgroundColor: Colors.purple,
              title: 'フォーク',
              value: repository.forksCount.format(),
            ),
            _ResponsiveTile(
              icon: Icons.info_outline,
              iconBackgroundColor: Colors.green,
              title: 'イシュー',
              value: repository.openIssuesCount.format(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResponsiveTile extends StatelessWidget {
  const _ResponsiveTile({
    Key? key,
    required this.icon,
    required this.iconBackgroundColor,
    required this.title,
    required this.value,
  }) : super(key: key);

  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return LayoutBuilder(builder: (context, constrains) {
      return SizedBox(
        width: constrains.maxWidth / (isPortrait ? 1 : 2),
        child: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: iconBackgroundColor,
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          minLeadingWidth: 0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: [
              Expanded(
                child: Text(title),
              ),
              Text(value),
            ],
          ),
        ),
      );
    });
  }
}
