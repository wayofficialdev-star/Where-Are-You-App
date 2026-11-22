import 'package:app/features/chat/domain/chat_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_notifier.freezed.dart';
part 'chat_notifier.g.dart';
part 'chat_state.dart';

/// Loads the conversation shown by the chat surface.
///
/// Messaging itself (sending, realtime, attachments) is intentionally absent
/// while the backend is not connected; those methods belong on
/// [IChatRepository] once the contract exists.
@Riverpod(keepAlive: true)
class ChatNotifier extends _$ChatNotifier {
  var _disposed = false;

  @override
  ChatState build(String conversationId) {
    ref.onDispose(() => _disposed = true);
    Future<void>.microtask(_load);
    return const ChatState();
  }

  Future<void> _load() async {
    state = state.copyWith(status: ChatStatus.loading, errorMessage: null);
    try {
      final conversation = await ref
          .read(chatRepoProvider)
          .fetchConversation(conversationId);
      if (_disposed) return;
      state = state.copyWith(
        status: ChatStatus.ready,
        conversation: conversation,
      );
    } catch (error) {
      if (_disposed) return;
      state = state.copyWith(
        status: ChatStatus.failure,
        errorMessage: error.toString(),
      );
    }
  }

  Future<void> reload() async {
    state = const ChatState();
    await _load();
  }
}
