import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../inquiries/application/inquiries_controller.dart';

/// Bottom sheet to message an agent. Creates an inquiry that appears in the
/// My Inquiries thread list.
class ContactAgentSheet extends ConsumerStatefulWidget {
  const ContactAgentSheet({super.key, required this.listingId});

  final String listingId;

  static Future<void> show(BuildContext context, String listingId) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => ContactAgentSheet(listingId: listingId),
    );
  }

  @override
  ConsumerState<ContactAgentSheet> createState() => _ContactAgentSheetState();
}

class _ContactAgentSheetState extends ConsumerState<ContactAgentSheet> {
  final _controller = TextEditingController(
      text: "Hi, I'm interested in this property. Is it still available?");
  bool _submitting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _submitting = true);
    try {
      await ref.read(inquiriesControllerProvider.notifier).contactAgent(
            listingId: widget.listingId,
            message: text,
          );
      if (!mounted) return;
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent to the agent')),
      );
    } catch (_) {
      if (mounted) {
        setState(() => _submitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Couldn't send your message")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          Text('Message agent', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.lg),
          TextField(
            controller: _controller,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Your message',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _submitting ? null : _send,
              icon: const Icon(Icons.send),
              label: Text(_submitting ? 'Sending…' : 'Send message'),
            ),
          ),
        ],
      ),
    );
  }
}
