import 'package:app/features/chat/chat.dart';
import 'package:app/features/find_someone/find_someone.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/hancod_theme.dart';
import 'package:intl/intl.dart';

export 'widgets/widgets.dart';

/// Conversation surface for the Chat destination.
///
/// The route can carry a conversation id so a match or connection can open its
/// own thread later; without one the sample conversation is shown.
class ChatScreen extends ConsumerWidget {
  const ChatScreen({
    this.conversationId = kDefaultChatConversationId,
    super.key,
  });

  final String conversationId;

  void _handleMenu(BuildContext context, WidgetRef ref, ChatMenuAction action) {
    switch (action) {
      case ChatMenuAction.viewDetails:
        _openMatchDetails(context, ref);
      // TODO(where-ru): blocking and reporting need the moderation endpoints.
      case ChatMenuAction.blockReport:
        context.showSnackBar(context.l10n.backendNotConnected);
    }
  }

  /// Opens the match this conversation belongs to. The match lives in the
  /// matchmaking flow's session state until the backend exposes it, so without
  /// a match in this session the backend boundary is reported instead.
  void _openMatchDetails(BuildContext context, WidgetRef ref) {
    if (ref.read(findSomeoneNotifierProvider).match == null) {
      context.showSnackBar(context.l10n.backendNotConnected);
      return;
    }
    context.push(AppRouter.findSomeoneMatchPath);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatNotifierProvider(conversationId));
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: WhereRuBrand.background,
      body: ChatBackdrop(
        child: SafeArea(
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 800;
              final inset = wide ? 20.0 : 10.0;

              return Padding(
                padding: EdgeInsets.fromLTRB(
                  inset,
                  inset,
                  inset,
                  wide ? 20 : 0,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 680),
                    child: Container(
                      key: const Key('chat-surface'),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 14),
                            blurRadius: 40,
                            color: WhereRuBrand.navy.withValues(alpha: .07),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          ChatHeader(
                            onBack: () => context.canPop()
                                ? context.pop()
                                : context.go(AppRouter.findSomeonePath),
                            onCall: () =>
                                context.showSnackBar(l10n.chatCallUnavailable),
                            onMenuAction: (action) =>
                                _handleMenu(context, ref, action),
                          ),
                          Expanded(child: _body(context, ref, state)),
                          if (state.isReady)
                            ChatComposer(
                              onSend: (_) => context.showSnackBar(
                                l10n.chatSendUnavailable,
                              ),
                              onMic: () => context.showSnackBar(
                                l10n.chatSendUnavailable,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context, WidgetRef ref, ChatState state) {
    final conversation = state.conversation;

    if (state.status == ChatStatus.failure || conversation == null) {
      if (state.status == ChatStatus.failure) {
        return _ErrorState(
          onRetry: () =>
              ref.read(chatNotifierProvider(conversationId).notifier).reload(),
        );
      }
      return const Center(child: CircularProgressIndicator(strokeWidth: 2.6));
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 8),
      children: [
        ConversationSummaryCard(conversation: conversation),
        const SizedBox(height: 10),
        MatchBanner(
          activity: conversation.activity,
          onViewDetails: () => _openMatchDetails(context, ref),
        ),
        const SizedBox(height: 14),
        ChatDateSeparator(label: _dateLabel(context, conversation)),
        const SizedBox(height: 12),
        for (final message in conversation.messages)
          Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: ChatMessageBubble(
              message: message,
              participant: conversation.participant,
            ),
          ),
      ],
    );
  }

  String _dateLabel(BuildContext context, ChatConversation conversation) {
    if (conversation.messages.isEmpty) return context.l10n.chatToday;

    final first = conversation.messages.first.sentAt;
    if (DateUtils.isSameDay(first, DateTime.now())) {
      return context.l10n.chatToday;
    }
    return DateFormat.MMMd(
      Localizations.localeOf(context).languageCode,
    ).format(first);
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.somethingWentWrong,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: WhereRuBrand.body),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: onRetry,
              child: Text(
                l10n.retry,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: WhereRuBrand.purple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
