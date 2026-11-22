import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_participant.freezed.dart';

/// The other person in a conversation.
///
/// [avatarUrl] is nullable on purpose: the backend does not provide photos yet,
/// so the UI falls back to the project's initials avatar until it does.
@freezed
class ChatParticipant with _$ChatParticipant {
  const factory ChatParticipant({
    required String id,
    required String name,
    required int age,
    required String city,
    @Default(false) bool isOnline,
    String? avatarUrl,
  }) = _ChatParticipant;
}
