import 'package:app/features/chat/domain/chat_domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_repository.g.dart';

@Riverpod(keepAlive: true)
IChatRepository chatRepo(ChatRepoRef ref) => ChatRepository();

/// Deliberately fake: chat persistence and realtime are not implemented, so
/// this returns one clearly labelled sample conversation. Nothing here claims
/// a message was read from or written to a backend.
class ChatRepository implements IChatRepository {
  ChatRepository();

  // TODO(where-ru): replace with the Supabase conversation query/RPC once the
  // backend contract exists. The presentation layer only depends on
  // [IChatRepository], so nothing else changes then.
  @override
  Future<ChatConversation> fetchConversation(String conversationId) async {
    await Future<void>.delayed(const Duration(milliseconds: 80));

    final now = DateTime.now();
    DateTime at(int hour, int minute) =>
        DateTime(now.year, now.month, now.day, hour, minute);

    return ChatConversation(
      id: conversationId,
      participant: const ChatParticipant(
        id: 'user-anagha',
        name: 'Anagha',
        age: 22,
        city: 'Kochi',
        isOnline: true,
      ),
      activity: ChatActivity.teaCoffee,
      schedule: ChatSchedule.todayEvening,
      messages: [
        ChatMessage(
          id: 'message-1',
          text: 'Hi Krishnan! 👋',
          author: ChatMessageAuthor.participant,
          sentAt: at(16, 12),
        ),
        ChatMessage(
          id: 'message-2',
          text: 'Hi! 😊\nNice to meet you here!',
          author: ChatMessageAuthor.me,
          sentAt: at(16, 13),
          delivery: ChatMessageDelivery.read,
        ),
        ChatMessage(
          id: 'message-3',
          text: 'Same here! Are you still up\nfor tea today?',
          author: ChatMessageAuthor.participant,
          sentAt: at(16, 14),
        ),
        ChatMessage(
          id: 'message-4',
          text: 'Yes! Which place do you prefer?',
          author: ChatMessageAuthor.me,
          sentAt: at(16, 15),
          delivery: ChatMessageDelivery.read,
        ),
        ChatMessage(
          id: 'message-5',
          text: "How about Lulu Mall?\nThere's a nice cafe there.",
          author: ChatMessageAuthor.participant,
          sentAt: at(16, 16),
        ),
        ChatMessage(
          id: 'message-6',
          text: 'Sounds good! See you there 😊',
          author: ChatMessageAuthor.me,
          sentAt: at(16, 17),
          delivery: ChatMessageDelivery.read,
        ),
      ],
    );
  }
}
