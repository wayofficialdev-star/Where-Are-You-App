import 'package:app/shared/models/models.dart';

// Repository interfaces are the project convention, even with a single method.
// ignore: one_member_abstracts
abstract class IMeetingsRepository {
  Future<List<Meeting>> fetchMeetings();
}
