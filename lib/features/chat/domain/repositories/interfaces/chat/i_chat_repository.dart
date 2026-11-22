import 'package:app/features/chat/domain/models/chat_models.dart';

// Read side of the chat feature.
//
// TODO(where-ru): add sendMessage, message pagination, attachment upload and
// realtime subscription here once the Supabase contract exists. The
// presentation layer must only ever depend on this interface.
//
// Repository interfaces are the project convention, even with a single method.
// ignore: one_member_abstracts
abstract class IChatRepository {
  Future<ChatConversation> fetchConversation(String conversationId);
}
