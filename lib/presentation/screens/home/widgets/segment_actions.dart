import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../extensions/build_context.dart';

final segmentActionProvider = StateProvider((ref) => SegmentAction.public);

enum SegmentAction {
  public(label: 'リポジトリ'),
  star(label: 'スター'),
  ;

  const SegmentAction({required this.label});

  final String label;
}

class FilterAction extends ConsumerWidget {
  const FilterAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final segmentAction = ref.watch(segmentActionProvider);
    final segmentActionNotifier = ref.watch(segmentActionProvider.notifier);

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Row(
          children: SegmentAction.values.map((e) {
            final selected = segmentAction == e;

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: RawChip(
                onSelected: (_) {
                  segmentActionNotifier.state = e;
                },
                selected: selected,
                showCheckmark: false,
                selectedColor: context.colorScheme.secondaryContainer,
                side: BorderSide(
                  color: selected
                      ? Colors.transparent
                      : context.colorScheme.outline,
                ),
                label: Text(e.label),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
