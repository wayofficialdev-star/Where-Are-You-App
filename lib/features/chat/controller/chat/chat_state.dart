part of 'chat_notifier.dart';

enum ChatStatus { loading, ready, failure }

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default(ChatStatus.loading) ChatStatus status,
    ChatConversation? conversation,
    String? errorMessage,
  }) = _ChatState;

  const ChatState._();

  bool get isReady => status == ChatStatus.ready && conversation != null;
}
