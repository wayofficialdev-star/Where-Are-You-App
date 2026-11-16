import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting.freezed.dart';
part 'meeting.g.dart';

/// A past meeting between the current user and someone they found.
@freezed
class Meeting with _$Meeting {
  const factory Meeting({
    required String id,
    required String name,
    required String activity,
    required DateTime date,
    required String location,
  }) = _Meeting;

  factory Meeting.fromJson(Map<String, dynamic> json) =>
      _$MeetingFromJson(json);
}
