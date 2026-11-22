import 'package:app/features/chat/chat.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';
import 'package:intl/intl.dart';

const _outgoingGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF4C9BFF), Color(0xFF2B8EFE)],
);

const _timeStyle = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w500,
  height: 1.2,
  color: WhereRuBrand.hint,
);

/// One message: incoming bubbles sit beside the participant avatar, outgoing
/// bubbles are right aligned with their delivery state.
class ChatMessageBubble extends StatelessWidget {
  const ChatMessageBubble({
    required this.message,
    required this.participant,
    super.key,
  });

  final ChatMessage message;
  final ChatParticipant participant;

  @override
  Widget build(BuildContext context) {
    final isMe = message.author == ChatMessageAuthor.me;
    final time = DateFormat.jm(
      Localizations.localeOf(context).languageCode,
    ).format(message.sentAt);

    final bubble = Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: isMe ? null : const Color(0xFFF0F1FD),
        gradient: isMe ? _outgoingGradient : null,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isMe ? 18 : 6),
          topRight: Radius.circular(isMe ? 6 : 18),
          bottomLeft: const Radius.circular(18),
          bottomRight: const Radius.circular(18),
        ),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          fontSize: 12.8,
          fontWeight: FontWeight.w400,
          height: 1.4,
          color: isMe ? AppColors.white : WhereRuBrand.navy,
        ),
      ),
    );

    if (isMe) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          bubble,
          const SizedBox(height: 3),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(time, style: _timeStyle),
              const SizedBox(width: 4),
              Icon(
                message.delivery == ChatMessageDelivery.sent
                    ? Icons.done_rounded
                    : Icons.done_all_rounded,
                size: 14,
                color: message.delivery == ChatMessageDelivery.read
                    ? WhereRuBrand.blue
                    : WhereRuBrand.hint,
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChatAvatar(
          name: participant.name,
          avatarUrl: participant.avatarUrl,
          size: 34,
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              bubble,
              const SizedBox(height: 3),
              Text(time, style: _timeStyle),
            ],
          ),
        ),
      ],
    );
  }
}

/// Centred "Today" pill above the conversation.
class ChatDateSeparator extends StatelessWidget {
  const ChatDateSeparator({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xFFF1F2F9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            height: 1.2,
            color: WhereRuBrand.hint,
          ),
        ),
      ),
    );
  }
}
