import 'package:app/features/chat/domain/models/chat/chat_activity.dart';
import 'package:app/features/chat/domain/models/chat/chat_message.dart';
import 'package:app/features/chat/domain/models/chat/chat_participant.dart';
import 'package:app/features/chat/domain/models/chat/chat_schedule.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_conversation.freezed.dart';

/// Identifier of the sample conversation returned by the mock repository.
///
/// A real match will pass its own conversation id once the backend exists.
const String kDefaultChatConversationId = 'match-anagha';

@freezed
class ChatConversation with _$ChatConversation {
  const factory ChatConversation({
    required String id,
    required ChatParticipant participant,
    required ChatActivity activity,
    required ChatSchedule schedule,
    @Default(<ChatMessage>[]) List<ChatMessage> messages,
  }) = _ChatConversation;
}
