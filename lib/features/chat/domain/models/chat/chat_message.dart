import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';

/// Who wrote a message.
enum ChatMessageAuthor { me, participant }

/// Delivery state rendered next to outgoing messages.
enum ChatMessageDelivery { sent, delivered, read }

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String text,
    required ChatMessageAuthor author,
    required DateTime sentAt,
    @Default(ChatMessageDelivery.sent) ChatMessageDelivery delivery,
  }) = _ChatMessage;
}
