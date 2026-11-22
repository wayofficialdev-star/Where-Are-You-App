import 'package:app/features/chat/chat.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';

/// Conversation summary: participant details and the matched activity.
class ConversationSummaryCard extends StatelessWidget {
  const ConversationSummaryCard({required this.conversation, super.key});

  final ChatConversation conversation;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final participant = conversation.participant;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFCFF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: WhereRuBrand.hairline),
      ),
      child: Row(
        children: [
          ChatAvatar(
            name: participant.name,
            avatarUrl: participant.avatarUrl,
            size: 48,
            showOnlineDot: participant.isOnline,
          ),
          const SizedBox(width: 9),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  participant.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    color: WhereRuBrand.navy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.chatOnlineNow,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF16A34A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.ageCityLine(participant.age, participant.city),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: WhereRuBrand.body,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Flexible(flex: 5, child: _ActivityTile(conversation: conversation)),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.conversation});

  final ChatConversation conversation;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 7, 4, 7),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2FE),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 27,
            height: 27,
            decoration: const BoxDecoration(
              color: Color(0xFFD9E8FD),
              shape: BoxShape.circle,
            ),
            child: Icon(
              chatActivityIcon(conversation.activity),
              size: 15,
              color: WhereRuBrand.blue,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  chatActivityLabel(l10n, conversation.activity),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    color: WhereRuBrand.navy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  chatScheduleLabel(l10n, conversation.schedule),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    color: WhereRuBrand.body,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 15,
            color: WhereRuBrand.hint,
          ),
        ],
      ),
    );
  }
}
