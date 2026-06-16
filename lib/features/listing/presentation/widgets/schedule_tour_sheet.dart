import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../inquiries/application/inquiries_controller.dart';

/// Bottom sheet to schedule a property tour: pick a day and a time slot.
/// On confirm it creates a tour (which surfaces in My Inquiries).
class ScheduleTourSheet extends ConsumerStatefulWidget {
  const ScheduleTourSheet({super.key, required this.listingId});

  final String listingId;

  static Future<void> show(BuildContext context, String listingId) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ScheduleTourSheet(listingId: listingId),
    );
  }

  @override
  ConsumerState<ScheduleTourSheet> createState() => _ScheduleTourSheetState();
}

class _ScheduleTourSheetState extends ConsumerState<ScheduleTourSheet> {
  static const _slots = ['9:00 AM', '11:00 AM', '1:00 PM', '3:00 PM', '5:00 PM'];

  late final List<DateTime> _days = List.generate(
      7, (i) => DateUtils.dateOnly(DateTime.now().add(Duration(days: i + 1))));
  late DateTime _selectedDay = _days.first;
  String _selectedSlot = _slots[1];
  bool _submitting = false;

  Future<void> _confirm() async {
    setState(() => _submitting = true);
    try {
      await ref.read(inquiriesControllerProvider.notifier).scheduleTour(
            listingId: widget.listingId,
            date: DateFormat('yyyy-MM-dd').format(_selectedDay),
            slot: _selectedSlot,
          );
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tour requested for '
              '${DateFormat.MMMEd().format(_selectedDay)} at $_selectedSlot'),
        ),
      );
    } catch (_) {
      if (mounted) {
        setState(() => _submitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Couldn't schedule the tour")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.lg,
        right: AppSpacing.lg,
        top: AppSpacing.sm,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Schedule a tour', style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          Text('Choose a day', style: theme.textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            height: 84,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _days.length,
              separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, i) {
                final day = _days[i];
                final selected = day == _selectedDay;
                return InkWell(
                  borderRadius: BorderRadius.circular(AppRadii.md),
                  onTap: () => setState(() => _selectedDay = day),
                  child: Container(
                    width: 64,
                    decoration: BoxDecoration(
                      color: selected
                          ? theme.colorScheme.primaryContainer
                          : theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppRadii.md),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(DateFormat.E().format(day),
                            style: theme.textTheme.labelMedium),
                        const SizedBox(height: AppSpacing.xs),
                        Text('${day.day}',
                            style: theme.textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Choose a time', style: theme.textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final slot in _slots)
                ChoiceChip(
                  label: Text(slot),
                  selected: _selectedSlot == slot,
                  onSelected: (_) => setState(() => _selectedSlot = slot),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _submitting ? null : _confirm,
              child: _submitting
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Request tour'),
            ),
          ),
        ],
      ),
    );
  }
}
